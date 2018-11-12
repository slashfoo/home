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

# short-circuit if the paths have already been "tampered-with" and finalized
# this variable is set at the end of ../.zshrc
[[ -z "${ZSHENV_PATHS_FINALIZED:-}" ]] || return 0

# attempt to add the `scripts` folder on the root of the repository (../../..,
# relative to this file) onto the PATH
typeset SCRIPTS_DIR="${${(%):-%x}:A:h:h:h}/scripts"
if [[ -d "${SCRIPTS_DIR}" ]] && \
   [[ -z "${path[(r)${SCRIPTS_DIR:a}]}" ]]; then
    path=( "${SCRIPTS_DIR:a}" "${path[@]}" )
fi

unset SCRIPTS_DIR
