# -*- coding: utf-8 -*-
# Copyright 2018 Jamiel Almeida
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

"""
Python library that provides features to implement all the adjacent scripts
intended to manipulate i3 windows and behaviors.
"""

import collections
import inspect
import logging
import pprint

_BASIC_FORMAT = (
    '%(asctime)s.%(msecs)03d - %(process)d - '
    '%(levelname)-8s - '
    '%(name)s:%(funcName)s - '
    '%(filename)s:%(lineno)-4d - '
    '%(message)s'
)
_BASIC_DATE_FORMAT = (
    '%Y-%m-%dT%H:%M:%S'
)

_BASIC_FORMATTER = logging.Formatter(fmt=_BASIC_FORMAT,
                                     datefmt=_BASIC_DATE_FORMAT)
_STDERR_HANDLER = logging.StreamHandler()
_STDERR_HANDLER.setFormatter(_BASIC_FORMATTER)

_NULL_HANDLER = logging.NullHandler()


def setup_basic_logging():
  if not logging.root.handlers:
    logging.root.addHandler(_STDERR_HANDLER)
    logging.root.setLevel(logging.DEBUG)


def _get_logger(namespace=None):

  if namespace is None:
    frame = inspect.stack()[1]
    module = inspect.getmodule(frame[0])
    try:
      namespace = module.__name__
    except AttributeError:
      namespace = '<unknown>'

  logger = logging.getLogger(namespace)
  logger.addHandler(_NULL_HANDLER)

  return logger


def get_logger(namespace=None):
  setup_basic_logging()
  return _get_logger(namespace=namespace)


LOG = _get_logger()


import json
import os
import subprocess
import shlex


_CACHE = {}
I3MSG_CMD = "i3-msg --socket='{socketpath}' {cmdargs}"


class I3Error(RuntimeError):
  pass


class I3CmdError(I3Error):
  pass


def _run_cmd(cmd):
  LOG.debug('running command: “%s”', cmd)
  cmd_lexed = shlex.split(cmd)
  output_str = subprocess.check_output(cmd_lexed, stderr=open(os.devnull, 'w'))

  output_str = output_str.decode('utf-8').rstrip('\n')

  return output_str


def _i3_msg(cmdargs):
  try:
    socketpath = _CACHE['socketpath']
  except KeyError:
    socketpath = _run_cmd('i3 --get-socketpath')
    _CACHE['socketpath'] = socketpath
  full_cmd = I3MSG_CMD.format(socketpath=socketpath, cmdargs=cmdargs)
  cmd_out_json = _run_cmd(full_cmd)
  cmd_out = json.loads(cmd_out_json)
  return cmd_out


def _i3_cmd(cmdargs):
  cmdargs = "-t command '{}'".format(cmdargs)
  reply = _i3_msg(cmdargs)[0]

  if not reply['success']:
    error_msg = '\n'.join([reply['error'],
                           reply['input'],
                           reply['errorposition']])
    raise I3CmdError(error_msg)

  return reply


def _get_tree():
  return _i3_msg('-t get_tree')


def get_workspaces():
  return _i3_msg('-t get_workspaces')


def get_marks():
  return _i3_msg('-t get_marks')


def get_outputs():
  return _i3_msg('-t get_outputs')


class Node(object):

  def __init__(self, **kwargs):
    super(Node, self).__init__()

    self.__id = kwargs.get('id')

    name = kwargs.get('name')
    if name is None:
      name = '<no_name>'
    self.__name = name.encode('utf-8')

    scratchpad_state = kwargs.get('scratchpad_state')
    if scratchpad_state == 'none':
      scratchpad_state = None
    self.__scratchpad_state = scratchpad_state
    self.__scratched = kwargs.get('scratched', False) or bool(scratchpad_state)

    self.__sticky = kwargs.get('sticky')
    self.__type = kwargs.get('type')
    self.__focused = kwargs.get('focused')
    self.__urgent = kwargs.get('urgent')
    self.__window = kwargs.get('window')
    self.__internal = kwargs.get('internal', False) or name.startswith('__i3')

    self.__fullscreen = bool(kwargs.get('fullscreen_mode'))
    self.focus = []
    self.focus.extend(kwargs.get('focus', []))

    self.marks = sorted(kwargs.get('marks', []))

    self.__nodes = []
    self.__floating_nodes = []

  def add_node(self, new_node):
    self.__nodes.append(new_node)

  def add_floating_node(self, new_node):
    self.__floating_nodes.append(new_node)

  def to_list(self):
    nodes_list = []
    pending = collections.deque()
    pending.append(self)

    while pending:
      current = pending.popleft()
      pending.extend(current.children)
      nodes_list.append(current)

    return nodes_list

  def first_leaf(self, must_be_focused=False):
    pending = collections.deque()
    pending.append(self)

    current = self
    while pending:
      current = pending.popleft()

      if must_be_focused:
        if current.is_leaf and current.is_focused:
          break
      else:
        if current.is_leaf:
          break

      children = {child.id: child for child in current.children}

      children_priority_list = []
      for focus_id in current.focus:
        child = children.pop(focus_id)
        children_priority_list.append(child)

      children_priority_list.extend(children.values())

      pending.extend(children_priority_list)

    if must_be_focused and not current.is_focused:
      current = None

    return current

  def focused_leaf(self):
    leaf = self.first_leaf(True)
    if leaf and not leaf.is_focused:
      leaf = None
    return leaf

  def has_focused_leaf(self):
    return self.focused_leaf() is not None

  @property
  def id(self):
    return self.__id

  @property
  def name(self):
    return self.__name

  @property
  def type(self):
    return self.__type

  @property
  def window(self):
    return self.__window

  @property
  def is_internal(self):
    return self.__internal

  @property
  def is_scratched(self):
    return self.__scratched

  @property
  def is_sticky(self):
    return self.__sticky

  @property
  def is_fullscreen(self):
    return self.__fullscreen

  @property
  def is_urgent(self):
    return self.__urgent

  @property
  def is_focused(self):
    return self.__focused

  @property
  def scratchpad_state(self):
    return self.__scratchpad_state

  @property
  def children(self):
    return self.__nodes + self.__floating_nodes

  @property
  def is_leaf(self):
    return not self.children

  @staticmethod
  def from_dict(**dictionary):
    new_node = Node(**dictionary)
    is_internal = new_node.is_internal
    is_scratched = new_node.is_scratched

    for child in dictionary.get('nodes', []):
      new_node.add_node(Node.from_dict(internal=is_internal,
                                       scratched=is_scratched,
                                       **child))
    for child in dictionary.get('floating_nodes', []):
      new_node.add_floating_node(Node.from_dict(internal=is_internal,
                                                scratched=is_scratched,
                                                **child))

    return new_node

  def __repr__(self):
    string_repr = '<{type}({id})>'.format(
        type=self.type.capitalize(),
        id=self.id,
    )
    return string_repr

  def __str__(self):
    string_repr = self.__repr__() + '(“{name}”)'.format(name=self.name)
    if self.window:
      string_repr += ' #{}'.format(self.window)
    if self.focus:
      string_repr += ' [{}]'.format(', '.join([str(wid) for wid in self.focus]))
    for child in self.children:
      child_repr = child.__str__()
      for line in child_repr.splitlines():
        string_repr += '\n  - ' + line
    return string_repr


def get_tree():
  the_tree = Node.from_dict(**_get_tree())
  return the_tree


def move_to_scratchpad(node):
  move_cmd = '[con_id="{container_id}"] move scratchpad'.format(
      container_id=node.id
  )
  _i3_msg(move_cmd)


def hide_all_visible_scratchpad_windows():
  tree = get_tree()
  for node in tree.to_list():
    if node.scratchpad_state and not node.is_internal:
      move_to_scratchpad(node.children[0])


def focus_mark(target_mark):
  tree = get_tree()

  focused = tree.focused_leaf()
  to_focus = None
  should_focus_mark = False

  for node in tree.to_list():
    if target_mark in node.marks:

      if node.is_leaf:
        to_focus = node
      else:
        should_focus_mark = True
        to_focus = node.first_leaf()

  if focused != to_focus:
    if should_focus_mark:
      _i3_msg('[con_mark="^{}$"] focus'.format(target_mark))
    if to_focus.is_scratched:
      _i3_msg('[con_id="{}"] scratchpad show, focus'.format(to_focus.id))
    else:
      _i3_msg('[con_id="{}"] focus'.format(to_focus.id))
  else:
    if to_focus.is_scratched:
      _i3_msg('[con_id="{}"] move scratchpad'.format(to_focus.id))
