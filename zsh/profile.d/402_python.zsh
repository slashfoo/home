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

typeset -gxTU PYTHONPATH="${PYTHONPATH:-}" pythonpath ':'

typeset -gx VIRTUAL_ENV_DISABLE_PROMPT=1

typeset -gx PYTHONSTARTUP="${PYTHONSTARTUP:-}"
typeset THIS_DIR="${${(%):-%x}:A:h}"
[[ -n "${PYTHONSTARTUP}" ]] || \
    PYTHONSTARTUP="${THIS_DIR:h:h}/one-offs/.pythonstartup.py"
unset THIS_DIR


typeset -gx PIPENV_CACHE_DIR="${HOME}/.local/pipenv"
typeset -gx PIPENV_VENV_IN_PROJECT=yes

mkdir --parents --verbose --mode='u=rwx,go=' "${PYTHONSTARTUP:h}"
mkdir --parents --verbose --mode='u=rwx,go=' "${PIPENV_CACHE_DIR}"

if [[ -z "${YAPF_STYLE:-}" ]]; then
    typeset -gx YAPF_STYLE="pep8"
fi
