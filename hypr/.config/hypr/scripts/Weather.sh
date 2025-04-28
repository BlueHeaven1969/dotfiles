#!/bin/bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# weather info from wttr. https://github.com/chubin/wttr.in
# Remember to add city 

city=KLWM
cachedir=~/.cache/rbn
cachefile=weather_cache_$city
cacheage=9999
max_cacheage=1740

if [ ! -d $cachedir ]; then
    mkdir -p $cachedir
fi

if [ ! -f $cachedir/$cachefile ]; then
    touch $cachedir/$cachefile
else
    cacheage=$(($(date +%s) - $(stat -c '%Y' "$cachedir/$cachefile")))
fi

if [ $cacheage -gt $max_cacheage ]; then
    curl -s https://forecast.weather.gov/xml/current_obs/$city.xml > $cachedir/$cachefile
fi

temp=$(xml_grep --text_only 'temp_f' $cachedir/$cachefile)
temperature=${temp%.*}
currcond=$(xml_grep --text_only 'weather' $cachedir/$cachefile)

# https://fontawesome.com/icons?s=solid&c=weather
case $(echo "${currcond}" | tr '[:upper:]' '[:lower:]') in
"clear" | "sunny")
    condition=""
    ;;
"partly cloudy")
    condition="󰖕"
    ;;
"cloudy")
    condition=""
    ;;
"overcast")
    condition=""
    ;;
"fog" | "freezing fog")
    condition=""
    ;;
"patchy rain possible" | "patchy light drizzle" | "light drizzle" | "patchy light rain" | "light rain" | "light rain shower" | "mist" | "rain")
    condition="󰼳"
    ;;
"moderate rain at times" | "moderate rain" | "heavy rain at times" | "heavy rain" | "moderate or heavy rain shower" | "torrential rain shower" | "rain shower")
    condition=""
    ;;
"patchy snow possible" | "patchy sleet possible" | "patchy freezing drizzle possible" | "freezing drizzle" | "heavy freezing drizzle" | "light freezing rain" | "moderate or heavy freezing rain" | "light sleet" | "ice pellets" | "light sleet showers" | "moderate or heavy sleet showers")
    condition="󰼴"
    ;;
"blowing snow" | "moderate or heavy sleet" | "patchy light snow" | "light snow" | "light snow showers")
    condition="󰙿"
    ;;
"blizzard" | "patchy moderate snow" | "moderate snow" | "patchy heavy snow" | "heavy snow" | "moderate or heavy snow with thunder" | "moderate or heavy snow showers")
    condition=""
    ;;
"thundery outbreaks possible" | "patchy light rain with thunder" | "moderate or heavy rain with thunder" | "patchy light snow with thunder")
    condition=""
    ;;
*)
    condition=""
    ;;
esac

#echo $temp $condition

echo -e "{\"text\":\""$temperatureF $condition"\", \"alt\":\""$temperatureF $currcond"\", \"tooltip\":\""$city: $temperatureF $currcond"\"}"

cached_weather=" $temperature  \n$condition $currcond"

echo -e "$cached_weather" >  ~/.cache/.weather_cache
