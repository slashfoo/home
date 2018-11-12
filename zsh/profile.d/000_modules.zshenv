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

# Documentated on `man 1 zshmodules`

zmodload 'zsh/datetime' # Some date/time commands and parameters
zmodload 'zsh/sched'    # Timed execution within the shell
zmodload 'zsh/system'   # Interfacing with various low-level system features
zmodload 'zsh/terminfo' # Interfacing with the terminfo database
zmodload 'zsh/zpty'     # Pseudo-terminal construct management
zmodload 'zsh/zutil'    # Utility builtins
