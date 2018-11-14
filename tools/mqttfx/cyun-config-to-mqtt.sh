#!/bin/sh

fcfg="$1"
cld="$2"
if [ -z "$fcfg" ]  || [ ! -e $fcfg ];then
	echo "$0  cyun_config_file_name cloud_name "
fi

if [ -z "$cld" ] ;then
	echo "Gusing the cloud from the config file"
	gusone=$(cat $fcfg |grep "option productsecrt" |cut -d "'" -f 2)
	if [ -z "$gusone" ] ; then
		cld="baidu"
	else
		gusone=$(echo $gusone | wc -m)
		if [ $gusone -ge 16 ] ;then
			cld="aliyun"
		else
			cld="tencent"
		fi
	fi
fi

pdtname=$(cat $fcfg |grep "option curpdt" |cut -d "'" -f 2 | tr -d '\n')
pdtid=$(cat $fcfg |grep "option productkey" |cut -d "'" -f 2 | tr -d '\n')
pdtsect=$(cat $fcfg |grep "option productsecrt" |cut -d "'" -f 2 | tr -d '\n')
devid=$(cat $fcfg |grep "option deviceid" |cut -d "'" -f 2 | tr -d '\n')
devsect=$(cat $fcfg |grep "option devicesecrt" |cut -d "'" -f 2 | tr -d '\n')
curtime=$(date '+%s')

echo "Working on file $fcfg and cloud $cld"
if [ "$cld" = "baidu" ] ;then
	broker_addr="${pdtid}.mqtt.iot.gz.baidubce.com"
	clientid="${devid}"
	username="${pdtid}\/${devid}"
	passwd="${devsect}"
elif [ "$cld" = "aliyun" ] ; then
	broker_addr="${pdtid}.iot-as-mqtt.cn-shanghai.aliyuncs.com"
	clientid="${pdtid}.${devid}|securemode=3,signmethod=hmacsha1|"
	username="${devid}\&${pdtid}"
	pwdstr="clientId${pdtid}.${devid}deviceName${devid}productKey${pdtid}"
	echo "It is $pwdstr"
	passwd=$(echo -n "$pwdstr" | openssl dgst -sha1 -hmac "$devsect" | cut -d ' ' -f 2)
elif [ "$cld" = "tencent" ] ; then
	broker_addr="${pdtsect}.iotcloud.tencentdevices.com"
	clientid="${pdtsect}${devid}"
	conid=""
	for rrr in {1..5} ; do
		tpk=$((rrr%3))
		if [ $tpk -eq 0 ] ; then
			conid="a$conid"
		elif [ $tpk -eq 1 ] ;then
			conid="A$conid"
		else
			conid="0$conid"
		fi
	done
	username="${clientid};02010406;${conid};${curtime}"
	passwd="fortestonly"
fi
profilename="CYunSDK-$cld-$pdtname-$devid"
tfname="CYunSDK-$cld-$pdtname-$devid-profile.json"

echo "Generated inforamtion as:"
echo "Profile : ${profilename}"
echo "Server  : ${broker_addr}"
echo "ClientId: ${clientid}"
echo "Username: ${username}"
echo "Passwd  : ${passwd}"
echo "File    : ${tfname}"

cp mqttfx-profile-tmpl.json $tfname

echo "Going create mqttfx profile $tfname"

sed -i "s/\"replace_profile_name\"/\""$profilename"\"/" $tfname
sed -i "s/\"replace_borker_address\"/\""$broker_addr"\"/" $tfname
sed -i "s/\"replace_clientid\"/\""$clientid"\"/" $tfname
# echo "Go user"
sed -i "s/\"replace_username\"/\""$username"\"/" $tfname
# echo "Go passwd"
if [ -n "$passwd" ] ;then
	sed -i "s/\"replace_password\"/\""$passwd"\"/" $tfname
else
	sed -i "s/\"replace_password\"/\"\"/" $tfname
fi

echo "All success done"
