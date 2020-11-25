#!/usr/bin/env bash
# Pulls sunrise and sunset info from the web
# With thanks to https://sunrise-sunset.org/api

INFO=./todays_info.out
LAT=51.889801
LON=0.901230
curl -s "https://api.sunrise-sunset.org/json?lat=$LAT&lng=$LON&date=today" | \
json_pp > $INFO

# Store in DB
# (this is optional)
#./db-mongo.py
