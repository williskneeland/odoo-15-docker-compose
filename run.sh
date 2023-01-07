#!/bin/bash
DESTINATION=$1
PORT=$2
CHAT=$3

cp -a ./. ${DESTINATION}/
rm -rf $DESTINATION/.git

mkdir -p $DESTINATION/postgresql
# sudo chmod -R 777 $DESTINATION

# config
if grep -qF "fs.inotify.max_user_watches" /etc/sysctl.conf; then echo $(grep -F "fs.inotify.max_user_watches" /etc/sysctl.conf); else echo "fs.inotify.max_user_watches = 524288" | sudo tee -a /etc/sysctl.conf; fi
sudo sysctl -p

sed -i 's/9000/'$PORT'/g' $DESTINATION/docker-compose.yml
sed -i 's/20014/'$CHAT'/g' $DESTINATION/docker-compose.yml

docker-compose -f $DESTINATION/docker-compose.yml up -d
echo 'Started Odoo @ http://localhost:'$PORT' | Live chat port: '$CHAT
