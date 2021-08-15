#!/data/data/com.awnto.rnx.core/files/usr/kbin/bash

pdir=$HOME/.awnto
pfol=rnx-d
pfll=$pdir/$pfol

mkdir -p $pfll

cd $pdir

if ! [ -f "${HOME}/.awnto/rnx-d/prock" ]
then
	#rnx kill
	rnx update
	exec rnx boot
	#exec rnx login
fi


