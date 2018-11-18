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

mkdir --parents --verbose --mode='u=rwx,go=' "${HOME}/.cache/wget"
chmod -R -c 'u=rwX,go=' "${HOME}/.cache/wget"

alias wget="\\wget --hsts-file='${HOME}/.cache/wget/hsts'"
alias mirror='\wget --mirror --page-requisites'
