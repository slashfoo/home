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

typeset -gx AG_IGNORE="${HOME}/.agignore"
if [[ ! -r "${AG_IGNORE}" ]]; then

    typeset THIS_DIR="${${(%):-%x}:A:h}"
    AG_IGNORE="${THIS_DIR:h:h}/one-offs/.agignore"
    unset THIS_DIR

fi

typeset -a ag_alias=(
    'ag'
    '--depth=20'
    "--path-to-ignore=${AG_IGNORE}"
    '--follow'
    '--hidden'
    '--skip-vcs-ignores'
)
alias ag="\\${(j: :)ag_alias}"

typeset -gx FZF_TMUX=0
typeset -gx FZF_COMPLETION_TRIGGER='~~'

typeset -a fzf_default_opts=(
    '-x'
    '--tiebreak=index'
    '--height=100%'
    '--no-mouse'
    '--inline-info'
    '--prompt=">>> "'
    "--history=${HOME}/.local/history/fzf_history"
    '--history-size=9999999'
    '--bind="f3:toggle-all"'
)
typeset -a fzf_alt_c_opts=(
    "${(@)fzf_default_opts}"
    '--preview="tree -C {} | head -200"'
)
typeset -a fzf_ctrl_r_opts=(
    "${(@)fzf_default_opts}"
    '--preview="echo {}"'
    '--preview-window="up:3:hidden:wrap"'
    '--bind="?:toggle-preview"'
)
typeset -a fzf_ctrl_t_opts=(
    "${(@)fzf_default_opts}"
    '--preview="cat -v {}"'
)
typeset -a fzf_completion_opts=(
    "${(@)fzf_default_opts}"
    '--preview="cat -v {}"'
)

typeset -gx FZF_DEFAULT_OPTS="${(j: :)fzf_default_opts}"
typeset -gx FZF_ALT_C_OPTS="${(j: :)fzf_alt_c_opts}"
typeset -gx FZF_CTRL_R_OPTS="${(j: :)fzf_ctrl_r_opts}"
typeset -gx FZF_CTRL_T_OPTS="${(j: :)fzf_ctrl_t_opts}"
typeset -gx FZF_COMPLETION_OPTS="${(j: :)fzf_completion_opts}"

if command -v ag >/dev/null 2>&1; then

    typeset -a fzf_default_command=(
        "${(@)ag_alias}"
        '--nocolor'
        '--files-with-matches'
        '-g'
        '""'
    )
    typeset -gx FZF_DEFAULT_COMMAND="${(j: :)fzf_default_command}"
fi
if [[ -n "${FZF_DEFAULT_COMMAND:-}" ]]; then
    typeset -gx FZF_CTRL_T_COMMAND="${FZF_DEFAULT_COMMAND}"
fi

unset ag_alias
unset fzf_alt_c_opts
unset fzf_completion_opts
unset fzf_ctrl_r_opts
unset fzf_ctrl_t_opts
unset fzf_default_command
unset fzf_default_opts

typeset fzf_default_completion="${fzf_default_completion:-expand-or-complete}"
