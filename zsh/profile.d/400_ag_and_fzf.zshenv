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
    "${${:-ag}:c:A}"
    '--depth=20'
    "--path-to-ignore=${AG_IGNORE}"
    '--follow'
    '--hidden'
    '--skip-vcs-ignores'
)
alias ag="\\${(j: :)ag_alias}"

typeset -gx FZF_TMUX=0
typeset -gx FZF_COMPLETION_TRIGGER=''

typeset -a fzf_default_opts=(
    '-x'
    '--tiebreak=index'
    '--height=100%'
    '--no-mouse'
    '--inline-info'
    '--prompt=">>> "'
    "--history=${HOME}/.local/history/fzf_history"
    '--history-size=9999999'
    '--filepath-word'
    "--jump-labels='aoeuidhtns-;,.pyfgcrl/\\\$'\"'\"'qjkxbmwvzAOEUIDHTNS_:<>PYFGCRL?|~\"QJKXBMWVZ'"
)
() {
    local -A raw_bind_opts=()
    local -a bind_opts=()
    raw_bind_opts[?]='toggle-preview'
    raw_bind_opts[change]='top'
    raw_bind_opts[tab]='toggle-out'
    raw_bind_opts[btab]='toggle-in'
    raw_bind_opts[f3]='select-all'
    raw_bind_opts[f4]='deselect-all'
    raw_bind_opts[f5]='toggle-all'
    raw_bind_opts[alt-a]='top'
    raw_bind_opts[alt-v]='preview-page-up'
    raw_bind_opts[alt-w]='unix-word-rubout'
    raw_bind_opts[ctrl-j]='beginning-of-line+kill-line+replace-query+beginning-of-line+yank+end-of-line'
    raw_bind_opts[ctrl-k]='kill-line'
    raw_bind_opts[ctrl-n]='down'
    raw_bind_opts[ctrl-o]='unix-word-rubout+yank+yank+backward-delete-char'
    raw_bind_opts[ctrl-p]='up'
    raw_bind_opts[ctrl-r]='previous-history'
    raw_bind_opts[ctrl-s]='next-history'
    raw_bind_opts[ctrl-v]='preview-page-down'
    raw_bind_opts[ctrl-w]='backward-kill-word'
    raw_bind_opts[ctrl-x]='jump'
    raw_bind_opts[ctrl-z]='ignore'
    for what in "${(k)raw_bind_opts[@]}"; do
        bind_opts+=( "${what}:${raw_bind_opts[${what}]}" )
    done
    fzf_default_opts+=( '--bind="'"${(j.,.)bind_opts}"'"' )
}
() {
    local -A raw_color_opts=()
    local -a color_opts=()
    raw_color_opts[fg]='-1'     # Text
    raw_color_opts[bg]='-1'     # Background
    raw_color_opts[hl]='2'      # Highlighted Substrings
    raw_color_opts[fg+]='15'    # Text in current line
    raw_color_opts[bg+]='235'   # Background in current line
    raw_color_opts[hl+]='10'    # Highlighted substrings current line
    raw_color_opts[info]='4'    # Info
    raw_color_opts[prompt]='4'  # Prompt
    raw_color_opts[pointer]='4' # Pointer to the current line
    raw_color_opts[marker]='4'  # Multi-select marker
    raw_color_opts[spinner]='3' # Streaming input indicator
    raw_color_opts[header]='7'  # Header
    for what in "${(k)raw_color_opts[@]}"; do
        color_opts+=( "${what}:${raw_color_opts[${what}]}" )
    done
    fzf_default_opts+=( '--color="'"${(j.,.)color_opts}"'"' )
}
typeset -a fzf_alt_c_opts=(
    "${(@)fzf_default_opts}"
    '--preview="'"${${:-tree}:c:A}"' -C {} | head -200"'
)
typeset -a fzf_ctrl_r_opts=(
    "${(@)fzf_default_opts}"
    '--preview="'"${${:-echo}:c:A}"' {}"'
    '--preview-window="up:99%:wrap:hidden"'
)
typeset -a fzf_ctrl_t_opts=(
    "${(@)fzf_default_opts}"
    '--preview="'"${${:-cat}:c:A}"' -v {}"'
)
typeset -a fzf_completion_opts=(
    "${(@)fzf_default_opts}"
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
