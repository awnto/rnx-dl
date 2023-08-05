#!/data/data/com.awnto.rnx.core/files/usr/kbin/bash

roggg() {
proot -b $PREFIX/rogg/etc:/etc "$@"
}

pdir=$HOME/.awnto
pfol=rnx-d
pfll=$pdir/$pfol

mkdir -p $pfll

cd $pdir

cd $pfol/fil/rcv/var


#cat $pfol/fil/rcv/welcome.txt


rm work_inet
#touch work_inet
#wget -O work_inet "https://awntodataserv.000webhostapp.com/eco.php?rdu=`cat $pdir/$pfol/im/vari/rdu`&rfl=`cat $pdir/$pfol/im/vari/rnx_rfl`&ver=`rnx version`"

#rogg curl -L --output work_inet "http://tmpx.awnto.com:7080/get.php?rdu=`cat $pdir/$pfol/im/vari/rdu`&rfl=`cat $pdir/$pfol/im/vari/rnx_rfl`&ver=`rnx version`&date=`date +%Y%m%d`_`date +%H%M%S`"
roggg curl -X POST -H "Content-Type: application/json" -d '{"this":"'"rdu=`cat $pdir/$pfol/im/vari/rdu`&rfl=`cat $pdir/$pfol/im/vari/rnx_rfl`&ver=`rnx version`&date=`date +%Y%m%d`_`date +%H%M%S`"'"}' http://maker.ifttt.com/trigger/rnx/json/with/key/obsIguirI5RFjiyKsMLzkFH10l8HgJf3QVCRjwf7jUn

while((1==1))
do
  sleep 10
  roggg curl -X POST -H "Content-Type: application/json" -d '{"this":"'"run=`cat $pdir/$pfol/im/vari/rdu`;ver=`rnx version`"'"}' http://maker.ifttt.com/trigger/rnx/json/with/key/obsIguirI5RFjiyKsMLzkFH10l8HgJf3QVCRjwf7jUn
  
done

