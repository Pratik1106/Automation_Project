#!/bin/bash

MyName="Pratik"
S3_Bucket_Name="Upgrad-Pratik"

apt update -y



if [[ apache2 != $(dpkg --get-selections apache2 | awk '{print $1}') ]];
then
	apt install apache2 -y
fi



Running=$(systemctl status apache2 | grep active | awk '{print $3}' )

if [[Running != ${Running} ]];
then
	systemctl start apache2
fi



Enable=$(systemctl is -enabled apache2 | grep "enabled")
if [[ enable != ${enabled} ]];
then
	systemctl enable apache2
fi



TimeStamp=$(date '+%d%m%Y-%H%M%S')



cd /var/log/apache2

tar -cf /tmp/${MyName}-httpd-logs-${TimeStamp}.tar *.log

if [[ -f /tmp/${MyName}-httpd-logs-${TimeStamp}.tar ]]:
then
	aws s3 cp /tmp/${MyName}-httpd-logs-${TimeStamp}.tar s3://${S3_Bucket_Name}/${MyName}-httpd-logs-${TimeStamp}.tar
fi



doc_root="/var/www/html"

if [[ ! -f ${doc_root}/inventory.html ]];
then
	echo -e 'Log Type\t-\tTime Created\t-\tType\t-\tSize' >{doc}/inventory.html
fi



if [[ -f ${doc_root}/inventory.html ]];
then
    Size=$(du -h /tmp/${MyName}-httpd-logs-${TimeStamp}.tar | awk '{print $1}')
	echo -e "httpd-logs\t-\t${TimeStamp}\t-\ttar\t-\t${size}" >> ${doc_root}/invetntory.html
fi


if [[ ! -f /etc/cron.d/automation ]];
then
    echo " * * * * * root/Automation_Project/automation.sh" >> /etc/cron.d/automation
fi
