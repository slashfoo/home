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

typeset ZSH_CACHE_DIR="${HOME}/.cache/zsh"
[[ -d "${ZSH_CACHE_DIR}" ]] || install -v -m 'u=rwx,go=' -d "${ZSH_CACHE_DIR}"

# Of the following directories, add them to fpath if they contain functions
# whose filenames start with '_' (underscore)
typeset -a USER_FUNC_DIRS=(
    "${ZDOTDIR}/completions"
    "${HOME}/.local/share/zsh/site-functions"
)
typeset COMPL_FUNC_DIR
for COMPL_FUNC_DIR in "${(aO)USER_FUNC_DIRS[@]}"; do
    typeset -a FUNCS_IN_DIR=( "${COMPL_FUNC_DIR}"/**/_(^*.zwc)(#q-N.) )
    [[ "${#FUNCS_IN_DIR[@]}" -gt 0 ]] || continue
    if [[ -z "${fpath[(r)${COMPL_FUNC_DIR}]}" ]]; then
        fpath=( "${COMPL_FUNC_DIR}" "${fpath[@]}" )
    fi
    typeset FUNC_FILEPATH
    for FUNC_FILEPATH in "${FUNCS_IN_DIR[@]}"; do
        zcompile -Uz "${FUNC_FILEPATH}"
    done
    unset FUNCS_IN_DIR
    unset FUNC_FILEPATH
done
unset COMPL_FUNC_DIR
unset USER_FUNC_DIRS

[[ ! -d "${HOME}/.zcompdumps" ]] || rm -rf "${HOME}/.zcompdumps"

# Initialize zsh completion, and also initialize bash completion for zsh
autoload -Uz compinit
compinit -i -d "${ZSH_CACHE_DIR}/compdump-${HOST}-${ZSH_VERSION}"
autoload -U bashcompinit && bashcompinit -i

# This way the completion script does not have to parse expensive command's
# options repeatedly.
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "${ZSH_CACHE_DIR}"
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # completion ignores case

unset ZSH_CACHE_DIR
