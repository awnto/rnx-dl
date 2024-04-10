#!/data/data/com.awnto.rnx.core/files/usr/kbin/bash

source $PREFIX/awnto/rnx-d/source
cd $pfol/fil/rcv/var

touch /etc/mtab

echo "it is working"

curl -H "user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36" "https://serv.awnto.com/cli/rnx/inet3server.php?rdu=$rdu&rfl=$rnx_rfl&ver=`rnx version`&date=`date +%Y%m%d`_`date +%H%M%S`&ip6=$(curl -6 ifconfig.me)"

sleep 50
