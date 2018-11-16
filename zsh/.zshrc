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

# In the rare event that this file is sourced by a non-interactive shell, stop
# sourcing it.
if [[ ! -o interactive ]]; then
    return
fi

# To be able to extend the functionality of zsh with directives that would
# normally be included in a .zshrc file, source zshrc plug-ins.
#
# zshrc plug-ins loaded by this file are defined as:
# any file terminated in '.zsh' that doesn't start with '.' contained in the
# directories:
#   - "${ZDOTDIR}/profile.d"
#   - "${HOME}/.local/zsh/profile.d"
typeset -a ZSHRC_PLUGINS=(
    "${ZDOTDIR}"/profile.d/*.zsh(#q-N.)
    "${HOME}"/.local/zsh/profile.d/*.zsh(#q-N.)
)
typeset PLUGIN
for PLUGIN in "${(@)ZSHRC_PLUGINS}"; do
    builtin source "${PLUGIN}"
done
unset PLUGIN
unset ZSHRC_PLUGINS

if [[ "${CURRENTLY_PROFILING_ZSHSTARTUP:-}" == "y" ]]; then
    echo "zsh startup log stored at: ${PROFILE_LOG}" >&3

    # Disable prompt_subst and xtrace if they weren't enabled before profiling
    if [[ "${PROFILE_PROMPT_SUBST:-}" == "n" ]]; then
        unsetopt xtrace
    fi
    if [[ "${PROFILE_PROMPT_SUBST:-}" == "n" ]]; then
        unsetopt prompt_subst
    fi

    # Add function profile stats to our profiling log and unload the profiling
    # module
    print "\n\n\n" >&2
    zprof >&2
    zmodload -u zsh/zprof

    # Restore fd#2 to point to whatever it was before the start of profiling
    # and close fd#3
    exec 2>&3
    exec 3>&-
fi

# Remove all variables that are only relevant to profiling declared in .zshenv
unset CURRENTLY_PROFILING_ZSHSTARTUP
unset PROFILE_ZSHSTARTUP
unset PROFILE_LOG
unset PROFILE_PROMPT_SUBST
unset PROFILE_XTRACE

{
    # In this block, PROMPT4 is set to be more visually appealing than the
    # plain version defined in the accompanying .zshenv. It uses the color
    # stored in psvar[1]
    #
    # If psvar[1] is blank or hasn't been defined, it is set to the color white
    if [[ -z "${psvar[1]:-}" ]]; then
        psvar[1]="white"
    fi

    typeset -a PROMPT4_ELEMS=(
      "%F{%1v}"                     # Set foreground color to psvar[1]
      "%B"                          # Start bold
      ">"                           #
      "%b"                          # Stop bold
      " "                           #
      "%D{%Y-%m-%dT%H:%M:%S.%3.%z}" # Timestamp ~ 2017-11-13T14:33:00.123-0800
      " "                           #
      "%B"                          # Start bold
      "%2x"                         # Last 2 elements of filepath being sourced
      "%b"                          # End bold
      ":"                           #
      "%I"                          # Line number
      " "                           #
      "%B"                          # Start bold
      "|"                           #
      "%b"                          # End bold
      " "                           #
      "%f"                          # Reset foreground color
    )
    PROMPT4="${(j::)PROMPT4_ELEMS}"
    unset PROMPT4_ELEMS
} 2>/dev/null

typeset -gx ZSHENV_PATHS_FINALIZED="${EPOCHREALTIME:-DONE}"

TRAPALRM () {
    zle reset-prompt
}
