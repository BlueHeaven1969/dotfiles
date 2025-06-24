#!/bin/bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# weather info from wttr. https://github.com/chubin/wttr.in
# Remember to add city

city=KLWM
xmlcache=~/.cache/.weather_cache_$city
datacache=~/.cache/.weather_cache
cacheage=9999
# Retrieve every 45 mins
max_cacheage=2700

if [ ! -f $xmlcache ]; then
    touch $xmlcache
fi

cachesize=$(stat -c%s "$xmlcache")
minsize=100

if [ "$cachesize" -gt "$minsize" ]; then
    cacheage=$(($(date +%s) - $(stat -c '%Y' "$xmlcache")))
fi

if [ $cacheage -gt $max_cacheage ]; then
    curl -s https://forecast.weather.gov/xml/current_obs/$city.xml >$xmlcache
fi

temp=$(xml_grep --text_only 'temp_f' $xmlcache)
temperature=${temp%.*}
currcond=$(xml_grep --text_only 'weather' $xmlcache)
curricon=$(xml_grep --text_only 'icon_url_name' $xmlcache)
icon=${curricon%.*}

# https://fontawesome.com/icons?s=solid&c=weather
case $(echo "${icon}" | tr '[:upper:]' '[:lower:]') in
"skc")
    condition="󰖙"
    ;;
"nskc")
    condition="󰖔"
    ;;
"few" | "skt" | "sct")
    condition="󰖕"
    ;;
"nfew" | "nskt" | "nsct")
    condition="󰼱"
    ;;
"bkn")
    condition=""
    ;;
"nbkn")
    condition=""
    ;;
"ovc" | "novc")
    condition="󰖐"
    ;;
"fg" | "nfg")
    condition="󰖑"
    ;;
"shra")
    condition=""
    ;;
"nshra")
    condition=""
    ;;
"tsra" | "ntsra")
    condition=""
    ;;
"sn" | "nsn")
    condition="󰜗"
    ;;
"fzrara" | "nfzrara")
    condition="󰙿"
    ;;
"mist" | "nmist")
    condition="󰼰"
    ;;
"ra" | "nra")
    condition="󰖗"
    ;;
*)
    condition=""
    ;;
esac

#echo $temp $condition

echo -e "{\"text\":\""$temperatureF $condition"\", \"alt\":\""$temperatureF $currcond"\", \"tooltip\":\""$city: $temperatureF $currcond"\"}"

cached_weather=" $temperature  \n$condition $currcond"

echo -e "$cached_weather" >$datacache
