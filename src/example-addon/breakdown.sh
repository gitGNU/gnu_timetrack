#!/bin/bash

# Copyright (C) 2011 Patrik Willard
# 
# This file is part of timetrack
#
# timetrack is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 3
# of the License, or any later version.
#
# timetrack is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with timetrack; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Boston,
# MA  02110-1301, USA.

function breakdown_timetrack_init
{
    declare -a BREAKDOWN_MONTHS_TIMETRACK
    BREAKDOWN_OUTPUT_TIMETRACK="\nMonthly breakdown:\n------------------"
}

function breakdown_timetrack_proc
{
    tmpBreakdownDatetime=$(echo $TMP_DATE_LINE | grep -P -o '^\d+-\d+-\d+ \d+:\d+')
    tmpBreakdownIndex=$(date -d "$tmpBreakdownDatetime" +"%Y%m")
    tmpBreakdownMinutes=$(( $(( $tmpHours * 60)) + $tmpMinutes ))

    BREAKDOWN_MONTHS_TIMETRACK[$tmpBreakdownIndex]=$(( ${BREAKDOWN_MONTHS_TIMETRACK[$tmpBreakdownIndex]} + $tmpBreakdownMinutes ))
}

function breakdown_timetrack_postproc
{
    for ym in ${!BREAKDOWN_MONTHS_TIMETRACK[@]};
    do
        minutes_to_hours "0" "${BREAKDOWN_MONTHS_TIMETRACK[$ym]}"

        tmpLine="${ym:0:4}-${ym:4}: ${tmpHours} hours ${tmpMinutes} minutes"
        BREAKDOWN_OUTPUT_TIMETRACK="${BREAKDOWN_OUTPUT_TIMETRACK}\n${tmpLine}"
    done
}

function breakdown_timetrack_presenter
{
    OUTPUT="${OUTPUT}\n${BREAKDOWN_OUTPUT_TIMETRACK}"
}
