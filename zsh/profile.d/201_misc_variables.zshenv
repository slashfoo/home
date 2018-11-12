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

typeset -gx BACKUP_DIRECTORY="${BACKUP_DIRECTORY:-${HOME}/Backup}"
typeset -gx STOW_HOME="${STOW_HOME:-${HOME}/.local/stow_home}"
typeset -gx BOTO_CONFIG="${HOME}/.config/boto.config"

[[ -o interactive ]] || return
mkdir -pv "${BACKUP_DIRECTORY}"
mkdir -pv "${STOW_HOME}"
mkdir -pv "${BOTO_CONFIG:h}"
