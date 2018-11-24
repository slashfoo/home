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

# This file contains options that should be available to all zsh instances
# (includes non-interactive shells/scripts)

# Documentated on `man 1 zshoptions`

setopt auto_continue
setopt local_options
setopt numeric_glob_sort
setopt pipe_fail

() {
    # in case of Windows WSL, work around an annoyance when backgrounding
    # processes documented in: https://github.com/Microsoft/WSL/issues/1887
    unsetopt local_options
    local platform="$(uname -a 2>/dev/null)"
    if [[ "${platform}" == *"Microsoft"* ]]; then
        unsetopt bg_nice
    fi
} >/dev/null
