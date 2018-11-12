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

# removes the default run-help alias to man, and loads the run-help function,
# this function tries to get the right documentation from man, zsh builtins
# and user-defined functions. This is mapped to Esc+H, which is also Alt-H on
# some terminals.

autoload -Uz run-help
unalias run-help 2>/dev/null || true
