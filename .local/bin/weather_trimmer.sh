#!/bin/sh

weather=$(cat /tmp/weather/weather-stat)
weather_count=$(cat /tmp/weather/weather-stat | wc -c)

if [ "$weather_count" -lt 50 ]; then
	echo $weather
else
	echo $(cat /tmp/weather/weather-stat | cut -c1-6)...
fi
