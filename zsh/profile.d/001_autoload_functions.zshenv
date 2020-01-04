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

autoload -Uz zargs
if [[ -d "${HOME}/.local/share/zsh/site-functions" ]]; then
    fpath=( "${HOME}/.local/share/zsh/site-functions" "${fpath[@]}" )
fi

# for the following set of folders, add them to fpath if they contain at least
# one function, and "autoload" it with `autoload -Uz $funcname`.
#
# U causes it to ignore alias definitions when a command is used inside the
# function, making the functions more portable.
# z causes it to behave as zsh (in case ksh emulation is set).

typeset -a USER_FUNC_DIRS=(
    "${ZDOTDIR}/functions"
    "${HOME}/.local/zsh/functions"
)

typeset FUNC_DIR=''
for FUNC_DIR in "${(aO)USER_FUNC_DIRS[@]}"; do
    typeset -a FUNCS_IN_DIR=( "${FUNC_DIR}"/**/(^*.zwc)(#q-N.) )
    [[ "${#FUNCS_IN_DIR[@]}" -gt 0 ]] || continue
    if [[ -z "${fpath[(r)${FUNC_DIR}]:-}" ]]; then
        fpath=( "${FUNC_DIR}" "${fpath[@]}" )
    fi
    typeset FUNC_FILE=''
    for FUNC_FILE in "${FUNCS_IN_DIR[@]}"; do
        autoload -Uz "${FUNC_FILE:t}"
    done
    unset FUNC_FILE
    unset FUNCS_IN_DIR
done
unset FUNC_DIR
unset USER_FUNC_DIRS
