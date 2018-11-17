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

# If outside of tmux and we have something in the DISPLAY environment variable,
# write it to the ~/.local/last_display file, otherwise unset DISPLAY and
# delete that file

if [[ -z "${TMUX:-}" ]]; then
    mkdir --parents --mode 'u=rwx,go=' "${HOME}/.local"
    typeset -gx DISPLAY="${DISPLAY:-}"
    if [[ -n "${DISPLAY}" ]]; then
        install -m 'u=rw,go=' <(echo "${DISPLAY}") \
            "${HOME}/.local/last_display"
    else
        rm -vf "${HOME}/.local/last_display"
        unset DISPLAY
    fi
fi
