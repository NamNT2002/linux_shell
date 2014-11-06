#!/bin/bash
#Shell Check INPUT IS IP ADDRESS
black='\e[0;30m' 
red='\e[0;31m'
green='\e[0;32m' 
yellow='\e[0;33m'
blue='\e[0;34m' 
magenta='\e[0;35m'
cyan='\e[0;36m'
white='\e[0;37m'
endColor='\e[0m'
Lightcyan='\e[0;96m'
bold='\033[1m'
Lightred='\e[0;91m'
Lightyellow='\e[0;93m'
Lightgreen='\e[0;92m'

function checkip()
 {
         local ip=$1
         local stat=1
         if [[ $ip =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
                OIFS=$IFS
                IFS='.'
                ip=($ip)
               IFS=$OIFS
                [[ ${ip[0]} -le 255 && ${ip[1]} -le 255 \
                && ${ip[2]} -le 255 && ${ip[3]} -le 255 ]]
                stat=$?
        fi
        return $stat
}

function center()
{
     value="$1" 
	 COLUMNS=$(tput cols) 
printf "%*s\n" $(((${#value}+$COLUMNS)/2)) "$value"
}
function center_Lightcyan()
{
     value="$1" 
	 COLUMNS=$(tput cols) 
printf '\e[1;96m%*s\n\e[m' $(((${#value}+$COLUMNS)/2)) "$value"
}
clear

center_Lightcyan "Linux Bash Shell - Check INPUT IP ADDRESS"
while true; do
	read -p "IP ADDRESS: " ip
	checkip $ip

	if [[ $? -ne 0 ]];then
	  echo -e "${Lightred}Invalid IP Address ($ip)${endColor}"
	else
	  echo -e "${Lightgreen}$ip${endColor} ${Lightcyan}is a Perfect IP Address.${endColor}"
	fi
	
	while true; do
					#echo "Ban Co Muon Tiep Tuc??"
					#echo "Dien y d."
					read -p "Do you want to continue(Y/n) ?: " INPUT_STRING
					case $INPUT_STRING in
						c|C|y|Y|yes|YES"")
						echo ""
							break
						;;
						n|N|no|NO)
						#echo "Thanks You. You chose Exit"
						center 				"**********************************************"
						center		 		"Thanks You Using Script"
						center 				"**********************************************"
						exit $1
						;;
					esac
				done
	
done
