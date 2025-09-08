#!/data/data/com.awnto.rnx.core/files/usr/kbin/bash



#set -exu

get_n1( )
{
	echo $1
}
get_n2( )
{
	echo $2
}
get_n3( )
{
	echo $3
}
get_n4( )
{
	echo $4
}
get_n5( )
{
	echo $5
}

get_n6( )
{
	echo $6
}

get_n7( )
{
	echo $7
}

get_n8( )
{
	echo $8
}
get_n9( )
{
	echo $9
}

curl_a()
{

	url="$1"
	file="$2"

	if [ -f $file ] 
	then
 		echo "Resuming File $file"
		if curl -L -r $(stat -c%s "$file")- -o "$file".2 "$url"
  		then
		echo "Joining $file"

		cat "$file" "$file".2 > "$file".3
		rm "$file" "$file"

		mv "$file".3 "$file"
 		else
		echo "error Joining $file"

		cat "$file" "$file".2 > "$file".3
		rm "$file" "$file"

		mv "$file".3 "$file"
  		exit 1
  		fi
	else
 		echo "Downloading File $file"
		curl -L -o "$file" "$url"
	fi
}


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
	
	
	if [[ "$1" == "" ]] ;
	then
		echo "url not found"
		exit 12
	fi
	pack_url="$1"
	
	echo "fetching entries from internet ..."
	echo "url : $pack_url"
	
	ilinks=$(curl "$pack_url" 2> /dev/null )
	
	if [[ $ilinks == "" ]]
	then
		echo "error in fetching from internet "
		exit 13 ;
	fi
	
	echo ""
	#echo $in_links
	
	cnt=0
	while read -r line
	do
	
		if [[ $line != "" ]] && [[ $(get_n1 $line) != "#" ]]
		then
		
			let cnt++ ;
			echo "$cnt)--> $(get_n1 $line)"
			dinfo=$(get_n7 $line)
			dinfo="${dinfo//+/ }"
			echo "	Info 	: $dinfo"
			echo "	Arch 	: $(get_n2 $line)"
			#echo "	lock File 	: $(get_n3 $line)"
			echo "	Path 	: $(get_n4 $line)"
			echo "	URL 	: $(get_n5 $line)"
			echo "	ROOT 	: $(get_n6 $line)"
			echo "	TYPE 	: $(get_n8 $line)"
			echo ""
		
		fi
	done < <(echo "$ilinks")
	
	
	
	#rnx_arch="aarch64"
	
	echo ""
	echo "your cpu is : $rnx_arch : `uname -m` "
	echo "available options for you "
	echo ""
	cnt=0
	
	while read -r line
	do
		if [[ $line != "" ]] && [[ $(get_n1 $line) != "#" ]] && [[ $rnx_arch == $(get_n2 $line) ]] ;
		then
				let cnt++ ;
				dinfo=$(get_n7 $line)
				dinfo="${dinfo//+/ }"
				
				echo "> $(get_n1 $line )"
				echo " 	$dinfo"
				echo ""
				
			
		fi
		
	done < <(echo "$ilinks")
	
	#g_one_install
	
	#echo $cnt
	if (( cnt == 0 )) ;
	then
		echo "rootfs not found for you"
		exit
	fi
	
	
	#exit
	if [[ $(cat $HOME/.awnto/vari/rdistro) != "" ]] ;
	then
		rrot=$(cat $HOME/.awnto/vari/rdistro)
	else
		echo ""
		echo "type rootfs name example : debian-cli"
		echo -n "--> "
		read -r rrot
	fi
	echo "you selected $rrot"
	
	cnt=0
	while read -r line
	do
		if [[ $line != "" ]] && [[ $(get_n1 $line) != "#" ]] && [[ $rnx_arch == $(get_n2 $line) ]] && [[ $(get_n1 $line) == $rrot ]] ;
		then
			let cnt++ ;
			echo "$rrot matched "
			
			echo "$cnt)--> $(get_n1 $line)"
			dinfo=$(get_n7 $line)
			dinfo="${dinfo//+/ }"
			echo "	Info 	: $dinfo"
			echo "	Arch 	: $(get_n2 $line)"
			#echo "	lock File 	: $(get_n3 $line)"
			echo "	Path 	: $(get_n4 $line)"
			echo "	URL 	: $(get_n5 $line)"
			echo "	ROOT 	: $(get_n6 $line)"
			echo "	TYPE 	: $(get_n8 $line)"
			echo ""
			
			
			rnx_linux_package="$(get_n1 $line)"
			rnx_linux_path="$(get_n4 $line)"
			rnx_linux_link="$(get_n5 $line)"
			rnx_linux_prock="$(get_n3 $line)"
			rnx_linux_rfl="$(get_n6 $line)"
			rnx_linux_type="$(get_n8 $line)"
			rnx_linux_subpath="$(get_n9 $line)"
			
			mkdir -p $HOME/.awnto/vari
			echo "$rrot" > $HOME/.awnto/vari/rdistro
			echo "$rnx_linux_rfl/$rnx_linux_subpath" > ${HOME}/.awnto/vari/rnx_rfl
			break ;
			#exit
			#g_one_install
			
		fi
		
	done < <(echo "$ilinks")
	
	rnx_busybox=`which busybox`
	
	if (( cnt == 0 )) ;
	then
		echo "rootfs not match"
		exit
	fi
	
	
	
	
}
ini_sys_finstall "https://rnx-dl.awnto.com/rnx-get/core/fil/rnx_linux_installer_links_2024.conf"



ini_sys_installer()
{
	# 1=name 2=folder 3=checkfile 4=offline_path 6=url
	
	#rnx_busybox=busybox 
	rnx_extracter=""
	case $6 in
		tar)
			rnx_extracter="$rnx_busybox tar -xJ"
			;;
		tar-sym)
			rnx_extracter="proot --link2symlink $rnx_busybox tar -xJ"
			;;
		*)
			echo "extracter $5 is not valid"
			exit 1
			;;
	esac
	
	
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
			if pv "$4" | $rnx_extracter
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
			if curl_a "$5" "${RNX_CORE_UDOWN}/${1}" 
			then
				echo "$1 ---> extracting "
				if pv "${RNX_CORE_UDOWN}/${1}" | $rnx_extracter
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


echo "installing $rrot"

if ini_sys_installer i_linux $rnx_linux_rfl $rnx_linux_prock $rnx_linux_path $rnx_linux_link $rnx_linux_type
then
	echo "=========================="
	echo " Linux installed done"
	echo "=========================="
	
	set -eu
	
	rnx fcnf
	
	if [ -f "${HOME}/.awnto/vari/confi" ]
	then
		touch "${HOME}/.awnto/vari/autoboot.awnto_lock"
		exec rnx login
		exit
	fi
	
	exit
	
	rnx fcnf
	
	
	
	
	
else
	echo "error try again"
	echo "or visit : http://rinix.awnto.com/docs"
	exit 11 ;
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











	rrot=""
	if [ -f $HOME/.awnto/vari/rdistro ] ;
	then
		rrot=$(cat $HOME/.awnto/vari/rdistro)
	fi
	
	rnx_url="https://rnx-dl.awnto.com/rnx-get/core/fil/rnx_linux_installer_links.conf"

	set -eu
	
	package_installer $rnx_url $rrot
	
	echo "$rrot" > $HOME/.awnto/vari/rdistro
	echo "$rnx_linux_rfl" > ${HOME}/.awnto/vari/rnx_rfl
	
	rnx fcnf
	exec rnx login	
	

	exit


