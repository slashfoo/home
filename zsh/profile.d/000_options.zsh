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

# This file contains options that should only be available to interactive
# sessions of zsh

# Documentated on `man 1 zshoptions`

setopt auto_cd
setopt auto_pushd
setopt cdable_vars
setopt complete_in_word
setopt dvorak
setopt interactive_comments
setopt glob_dots
setopt path_dirs
setopt pushd_ignore_dups
setopt pushd_silent

unsetopt unset
unsetopt flow_control
unsetopt pushd_to_home
