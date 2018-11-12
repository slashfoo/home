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

# If we have the `tabs` command, clear the current tabs set on the terminal,
# and set the first 12 be:
#   - first tabstop is on the first character of the line
#   - second tabstop is short (4 spaces after the first)
#   - the other 10 are set 8 characters after the previous
command -v tabs >/dev/null 2>&1 || return
{
    command tabs 1,5,+8,+8,+8,+8,+8,+8,+8,+8,+8,+8 >/dev/null
} 2>/dev/null
