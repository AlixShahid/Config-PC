
#icons options =>     墳 奄 奔 ﱜ ﱝ 婢 ﱛ 奔,墳
# current_volume=$(pactl list sinks | grep -o '[0-9]*' | awk 'NR==11')


MUTE_COLOR='\e[0;30m'
NOCOLOR='\033[0m'


volstat="$(pamixer --get-volume-human | grep -o '[0-9]*')"
vol=$volstat

if [ "$vol" = '' ]; then
    icon="婢"
	# echo -e "$MUTE_COLOR $icon $NOCOLOR"
	# exit
else
	if [ "$vol" -gt "45" ]; then
		icon="墳"
		vol="$vol%"
		# don't let volume cross 200%
		if [ "$volstat" -gt "200" ]; then
			  pactl set-sink-volume 0 200%
		fi

	else
		if [ "$vol" -gt "15" ]; then
			icon="奔"
			vol="$vol%"
		else
			icon="奄"
			vol="$vol%"
		fi
	fi
fi

echo " $vol $icon "
