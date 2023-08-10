#!/system/bin/sh



ini_sys_finstall()
{

	RNX_CORE_HOME=/data/data/com.awnto.rnx.core/files/home
	RNX_CORE_UDOWN=/data/data/com.awnto.rnx.core/files/home/uDown
	RNX_CORE_PREFIX=/data/data/com.awnto.rnx.core/files/usr
	
	
	#chmod 700 ./assets/data/busybox
	
	mkdir -p $RNX_CORE_HOME
	#mkdir -p $RNX_NEO_PREFIX/kbin
	
	RNX_BUSYBOX="busybox"
	#ln -s -f -T ../anlib/liban-bi-bb.so $RNX_NEO_BUSYBOX
	
	
	rnx_arch=`uname -m`

	case $rnx_arch in 
	
	aarch64)
	
		echo CPU_ARCH_[AARCH64]_SUPPORTED > $RNX_CORE_HOME/rnx_tog.txt
	
		rnx_busybox=`which busybox`
		rnx_linux_path=/sdcard/AWN/rnx_debian_linux_stable_gui_j_aarch64.tar.xz
		rnx_linux_link=https://gitlab.com/rishabhsarswa/rnx-dl-10/-/raw/main/rnx_debian_linux_stable_gui_j_aarch64.tar.xz
#rnx_linux_link=https://gitlab.com/rishabhsarswa/rnx-dl-9/-/raw/main/neo/iusr/rnx_debian_linux_stable_gui_j_aarch64.tar.xz


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
	
	$rnx_busybox rm -rf $RNX_CORE_UDOWN/$1
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
			if pv "$4" | $rnx_busybox tar -xJ 
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
			if rogg curl -L --output "${RNX_CORE_UDOWN}/${1}" "$5"
			then
				echo "$1 ---> extracting "
				if pv "${RNX_CORE_UDOWN}/${1}" | $rnx_busybox tar -xJ 
				then
					echo "$1 ---> online install done "
				else
					echo "$1 ---> online install error in extraction "
					return 1
				fi
			else
				echo "$1 ---> online install error in downloading "
				return 2
			fi
		else
			echo "$1 ---> ini_sys installed found "
		fi
		
		
	fi
	$rnx_busybox rm -rf $RNX_CORE_UDOWN/$1

}


if ini_sys_installer i_linux `cat ${HOME}/.awnto/rnx-d/im/vari/rnx_rfl` "awnto/prock" $rnx_linux_path $rnx_linux_link
then
	echo "=========================="
	echo " Linux installed done"
	echo "=========================="
	
	rnx fcnf
	
	if [ -f "${HOME}/.awnto/rnx-d/im/vari/confi" ]
	then
		touch "${HOME}/.awnto/rnx-d/im/vari/autoboot.awnto_lock"
		exit 
		#exec rnx login
	fi
	
	
	
else
	echo "error try again"
	echo "or visit : http://rinix.awnto.com/docs"

fi

exit



(( ict = 0 ))
while (( ict == 0 ))
do

	

	#sleep 2
	#echo RECHECKING > $RNX_CORE_HOME/rnx_tog.txt
	#echo "rechecking ..."
	#sleep 1
	#exec /data/data/com.awnto.rinix.io/files/assets/data/boot.sh
	if ini_sys_installer iusr $RNX_CORE_PREFIX "prock" /sdcard/AWN/usr_J.tar.xz http://127.0.0.1:12345/AWN/usr_J.tar.xz
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

