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

typeset -A aliased_dirs=()

aliased_dirs[R]="${HOME}/Repos"
aliased_dirs[my]="${HOME}/Repos/my"
aliased_dirs[h]="${HOME}/Repos/my/home"
aliased_dirs[i]="${HOME}/Repos/my/infra"
aliased_dirs[n]="${HOME}/Notes"

typeset new_name=''
for new_name in "${(@k)aliased_dirs}"; do
    hash -d "${new_name}"="${aliased_dirs[${new_name}]:a}"
    [[ -o interactive ]] || continue
    mkdir -pv "${aliased_dirs[${new_name}]:a}"
done
unset new_name
unset aliased_dirs
