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

# Set environment variables to enable the use libraries and includes installed
# in the user's home

if command -v pkg-config >/dev/null 2>&1; then
    [[ -z "${PKG_CONFIG_PATH:-}" ]] || PKG_CONFIG_PATH="${PKG_CONFIG_PATH}:"
    PKG_CONFIG_PATH="${PKG_CONFIG_PATH}$(
        pkg-config --variable pc_path pkg-config
    )"
fi

[[ -d "${HOME}/.local/lib/pkgconfig" ]] && \
    pkg_config_path=(
        "${HOME}/.local/lib/pkgconfig"
        ${(@)pkg_config_path}
    )

typeset -a potential_lib_paths=(
    "${HOME}/.local/lib"
    "${HOME}/.local/lib64"
    "${HOME}/.local/libexec/gcc"/*/*(#q/nOnY1N)
    "${HOME}/.local/lib/gcc"/*/*/plugin(#q/nOnY1N)
)

typeset lib_path
for lib_path in "${potential_lib_paths[@]}"; do
    [[ -d "${lib_path}" ]] || continue
    ld_library_path+=( "${lib_path}" )
    ldflags+=( "-L${lib_path}" )
done
unset lib_path
unset potential_lib_paths

typeset -a potential_include_paths=(
    "${HOME}/.local/include"
)
typeset include_path
for include_path in "${potential_include_paths[@]}"; do
    [[ -d "${include_path}" ]] || continue
    cflags+=( "-I${include_path}" )
    cppflags+=( "-I${include_path}" )
done
unset include_path
unset potential_include_paths
