#!/bin/bash 


echo "Removing previous ATS Build"

rm -rf /home/snvenkata/ATS_Build/*
cd /home/snvenkata/ATS_Build

User="root"
Host="mniufscappvm55"

echo "Enter the host name from where you want to copy the ATS Build from: Default - ${Host}"
read input
	if [ ! -z "$input" ]
	then
	 Host=$input
	fi

sshpass -p 'mnlinux' ssh ${User}@${Host} '

echo "Logged in.."
SQIN_DIR_LOCATION="/home/sqinUser/automation"

echo What is the location of SQIN folder?  Default value - ${SQIN_DIR_LOCATION}
read sqin_path

	if [ ! -z "$sqin_path" ]
	then
	 SQIN_DIR_LOCATION=$sqin_path
	fi

SQIN_DIR_LOCATION=$SQIN_DIR_LOCATION/SQIN
echo SQIN directory to check is "${SQIN_DIR_LOCATION}"

	if [ ! -d "$SQIN_DIR_LOCATION" ]; then
	 echo ERROR: Failed to find "${SQIN_DIR_LOCATION}" Directory
	 exit 1
	fi

cd $SQIN_DIR_LOCATION
cd ..


BUILD_VERSION=Spring17
echo What is the App version of this ATS build ? Default Value - ${BUILD_VERSION}
read build_ver

	if [ ! -z "$build_ver" ]
	then
	 BUILD_VERSION=$build_ver
	fi

date_now=$(date +"%m_%d_%Y")
ATS_BUILD_NAME=ATS_Build_${BUILD_VERSION}_${date_now}
echo Enter the ATS Build name ? Current Default Value - ${ATS_BUILD_NAME}
read ats_name

	if [ ! -z "$ats_name" ]
	then
	 ATS_BUILD_NAME=${ats_name}
	fi

	if [ -f "${ATS_BUILD_NAME}.tar.gz" ]
	then
		echo ${ATS_BUILD_NAME}.tar.gz file already exists 
		echo "Do you want to delete $ATS_BUILD_NAME in the current directory? (Y/N)"
		read response

		if [ "$response" = "Y" ]; then
			rm -rf ${ATS_BUILD_NAME}.tar.gz 
			echo "File got successfully deleted"
		else
			echo Enter the ATS Build name ? 
			read ats_name_new
			ATS_BUILD_NAME=$ats_name_new
		fi
	fi


echo "Compressing Started"
tar -cvzf ${ATS_BUILD_NAME}.tar.gz Test_Script/
echo "${ATS_BUILD_NAME}.tar.gz got created"

echo "Copying Build to snvenkata machine"
sshpass -p "mnlinux" scp -r ${ATS_BUILD_NAME}.tar.gz root@mnipdsnvenkata:/home/snvenkata/ATS_Build/
echo "Copy Done"
'

echo "Logged back to snvenkata Machine"

cd /home/snvenkata/ATS_Build
pwd

nohup sshpass -e sftp -oPort=2222 snvenkata@poppy.modeln.com <<EOF  > nohup.out & tail -f nohup.out
cd astellas
cd ATS_Build
put *
exit
EOF

echo "ATS Build got uploaded to Poppy server."












