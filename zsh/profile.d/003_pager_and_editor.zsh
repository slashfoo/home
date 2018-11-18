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

[[ "${PAGER:-}" == *"/less" ]] || return

# Documented in `man 1 less` and `man 1 lesskey`
typeset -gx LESSKEY="${LESSKEY:-${HOME}/.local/dot_less}"
if command -v lesskey >/dev/null 2>&1; then

    typeset THIS_DIR="${${(%):-%x}:A:h}"
    typeset DOT_LESSKEY="${THIS_DIR:h:h}/one-offs/.lesskey"
    unset THIS_DIR

    if [[ ! -r "${LESSKEY}" ]] || \
        [[ "${LESSKEY}" -ot "${DOT_LESSKEY}"  ]]; then
        mkdir --parents --verbose --mode='u=rwx,go=' "${LESSKEY:h}"
        command lesskey "${DOT_LESSKEY}"
    fi
    unset DOT_LESSKEY
fi
