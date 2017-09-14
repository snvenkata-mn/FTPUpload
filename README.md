# FTPUpload
Automating FTP Upload to Poppy Server using Shell Script

We get a lot of requests related to ATS Build Upload (Or anyother) to FTP server (poppy) in our projects.
So, I have automated the process using Shell Script.  
You need to provide inputs in the beginning of the script (Like Remote Server, Build Location, Name etc.,). 
For now, this script will upload to poppy using my credentials (without password prompt). You can modify the script to use yours (But password is required). 

Few checks before using this script:
1) This script uses "sshpass" command which will automate the password prompt for SSH command. So, this should be installed on the remote server you are trying to compress the build (Example: VM55, VM31, VM65 etc.,) 
2) Login to remote server and run below commands (Onetime Task)
    a) man sshpass (Checking if it is already installed, if yes you can skip this step and run the script directly, else run below commands)
        b) yum --enablerepo=epel -y install sshpass (if this says sshpass package is not present, execute below commands)
	      c) wget http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm  (Adding new mirror )
	            d) rpm -ivh epel-release-6-8.noarch.rpm
		        e) yum --enablerepo=epel -y install sshpass (Now, this should install sshpass)

			Steps:
			1) Login to my machine - (root@mnipdsnvenkata.modeln.com - Root is mandatory)
			2) Script Location: /home/snvenkata/ftpUpload.sh
			3) Run ./ftpUpload.sh
			4) Provide required inputs
			5) Script will compress the build, and upload it to FTP Server. 

			Goal is to share this to execution team who can directly use this script rather waiting for us to do it.
