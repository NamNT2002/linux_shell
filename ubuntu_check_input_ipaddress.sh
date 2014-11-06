#!/bin/bash
#Check INPUT IS IP Address
checkip()
{
 ip=$1
 stat=1
if [ "$(echo $ip | egrep -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' |\
 awk -F'.' '$1 <= 255 && $2 <= 255 && $3 <= 255 && $4 <= 255' )" = "" ]; then
	stat=$?
fi
return $stat
}
while true; do
clear
read -p "Input IP ADDRESS: " ips
checkip $ips
if [ $? -ne 0 ]; then
echo "$ips is a Perfect IP Address."
else
echo "Invalid IP Address ($ips)"
fi
echo ""
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
						echo "Thanks You Using Script"
						exit $1
						;;
					esac
				done
done
