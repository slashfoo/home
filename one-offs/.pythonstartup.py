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

import atexit
import os
import readline

readline_history_file = os.path.join(
    os.path.expanduser('~'), '.local', 'history', 'python_history'
)
readline_history_length = 999999
with open(readline_history_file, 'a'):
  pass
readline.read_history_file(readline_history_file)

readline.set_history_length(readline_history_length)
atexit.register(readline.write_history_file, readline_history_file)

# vim: ft=python
