#!/bin/sh

tmp_weather="/tmp/weather"
tmp_weather_stat=$tmp_weather/weather-stat
tmp_weather_degree=$tmp_weather/weather-degree
tmp_weather_quote=$tmp_weather/weather-quote
tmp_weather_icon=$tmp_weather/weather-icon

if [ ! -d $tmp_weather ]; then
    mkdir -p $tmp_weather
fi

# Put in your api and stuff link here
# If you dunno, head to openweathermap.org, and make and account
#(completely free I swear, and then get your API Key and  your City ID)
# I wish I was smart enough to do it like Elena, but this is the top I could do lol
KEY="b4b2cdde83a8a5f8d5690cb28bd722f1"
ID="4347778"
UNIT="imperial" #Options are 'metric' and 'imperial'
weather=$(curl -sf "http://api.openweathermap.org/data/2.5/weather?APPID="$KEY"&id="$ID"&units="$UNIT"")
echo $weather
if [ ! -z "$weather" ]; then
    weather_temp=$(echo "$weather" | jq ".main.temp" | cut -d "." -f 1)
    weather_icon_code=$(echo "$weather" | jq -r ".weather[].icon" | head -1)
    weather_description=$(echo "$weather" | jq -r ".weather[].description" | head -1 | sed -e "s/\b\(.\)/\u\1/g")

    #Big long if statement of doom
    if [ "$weather_icon_code" = "50d" ]; then
        weather_icon=" "
        weather_quote="Forecast says it's misty \nMake sure you don't get lost on your way..."
    elif [ "$weather_icon_code" = "50n" ]; then
        weather_icon=" "
        weather_quote="Forecast says it's a misty night \nDon't go anywhere tonight or you might get lost..."
    elif [ "$weather_icon_code" = "01d" ]; then
        weather_icon=" "
        weather_quote="It's a sunny day, gonna be fun! \nDon't go wandering all by yourself though..."
    elif [ "$weather_icon_code" = "01n" ]; then
        weather_icon=" "
        weather_quote="It's a clear night \nYou might want to take a evening stroll to relax..."
    elif [ "$weather_icon_code" = "02d" ]; then
        weather_icon=" "
        weather_quote="It's  cloudy, sort of gloomy \nYou'd better get a book to read..."
    elif [ "$weather_icon_code" = "02n" ]; then
        weather_icon=" "
        weather_quote="It's a cloudy night \nHow about some hot chocolate and a warm bed?"
    elif [ "$weather_icon_code" = "03d" ]; then
        weather_icon=" "
        weather_quote="It's  cloudy, sort of gloomy \nYou'd better get a book to read..."
    elif [ "$weather_icon_code" = "03n" ]; then
        weather_icon=" "
        weather_quote="It's a cloudy night \nHow about some hot chocolate and a warm bed?"
    elif [ "$weather_icon_code" = "04d" ]; then
        weather_icon=" "
        weather_quote="It's  cloudy, sort of gloomy \nYou'd better get a book to read..."
    elif [ "$weather_icon_code" = "04n" ]; then
        weather_icon=" "
        weather_quote="It's a cloudy night \nHow about some hot chocolate and a warm bed?"
    elif [ "$weather_icon_code" = "09d" ]; then
        weather_icon=" "
        weather_quote="It's rainy, it's a great day! \nGet some ramen and watch as the rain falls..."
    elif [ "$weather_icon_code" = "09n" ]; then
        weather_icon=" "
        weather_quote=" It's gonna rain tonight it seems \nMake sure your clothes aren't still outside..."
    elif [ "$weather_icon_code" = "10d" ]; then
        weather_icon=" "
        weather_quote="It's rainy, it's a great day! \nGet some ramen and watch as the rain falls..."
    elif [ "$weather_icon_code" = "10n" ]; then
        weather_icon=" "
        weather_quote=" It's gonna rain tonight it seems \nMake sure your clothes aren't still outside..."
    elif [ "$weather_icon_code" = "11d" ]; then
        weather_icon=""
        weather_quote="There's storm for forecast today \nMake sure you don't get blown away..."
    elif [ "$weather_icon_code" = "11n" ]; then
        weather_icon=""
        weather_quote="There's gonna be storms tonight \nMake sure you're warm in bed and the windows are shut..."
    elif [ "$weather_icon_code" = "13d" ]; then
        weather_icon=" "
        weather_quote="It's gonna snow today \nYou'd better wear thick clothes and make a snowman as well!"
    elif [ "$weather_icon_code" = "13n" ]; then
        weather_icon=" "
        weather_quote="It's gonna snow tonight \nMake sure you get up early tomorrow to see the sights..."
    elif [ "$weather_icon_code" = "40d" ]; then
        weather_icon=" "
        weather_quote="Forecast says it's misty \nMake sure you don't get lost on your way..."
    elif [ "$weather_icon_code" = "40n" ]; then
        weather_icon=" "
        weather_quote="Forecast says it's a misty night \nDon't go anywhere tonight or you might get lost..."
    else
        weather_icon=" "
        weather_quote="Sort of odd, I don't know what to forecast \nMake sure you have a good time!"
    fi
    echo "$weather_icon" >$tmp_weather_icon
    echo "$weather_description" >$tmp_weather_stat
    echo "$weather_temp""°F" >$tmp_weather_degree
    echo "$weather_quote" >$tmp_weather_quote
    echo "$weather_hex" >$tmp_weather_hex
else
    echo "Weather Unavailable" >$tmp_weather_stat
    echo " " >$tmp_weather_icon
    echo "Ah well, no weather huh? \nEven if there's no weather, it's gonna be a great day!" >$tmp_weather_quote
    echo "-" >$tmp_weather_degree
fi
