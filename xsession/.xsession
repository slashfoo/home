#!/usr/bin/env zsh
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


[[ -r "${HOME}/.local/xsession.local.zsh" ]] && \
    source "${HOME}/.local/xsession.local.zsh"

systemctl --user import-environment PATH DBUS_SESSION_BUS_ADDRESS
systemctl --no-block --user start xsession.target

xrandr --dpi 96
typeset TIMESTAMP_FMT='%D{%Y%m%dT%H%M%S}'
typeset I3_LOGFILE="${HOME}/.local/log/i3-${(%)TIMESTAMP_FMT}.log"

mkdir --parents --mode='u=rwx,go=' "${HOME}/.local/log"
install --verbose --mode='u=rw,go=' /dev/null "${I3_LOGFILE}"

exec i3 >>"${I3_LOGFILE}" 2>&1
