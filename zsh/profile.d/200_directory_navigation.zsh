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

alias ls='\ls --color=tty -A -F --group-directories-first'

shell:custom-pushd () {
    local return_code

    builtin pushd "${@}"
    return_code="${?}"

    [[ "${return_code}" -eq 0 ]] && dirs -v
    return "${return_code}"
}
alias pushd='shell:custom-pushd'

shell:custom-popd () {
    local return_code

    builtin popd "${@}"
    return_code="${?}"

    [[ "${return_code}" -eq 0 ]] && dirs -v
    return "${return_code}"
}
alias popd='shell:custom-popd'

alias md='mkdir -pv'
alias rd='rmdir -v'

alias cd='pushd'
alias -- +='pushd'
alias -- -='popd'

# Create directories and go into the first
mcd () {
    [[ "${#}" -ne 0 ]] || return 1

    local first_dir="${1}"
    mkdir -pv "${@}" || return "${?}"
    pushd "${first_dir}" || return "${?}"
}

# Create a temporary directory and go into it
cdt () {
    local throwaway_dir="$(
        mktemp -p "${TMPDIR:-/tmp}" -d throwaway.XXXXXXXXXX
    )"
    if [[ -d "${throwaway_dir}" ]]; then
        typeset -gx THROWAWAY_DIR="${throwaway_dir}"
        pushd "${THROWAWAY_DIR}"
    else
        return 1
    fi
}

# Leave the temporary directory and delete it
rmt () {
    [[ -n "${THROWAWAY_DIR:-}" ]] || return 1
    [[ -d "${THROWAWAY_DIR:-}" ]] || return 1
    while [[ "${PWD}" == "${THROWAWAY_DIR}"* ]]; do
        popd || {
            cd "${HOME}"
            break
        }
    done

    rm -rvf "${THROWAWAY_DIR}"
    unset THROWAWAY_DIR
}

alias d='builtin dirs -v'

if command -v tree >/dev/null 2>&1; then

    typeset TREE_SHORT='\tree -a -F -l --noreport --dirsfirst'
    alias l="${TREE_SHORT} -L 1"
    alias l2="${TREE_SHORT} -L 2 -I '.git|.hg|.venv'"
    alias l3="${TREE_SHORT} -L 3 -I '.git|.hg|.venv'"
    alias l4="${TREE_SHORT} -L 4 -I '.git|.hg|.venv'"
    alias l5="${TREE_SHORT} -L 5 -I '.git|.hg|.venv'"

    typeset TREE_LONG="${TREE_SHORT} -phug --du --timefmt ${TREE_TIMEFMT}"
    alias ll="${TREE_LONG} -L 1"
    alias ll2="${TREE_LONG} -L 2 -I '.git|.hg|.venv'"
    alias ll3="${TREE_LONG} -L 3 -I '.git|.hg|.venv'"
    alias ll4="${TREE_LONG} -L 4 -I '.git|.hg|.venv'"
    alias ll5="${TREE_LONG} -L 5 -I '.git|.hg|.venv'"

    unset TREE_SHORT
    unset TREE_LONG

else
    alias l='ls'
    alias ll='ls -l'
fi
