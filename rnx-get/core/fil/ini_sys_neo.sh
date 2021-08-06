#!/system/bin/sh



ini_sys_finstall()
{

	RNX_CORE_HOME=/data/data/com.awnto.rnx.core/files/home
	RNX_CORE_UDOWN=/data/data/com.awnto.rnx.core/files/home/uDown
	RNX_NEO_PREFIX=/data/data/com.awnto.rnx.neo/files/usr
	RNX_CORE_PREFIX=/data/data/com.awnto.rnx.core/files/usr
	
	
	#chmod 700 ./assets/data/busybox
	
	mkdir -p $RNX_CORE_HOME
	#mkdir -p $RNX_NEO_PREFIX/kbin
	
	RNX_NEO_BUSYBOX=$RNX_NEO_PREFIX/kbin/busybox
	#ln -s -f -T ../anlib/liban-bi-bb.so $RNX_NEO_BUSYBOX
	
	
	rnx_arch=`uname -m`

	case $rnx_arch in 
	
	aarch64)
	
		echo CPU_ARCH_[AARCH64]_SUPPORTED > $RNX_CORE_HOME/rnx_tog.txt
	
		rnx_busybox=$RNX_NEO_PREFIX/kbin/busybox
		rnx_iusr_path=/sdcard/AWN/rnx_core_usr_prock_aarch64.tar.xz
		rnx_iusr_link=http://rnx.awnto.com/rnx-get/files/i_usr/rnx_k9_usr_prock_aarch64.tar.xz


		#exit 
	;;


	*)

		echo CPU_ARCH_NOT_YET_SUPPORTED > $RNX_CORE_HOME/rnx_tog.txt
		echo "arch : $rnx_arch not supported"

		exit 12

		;;

	esac
	
	
	
}
ini_sys_finstall

ini_sys_installer()
{
	# 1=name 2=folder 3=checkfile 4=offline_path 6=url
	
	$rnx_busybox rm -rf $RNX_CORE_UDOWN
	echo "${2}/${3}"
	if ! [ -f "${2}/${3}" ]
	then
		echo "$1 ---> installing "
		sleep 1
		
		if [ -f  "$4" ]
		then
			echo "$1 ---> offline install auto-selected "
			$rnx_busybox rm -rf "$2"
			mkdir -p "$2"
			cd "$2"
			echo "$1 ---> extracting "
			if $rnx_busybox tar -xJf "$4"
			then
				echo "$1 ---> offline install done "
			else
				echo "$1 ---> offline install error in extraction "
			fi
		else
			echo "$1 ---> offline install file not found "
		fi
		
		if ! [ -f  "${2}/${3}" ]
		then
			echo "$1 ---> online install auto-selected "
			$rnx_busybox rm -rf "$2"
			mkdir -p "$2"
			cd "$2"
			mkdir -p "${RNX_CORE_UDOWN}"
			if $rnx_busybox wget -O "${RNX_CORE_UDOWN}/${1}" "$5"
			then
				echo "$1 ---> extracting "
				if $rnx_busybox tar -xJf "${RNX_CORE_UDOWN}/${1}"
				then
					echo "$1 ---> online install done "
				else
					echo "$1 ---> online install error in extraction "
				fi
			else
				echo "$1 ---> online install error in downloading "
			fi
		else
			echo "$1 ---> online install file not found "
		fi
		
		
	fi
	$rnx_busybox rm -rf $RNX_CORE_UDOWN

}





(( ict = 0 ))
while (( ict == 0 ))
do

	

	#sleep 2
	#echo RECHECKING > $RNX_CORE_HOME/rnx_tog.txt
	#echo "rechecking ..."
	#sleep 1
	#exec /data/data/com.awnto.rinix.io/files/assets/data/boot.sh
	if ini_sys_installer iusr $RNX_CORE_PREFIX "prock" /sdcard/AWN/usr_J.tar.xz http://127.0.0.1:8888/AWN/test/neorepo/usr_J.tar.xz
	then
		(( ict = 1))
	fi

done


	echo acco starting
	
	echo ACCO > $RNX_CORE_HOME/rnx_tog.txt
	#touch data/data/com.awnto.rinix.io/files/assets/data/work_acheck
	#chmod 700 /data/data/com.awnto.rinix.io/files/assets/data/preset.sh
	
	#/data/data/com.awnto.rinix.io/files/usr/scbin/inno /data/data/com.awnto.rinix.io/files/assets/data/preset.sh &
	#/data/data/com.awnto.rinix.io/files/usr/scbin/inno inno-l &
	echo "acco"

