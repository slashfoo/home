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

if [[ -n "${TMUX:-}" ]]; then
    # TMUX is a well behaved terminal, others have problems with completion
    # and ZLE_RPROMPT_INDENT
    typeset -gx ZLE_RPROMPT_INDENT=0
else
    unset ZLE_RPROMPT_INDENT
fi

# if there's a change in theme, or the theme isn't yet defined, set it to white
theme:color () {
    psvar[1]="${1}"
    psvar[2]="${1}"
    typeset -gx TMUX_COLOR="${1}"
}
typeset -gx THEME_COLOR
[[ -n "${THEME_COLOR:-}" ]] || THEME_COLOR=7
theme:color "${THEME_COLOR}"

typeset FANCY_THEME="${FANCY_TERM-}"
if [[ "${terminfo[colors]:-0}" -ge 256 ]] && [[ -z "${FANCY_THEME:-}" ]]; then
    FANCY_THEME=yes
elif [[ -z "${FANCY_THEME:-}" ]]; then
    FANCY_THEME=no
fi
case "${FANCY_THEME}" in
    y|yes|1)  FANCY_THEME=yes  ;;
    *)        FANCY_THEME=     ;;
esac

typeset -a PROMPT_ELEMS=()
typeset -a RPROMPT_ELEMS=()
typeset -a PROMPT2_ELEMS=()
typeset -a RPROMPT2_ELEMS=()

PROMPT2_ELEMS=(
    '%F{%2v}' # value in psvar[2] set as foreground color
    '... '
    '%f'      # reset foreground color
)
RPROMPT2_ELEMS=(
    '%F{%2v}[%f' # the character [ in the psvar[2] color, and reset
    '%^'         # enclosing operation of the current command line entry
    '%F{%2v}]%f' # the character ] in the psvar[2] color, and reset
)
if [[ -z "${FANCY_THEME:-}" ]]; then
    PROMPT_ELEMS=(
      '%f%b%k'                  # reset fg, bold, bg (respectively)
      '%F{%2v}[%f'              # the char [ in the psvar[2] color, and reset
      '%5(~_%-1~/.../%3~_%~)'   # shortened version of the current working dir
      '%F{%2v}]%f'              # the char ] in the psvar[2] color, and reset
      ' '
      '%B%F{white}%(!.#.$)%f%b' # `#` for root, `$` otherwise, in white
      ' '
    )
    RPROMPT_ELEMS=(
        '%(1j.'                              # if there's at least one job
        '%F{yellow}[#jobs=%f%j%F{yellow}]%f' # number of jobs w/ yellow markers
        ' .)'
        '%(?..'                              # if the last exit code isn't 0
        '%F{red}[$?=%f%?%F{red}]%f '         # exit code w/ red markers
        ')'
        '%F{black}[%f'                       # the char [ in black
        '%F{%2v}%D{%H:%M:%S}%f'              # current time in psvar[2] color
        '%F{black}]%f'                       # the char ] in black
    )
else
    PROMPT_ELEMS=(
        '%f%b%k'              # reset fg, bold, bg (respectively)
        "%F{233}%K{%2v}"      # dark gray on psvar[2] color
        '%B'                  # Start bold
        ' '
        '%4(~.%-1~/…/%2~.%~)' # Short version of the current working dir
        ' '
        '%b'                  # Stop bold
        "%F{%2v}%K{240}"      # psvar[2] color on gray
        $'\uE0B0'             # Fancy right-pointing triangle
        "%F{007}"             # set foreground to white
        ' '
        '%(!.#.$)'            # `#` for root, `$` otherwise
        ' '
        "%F{240}%k"           # gray foreground reset background
        $'\uE0B0'             # Fancy right-pointing triangle
        '%f%k'                # reset fg and bg
        ' '
    )

    # jobs & err
    typeset JOBS_W_ERR=''
    JOBS_W_ERR+='%F{001}%k'      # Red on default bg
    JOBS_W_ERR+=$'\uE0B2'        # Fancy left-pointing triangle
    JOBS_W_ERR+='%F{015}%K{001}' # bright-white on red
    JOBS_W_ERR+='%B $?=%? %b'    # Bolded exit-code prefixed w/ the text `$?=`
    JOBS_W_ERR+='%F{240}%K{001}' # gray on red
    JOBS_W_ERR+=$'\uE0B2'        # Fancy left-pointing triangle
    JOBS_W_ERR+='%F{003}%K{240}' # yellow on gray
    JOBS_W_ERR+='%B #jobs=%j %b' # Bolded number of jobs prefixed w/ `#jobs=`
    JOBS_W_ERR+='%F{242}%K{240}' # light-gray on gray
    JOBS_W_ERR+=$'\uE0B2'        # Fancy left-pointing triangle
    JOBS_W_ERR+='%F{253}%K{242}' # very-light gray on slightly less light gray

    # jobs
    typeset JOBS_NO_ERR=''
    JOBS_NO_ERR+='%F{240}%k'      # gray on default background
    JOBS_NO_ERR+=$'\uE0B2'        # Fancy left-pointing triangle
    JOBS_NO_ERR+='%F{003}%K{240}' # yellow on gray
    JOBS_NO_ERR+='%B #jobs=%j %b' # Bolded number of jobs prefixed w/ `#jobs=`
    JOBS_NO_ERR+='%F{242}%K{240}' # light gray on gray
    JOBS_NO_ERR+=$'\uE0B2'        # Fancy left-pointing triangle
    JOBS_NO_ERR+='%F{253}%K{242}' # very-light gray on slightly less light gray

    # err
    typeset NO_JOBS_W_ERR=''
    NO_JOBS_W_ERR+='%F{001}%k'      # red on default background
    NO_JOBS_W_ERR+=$'\uE0B2'        # Fancy left-pointing triangle
    NO_JOBS_W_ERR+='%F{015}%K{001}' # bright white on red
    NO_JOBS_W_ERR+='%B $?=%? %b'    # Bolded exit-code prefixed w/ `$?=`
    NO_JOBS_W_ERR+='%F{242}%K{001}' # light gray on red
    NO_JOBS_W_ERR+=$'\uE0B2'        # Fancy left-pointing triangle
    NO_JOBS_W_ERR+='%F{253}%K{242}' # v. light gray on slightly less light gray

    # no jobs, no err
    typeset NO_JOBS_NO_ERR=''
    NO_JOBS_NO_ERR+='%F{242}%k'      # light gray on default background
    NO_JOBS_NO_ERR+=$'\uE0B2'        # Fancy left-pointing triangle
    NO_JOBS_NO_ERR+='%F{253}%K{242}' # v. light gray on less light gray

    # Populate the right-prompt elements with the corresponding
    # "are there jobs?" and "was the last exit code non-zero?" combination
    # as defined above. Along with the timestamp and fg+bg reset
    RPROMPT_ELEMS=(
        "%(1j."
        "%(?.${JOBS_NO_ERR}.${JOBS_W_ERR})."
        "%(?.${NO_JOBS_NO_ERR}.${NO_JOBS_W_ERR})"
        ")"
        ' '
        '%D{%H:%M:%S}'
        ' '
        '%f%k'
    )
    unset JOBS_NO_ERR
    unset JOBS_W_ERR
    unset NO_JOBS_NO_ERR
    unset NO_JOBS_W_ERR
fi
unset FANCY_THEME

typeset -g PROMPT="${(j::)PROMPT_ELEMS}"
typeset -g RPROMPT="${(j::)RPROMPT_ELEMS}"
typeset -g PROMPT2="${(j::)PROMPT2_ELEMS}"
typeset -g RPROMPT2="${(j::)RPROMPT2_ELEMS}"

unset PROMPT_ELEMS
unset RPROMPT_ELEMS
unset PROMPT2_ELEMS
unset RPROMPT2_ELEMS

# set tmux's or terminal emulator's title for the enclosing window
term-title () {
    [[ "${#}" -gt 0 ]] || set -- "${TERM}"
    echo -ne $'\033]0;'"${@}"'\a' || :
}

# Intended to be run before each prompt, set the title to the current working
# directory
prompt:set-title-precmd () {
    term-title "${SHELL}: ${PWD}"
}
precmd_functions+=( prompt:set-title-precmd )

# Intended to be run before a command gets executed, set the title to that
# command
prompt:set-title-preexec () {
    local -a cmd=( "${(z)1}" )
    term-title "${cmd[1]:t} ${cmd[2,-1]}"
}
preexec_functions+=( prompt:set-title-preexec )
