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

typeset -i num_procs=1
if command -v nproc >/dev/null 2>&1; then
    num_procs="$(nproc)"
fi

typeset -a erl_aflags=(
    '+P1048576'
    "+A$(( num_procs * 4 ))"
    '+Bc'
    "+S${num_procs}:${num_procs}"
    "+SDcpu${num_procs}:${num_procs}"
    "+SDio$(( num_procs * 4 ))"
    '+Ktrue'
    '-kernel shell_history enabled'
)
typeset -gx ERL_AFLAGS="${(j: :)erl_aflags}"
unset erl_aflags
unset num_procs

typeset -gx MIX_HOME="${HOME}/.local/mix"
typeset -gx HEX_HOME="${HOME}/.local/hex"
if command -v iex >/dev/null 2>&1; then
    mkdir --parents --verbose --mode='u=rwx,go=' "${MIX_HOME}"
    mkdir --parents --verbose --mode='u=rwx,go=' "${HEX_HOME}"
fi
