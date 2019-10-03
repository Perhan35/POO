--------------------------------
---- INSTALLATION (Linux) ----
===============================
-- TODO: script bash to automate installion --

a - node.js installation
-------------------------

1 - [Nodejs Website](https://nodejs.org/en/download/package-manager/)

*    sudo apt-get install -y build-essential

*    curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -

*    sudo apt-get install -y nodejs


2 - unzip knd_server-x.x.x.zip

3 - goto back-end folder (cd back-end/)


b - application installation 
----------------------------

4 - in terminal : sudo npm install

5 - in terminal : sudo npm run start

6 - goto http://localhost:8080

Your server is now running.
Please note you don't have the database installed yet.


c - database installation
-------------------------

7 - install mysql [website](https://dev.mysql.com/doc/mysql-apt-repo-quick-guide/en/)

8 - Follow instruction of the web page

9 - edit rc.local to start mysql server on startup (please see d - )

10 - optional but recommended : 
    install mysql workbench 
    
    'sudo apt-get install mysql-workbench-community`
    
    
11 - run MySQL Workbench : on startup you have localinstance on port 3306 running

12 - import following files: createDB.sql and management.sql of ~/knd_server-x.x.x/back-end/db/

13 - on file createDB.sql click on the flash 

That's it ! Your database is ready to be used with the server created above.
To check your database goto file management.sql and click on the flash.

For backups please see file in back-end/db/Backup&Restore.md


d - rc.local edition
---------------------
In order to start mysql and the server on bootup

14 - sudo nano /etc/rc.local

15 - copy/paste(Ctrl+Maj+v) the following :

> `#! /bin/sh`

> `sudo service mysql start`

> `cd {your_path_to_folder}/knd_server-0.0.2/back-end/`

> `sudo npm run start &`

> `exit 0`

Don't forget to change {your\_path\_to\_folder}


e - SSL certificate (HTTPS)
----------------------------
As you can see in the server.js file, there are two servers. One with https and the other (commented) only http.

But to run the https server you need some files (called certificates). 

Thoses files, to be accepted by any browser, need to be issued by Certificate Authority. (cf my SSL_Certificate.pdf documentation)
So we will use a CLI CA, and hopefully we got [Certbot](https://certbot.eff.org/) (former Let's Encrypt)! 

1 - [Download](https://gist.github.com/davestevens/c9e437afbb41c1d5c3ab)

* `cd /opt`

* `sudo git clone https://github.com/certbot/certbot` 

* `cd certbot/`

2 - [Installation](https://certbot.eff.org/docs/intro.html#installation)

/!\ This configuration works only with our server.

Before running the following, please be sure to have port 443 forwarded into your computer (see PortForwarding.pdf documentation)

* `./certbot-auto certonly --standalone --agree-tos --email myemail@exemple.com -d yourdomain.com`

for instance : `./certbot-auto certonly --standalone --email noreply@sailingperformance.com -d kndtest.ddns.net`

Then your certificates should be in /etc/letsencrypt/live/yourdomain.com
It is recommended to let them here (because of renewal) and to change the "ssl_domain" variable at the beginning of server.js


3 - [Renewal](https://certbot.eff.org/docs/using.html#renewing-certificates)

After 90 days you need to renew your certificates.



---------------------------------------
---- FILES STRUCTURE + DESCRIPTION ----
=======================================

First of all please note the following: 
---------------------------------------

* UML class diagrams for front end are available in /front-end/ClassDiagrams as .png or as a [modelio](https://www.modelio.org/) project 
* UML class diagrams for Data Base is availabe in /back-end/db/schema-date.mwb
* Images in /back-end/public/resources/img/
* Offline Report Viewer (build projet) is into /front-end/offlineReportViewer/offlineReportViewer/
    - For Developpers : please read README.txt into /front-end/offlineReportViewer/src/app/
    - For Client or Users : please read README.txt into /front-end/offlineReportViewer/offlineReportViewer/
    - To use it : copy /front-end/offlineReportViewer/offlineReportViewer into another computer and then launch it
* At least but not last : read TODO.txt in /Documentation/
