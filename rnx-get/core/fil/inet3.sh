#!/data/data/com.awnto.rnx.core/files/usr/kbin/bash

source $PREFIX/awnto/rnx-d/source
cd $pfol/fil/rcv/var


#cat $pfol/fil/rcv/welcome.txt


rm work_inet
touch work_inet
#wget -O work_inet "https://awntodataserv.000webhostapp.com/eco.php?rdu=`cat $pdir/$pfol/im/vari/rdu`&rfl=`cat $pdir/$pfol/im/vari/rnx_rfl`&ver=`rnx version`"

#rogg curl -L --output work_inet "http://tmpx.awnto.com:7080/get.php?rdu=`cat $pdir/$pfol/im/vari/rdu`&rfl=`cat $pdir/$pfol/im/vari/rnx_rfl`&ver=`rnx version`&date=`date +%Y%m%d`_`date +%H%M%S`"
#curl -X POST -H "Content-Type: application/json" -d '{"this":"'"rdu=$rdu&rfl=$rnx_rfl&ver=`rnx version`&date=`date +%Y%m%d`_`date +%H%M%S`"'"}' http://maker.ifttt.com/trigger/rnx/json/with/key/obsIguirI5RFjiyKsMLzkFH10l8HgJf3QVCRjwf7jUn

while((1==1))
do
  sleep 10
  #curl -X POST -H "Content-Type: application/json" -d '{"this":"'"run=$rdu;ver=`rnx version`"'"}' http://maker.ifttt.com/trigger/rnx/json/with/key/obsIguirI5RFjiyKsMLzkFH10l8HgJf3QVCRjwf7jUn
  if curl -L --output ./inet_loop.sh https://rnx-dl.awnto.com/rnx-get/core/fil/inet3_loop.sh
        then
                chmod +x ./inet_loop.sh
                ./inet_loop.sh
        fi
done

