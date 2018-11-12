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

alias gdbd='\gdb --batch --ex run --ex bt --ex q'
alias lldbd='\lldb -b -o run -k "thread backtrace" -k q'
alias valgrind='\valgrind --track-origins=yes --leak-check=full --show-leak-kinds=all --track-fds=yes --time-stamp=yes --malloc-fill=0x01'
alias scheme='\scheme --eehistory "${HOME}/.local/history/scheme_history"'
