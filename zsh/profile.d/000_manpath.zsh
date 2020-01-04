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

if command -v manpath >/dev/null 2>&1; then
    # save a copy of the current manpath
    typeset -a old_manpath=( "${manpath[@]}" )
    manpath=()

    typeset dir=''
    typeset -a sanitized_path=()
    for dir in "${path[@]}"; do
        case "${dir:A}" in
            /home/*|/usr/*|/bin/*|/sbin/*)
                sanitized_path+=( "${dir}" )
                ;;
        esac
    done
    unset dir

    # generate a new manpath with the utility with a crafted PATH variable
    MANPATH=$(env -i PATH="${(j.:.)sanitized_path}" manpath)
    unset sanitized_path

    # append all old entries to the new manpath
    manpath=( "${manpath[@]}" "${old_manpath[@]}" )
    unset old_manpath
fi
