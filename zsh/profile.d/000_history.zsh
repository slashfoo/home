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

# save command start timestamp and duraction in history
setopt extended_history

# don't add commands that start with ' ' (space) to history
setopt hist_ignore_space

# do hist-expansion before executing
setopt hist_verify

# append commands to history incrementally
setopt inc_append_history_time


typeset -gx HISTFILE="${HOME}/.local/history/shell_history"
typeset -gx HISTSIZE=1000000
typeset -gx SAVEHIST="${HISTSIZE}"

command install -v -m 'u=rwx,go=' -d "${HISTFILE:h}"
if [[ ! -e "${HISTFILE}" ]]; then
    command install -v -m 'u=rw,go=' /dev/null "${HISTFILE}"
else
    command chmod -c 'u=rw,go=' "${HISTFILE}"
fi

# show history with formatted timestamp and duration
alias history="fc -l -D -t '%Y-%m-%dT%H:%M:%S'"

# show as many lines of history as will fit on the screen while preserving
# the previous prompt in view
alias h="history -$(( ${LINES:-12} - 2 ))"

# show all lines in the shell history
alias hl="history 1"

# populate commands other shells have saved to the history after the histfile
# was loaded onto memory
alias hr="fc -RI"
