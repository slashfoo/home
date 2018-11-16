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

{
    # This sets the prompt4 without echoing to the screen even in the event of
    # using the 'xtrace' option. This way, everything that follows as part of
    # the execution of this shell initialization will be prefixed with this
    # timestamp. This is done mostly for profiling purposes.
    #
    # The format used is seconds.microseconds since epoch, and it is set to
    # something more visually appealing at the end of .zshrc
    PROMPT4="%D{%s.%6.}:%x:%I: "
} 2>/dev/null

typeset CURRENTLY_PROFILING_ZSHSTARTUP="n"
typeset PROFILE_ZSHSTARTUP="${PROFILE_ZSHSTARTUP:-n}"
typeset PROFILE_LOG=""
typeset PROFILE_PROMPT_SUBST="n"
typeset PROFILE_XTRACE="n"

typeset -a psvar=()
typeset -a precmd_functions=()
typeset -a preexec_functions=()

if [[ "${PROFILE_ZSHSTARTUP:-}" == "y" ]]; then
    # Notes on profiling zsh startup in this manner:
    #
    # The settings inside this block are undone/restored at the end of the
    # accompanying .zshrc
    #
    # /etc/zsh/zshenv is read before anything from this file is sourced. Keep
    # the contents of that file very lightweight if possible. The accuracy of
    # the startup time from profiling will be contingent on the time taken to
    # source /etc/zsh/zshenv.
    CURRENTLY_PROFILING_ZSHSTARTUP=y
    zmodload zsh/zprof

    # Anonymous function to create a profile log. It gets executed immediately
    () {
        local ts_format="%D{%Y%m%dT%H%M%S.%6.}"
        PROFILE_LOG="${TMPDIR:-/tmp}/zshstartup.${(%)ts_format}"
        install -m 'u=rw,go=' /dev/null "${PROFILE_LOG}"
    }

    # In order to return prompt_subst and xtrace options to what they are
    # originally, their values are saved before the options are set.
    if [[ -o promptsubst ]]; then
        PROFILE_PROMPT_SUBST=y
    fi
    if [[ -o xtrace ]]; then
        PROFILE_XTRACE=y
    fi
    setopt prompt_subst
    setopt xtrace

    # In order to be able to restore the location of fd#2, point fd#3 to the
    # current location of fd#2 before pointing fd#2 to the log file defined
    # above.
    exec 3>&2
    exec 2>>"${PROFILE_LOG}"
fi

# Prevent loading of the files below, as per `man 1 zshoptions`.
# Files not loaded:
#   - /etc/zsh/zshprofile
#   - /etc/zsh/zshrc
#   - /etc/zsh/zlogin
#   - /etc/zsh/zlogout
#
# /etc/zsh/zshenv is still loaded
unsetopt global_rcs

# allow for fancy globs
setopt extended_glob

# ZDOTDIR is modified so that subsequent zsh rc-files are the ones adjacent to
# this .zshenv file.
#
# ZDOTDIR is set to the current absolute real physical (:A) path of the
# directory containing (:h) this file (%x).
#
# Further reading:
#   - (%) is documented in `man 1 zshexpn` under "parameter expansion flags"
#   - %x is documented in `man 1 zshmisc` under "simple prompt escapes"
#   - :h and :A are documented in `man 1 zshexpn` under "history expansion >
#     modifiers"
#
# The usefulness of this, is that it enable the utilization of this set of zsh
# RC files by only requiring sym-linking the current file to ${HOME}/.zshenv,
# and so, avoid unnecessary ${HOME} dot-file pollution.
typeset -gx ZDOTDIR="${${(%):-%x}:A:h}"

# To be able to extend the functionality of zsh with directives that would
# normally be included in a .zshenv file, source zshenv plug-ins.
#
# zshenv plug-ins loaded by this file are defined as:
# any file terminated in '.zshenv' that doesn't start with '.' contained in the
# directories:
#   - "${ZDOTDIR}/profile.d"
#   - "${HOME}/.local/zsh/profile.d"
typeset -a ZSHENV_PLUGINS=(
    "${ZDOTDIR}"/profile.d/*.zshenv(#q-N.)
    "${HOME}"/.local/zsh/profile.d/*.zshenv(#q-N.)
)
typeset PLUGIN
for PLUGIN in "${(@)ZSHENV_PLUGINS}"; do
    builtin source "${PLUGIN}"
done
unset PLUGIN
unset ZSHENV_PLUGINS
