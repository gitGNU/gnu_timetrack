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

# Naming convention:
# In order for all this to work out, we must all work to ensure that there are
# no function or variable name collisions
# To do this (while there is no way of enforcing it) any add-on developers are
# strongly urged to follow the naming convention outlined here:
#
# There are five functions an add-on can specify which will be called by
# timestats:
#
# <ADDON>_timetrack_init
# <ADDON>_timetrack_proc
# <ADDON>_timetrack_postproc
# <ADDON>_timetrack_presenter
#
# where <ADDON> SHALL BE the lowercased version of the filename (without the
# extension, e.g. cost.sh == cost_timetrack_*)
#
# All variables defined inside the add-on SHALL BE named
# <ADDON>_YOUR_VARIABLE_NAME_FOLLOWED_BY_TIMETRACK (e.g. COST_RATE_TIMETRACK)
#
# <ADDON> here, however, shall be the UPPERCASE version of the filename (without
# the extension, e.g. cost.sh == COST_*_TIMETRACK)
#
# Temporary variables (used only within a function, or a loop) have been named
# according to "tmpCamelCase", and it should be safe to overwrite any of these
# (with the clear understanding that your add-on cannot rely on these to
# maintain thier values between function calls (i.e. other variables or tstats
# may overwrite them.

# function used to initialize variables which should be used during the
# execution of timestats
# we can assume that when this function is called, both ~/.timetrack.rc and the
# project-specific (local) configuration file $TTD/.timetrack.rc has been
# sourced. If neither of them have defined a RATE variable, then this is most
# likely a pro bono project, and as such, calculating the COST is irrelevant
function cost_timetrack_init
{
    continue
}

# function called inside the script main loop (if you want to do additional
# processing on the temporary variable(s) available only during a single
# iteration of the loop, this is the function to place functionality in
function cost_timetrack_proc
{
    continue
}

# function used to perform any postprocessing after the script main loop has
# ended and timestats has set up result variables
function cost_timetrack_postproc
{
    if [ ! -z "$COST_RATE_TIMETRACK" ];
    then
        if [ "$MINUTES" -ge 30 ];
        then
            COST_SUM_TIMETRACK=$(( (${HOURS} + 1) * ${COST_RATE_TIMETRACK} ))
        else
            COST_SUM_TIMETRACK=$(( ${HOURS} * ${COST_RATE_TIMETRACK} ))
        fi
    fi
}

# function which should only serve to extend timestatss $OUTPUT variable
# Do NOT overwrite this variable, or may rabid weresquirrels haunt you!
function cost_timetrack_presenter
{
    if [ ! -z "$COST_RATE_TIMETRACK" ];
    then
        OUTPUT="${OUTPUT}\n\nTotal cost: $COST_SUM_TIMETRACK"
    fi
}
