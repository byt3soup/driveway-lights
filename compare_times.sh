#!/usr/bin/env bash

# Logfile and times
LOGFILE=./sunset.log
logtime=$(date +'%Y-%m-%d %H:%M:%S')

# Timezone offset
TZONE=$(date +%Z)
if [ "$TZONE" = "BST" ]; then
    OFFSET=3600
else
    OFFSET=0
fi

# Calculate sunset times
sunset_utc=$(grep "sunset" todays_info.out | cut -d\" -f4)
sunset_ts=$(($(date -d "$sunset_utc" +%s) + $OFFSET)) # sunset timestamp
current_ts=$(date +%s) # current timestamp
sunset=$(date -d @$sunset_ts +'%Y-%m-%d %H:%M:%S')

# If the current timestamp > sunset timestamp
# switch on the lights
if (( "$current_ts" > "$sunset_ts" )); then
    echo "$logtime - sunset was at $sunset. Switching lights on." >> $LOGFILE
    /home/pi/driveway-lights/sockets/control.py 1 on &> /dev/null
else
    echo "$logtime - sunset is at $sunset. Not switching lights on yet." >> $LOGFILE
fi
