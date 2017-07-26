#!/bin/bash

userid='root';
password='#EDC1qaz2wsx';
nowday=`date "+%Y-%m-%d"`;
delday=`date --date='7 days ago' "+%Y-%m-%d"`;

### db
now_s=`date`;
echo "start backup portal db $nowday";
`echo "$now_s start backup portal_$nowday.sql.gz" >> /backup/portal/db/backup.log`;
`cd /backup/portal/db;mysqldump -u $userid -p$password --max_allowed_packet=1G --single-transaction portal2_lbgduts > /backup/portal/db/portal_$nowday.sql;gzip portal_$nowday.sql`;

now_e=`date`;
`echo "$now_e backup portal_$nowday.sql.gz" >> /backup/portal/db/backup.log`;

now_ds=`date`;
echo "del backup db portal $delday";
`echo "$now_ds del portal_$delday.sql.gz" >> /backup/portal/db/backup.log`;
`cd /backup/portal/db;rm -rf /backup/portal/db/portal_$delday.sql.gz`;
now_de=`date`;
`echo "$now_de del portal_$delday.sql.gz" >> /backup/portal/db/backup.log`;

### web
now_s=`date`;
echo "start backup web $nowday";
`echo "$now_s start backup web_$nowday.bz2" >> /backup/portal/db/backup.log`;

`cd /var/www;tar -jcvf web_$nowday.bz2 html;mv web_$nowday.bz2 /backup/portal/db`;

now_e=`date`;
`echo "$now_e backup web_$nowday.bz2" >> /backup/portal/db/backup.log`;

now_ds=`date`;
echo "del backup web $delday";
`echo "$now_ds del web_$delday.bz2" >> /backup/portal/db/backup.log`;
`cd /backup/portal/db;rm -rf web_$delday.bz2`;

now_de=`date`;
`echo "$now_de del web_$delday.bz2" >> /backup/portal/db/backup.log`;

### web scp
sshpass -p '@WSX4rfv%TGB' scp /backup/portal/db/web_$nowday.bz2 koha@122.147.148.180:/home/koha/backup/portalgduts`

### db scp
sshpass -p '@WSX4rfv%TGB' scp /backup/portal/db/portal_$nowday.sql.gz koha@122.147.148.180:/home/koha/backup/portalgduts`
