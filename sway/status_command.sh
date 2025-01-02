### ---- IMPORTANT ---- ###
# WHEN RUN BY SWAY, THIS SCRIPT CANNOT EXECUTE ANY AUXILARY SCRIPTS!!! #
while true
do
	date=$(date +'%b%d %X') 
	wifi_name=$(nmcli --fields NAME c | head -2 | tail -1 | tr -d '\ ')
	battery_level=$(cat /sys/class/power_supply/BAT0/capacity)
	battery_status=$(cat /sys/class/power_supply/BAT0/status) 
	battery_status=${battery_status:0:1}
	battery_status=${battery_status,,}
    volume=$(amixer sget 'Master' | tail -1 | \
        tr " " \\n | tail -3 | head -1 | tr -d "[]") 
    muted=$(amixer sget 'Speaker' | tail -1 | tr " " \\n | tail -1\
        | tr -d "[]")
    muted=$(echo ${muted:1:1} | tr -d "n" | tr "f" "m")
    
	echo "$volume$muted  $wifi_name  $battery_level$battery_status  $date"
	sleep 1
done
