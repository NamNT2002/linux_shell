#!/bin/bash
#Backup file or folder
clear
#create folder log
if [ -d /var/log/logbackup ]
then
echo
else
mkdir -p /var/log/logbackup
fi
#check source backup
while true
	do
read -p "Source Folder Or File: " fdbk
echo ""
#check input file available is file or folder
ab=$(find $fdbk 2>/dev/null)
	if [ $? -eq 1 ]
		then 
		echo "File or folder: $fdbk is not available"
		while true; do
						echo "Do you want to continue"
						echo "If you input y, Y, YES to continue and n, N or NO to exit."
						read -p "Please talk to me ...: " INPUT_STRING
						case $INPUT_STRING in
							c|C|y|Y|yes|YES|"")
								break
							;;
							n|N|no|NO)
							echo "Thanks You. You chose Exit"
							exit 1
							;;
						esac
					done
	else
	break
	fi
done

#check source backup
read -p "You want backup to folder: " fddes
echo ""
mkdir -p $fddes
namelog="log_backup_"$(date +%m%d%Y)
tbk=$(date +%H)":"$(date +%M)" "$(date +%m)"-"$(date +%d)"-"$(date +%Y)

desf=$(echo $fdbk | tr '/' ' ' | awk '{print $NF}')
ab=$(find $fdbk | wc -l)
if [ $ab -eq 1 ]
then
	if [ -f $fddes/$desf ]
	then
		md5s=$(md5sum $fdbk | awk '{print $1}')
		md5d=$(md5sum $fddes/$desf | awk '{print $1}')
			if [ "$md5s" != "$md5d" ]
			then
				yes | cp -f $fdbk $fddes/$desf 2>/dev/null
				echo "$tbk: Backup $fdbk to $fddes/$desf"
				echo "$tbk: Backup $fdbk to $fddes/$desf" >> /var/log/logbackup/$namelog
			fi
	else
		cp -f $fdbk $fddes/$desf
		echo "$tbk: Backup $fdbk to $fddes/$desf"
		echo "$tbk: Backup $fdbk to $fddes/$desf" >> /var/log/logbackup/$namelog
	fi
else
cd $fdbk
	for i in $(find * -type d)
	do
		mkdir -p /$fddes/$desf/$i
	done
	for j in $(find * -type f)
	do
		if [ -f $fddes/$desf/$j ]
		then
		md5s=$(md5sum $j | awk '{print $1}')
		md5d=$(md5sum $fddes/$desf/$j | awk '{print $1}')
			if [ "$md5s" != "$md5d" ]
			then
				yes | cp -f $j $fddes/$desf/$j 2>/dev/null
				echo "$tbk: Backup $j to $fddes/$desf/$j"
				echo "$tbk: Backup $j to $fddes/$desf/$j" >> /var/log/logbackup/$namelog
			fi
		else
			yes | cp -f $j $fddes/$desf/$j 2>/dev/null
			echo "$tbk: Backup $j to $fddes/$desf/$j"
			echo "$tbk: Backup $j to $fddes/$desf/$j" >> /var/log/logbackup/$namelog
		fi
	done
fi
ln -sf /var/log/logbackup/$namelog /var/log/logbackup/log_backup
echo "View Log Backup is file: /var/log/logbackup/log_backup"
exit 1
