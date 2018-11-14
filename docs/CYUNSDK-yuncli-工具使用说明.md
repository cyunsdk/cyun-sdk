CYUN SDK yuncli功能命令行使用说明
---
## yuncli 命令行使用说明 ##
yuncli为CYUN SDK配套工具，使用此工具可以方便的和后台云连接进程通信，
可以实现如下功能:
- 查看当前配置
- 查看云连接状态
-　查看网络流量用量
- pub/sub/unsub　mqtt主题
- 发送字符串消息给后台进程，后台进程根据消息内容做相关动作
- 控制后台进程运行参数


```
yuncli Version 1.0.60
CYun SDK Command Line Utility
Options:
   dump
		config   Dump current configration used in daemon
		cnts     Dump counters for MQTT and NET usage
		status   Dump running status and cloud connect status

```

---
## yuncli dump 命令详解 ##
dump 命令行可以方便的查看后台进程的各类信息，以便于调试和维护

### yuncli dump config
dump config 用于显示后台进程当前使用的配置详细信息

```
./yuncli dump config
yuncli Version 1.0.60
Going connect server on 8888
QYunDaemon version 1.0.60
Response from server :0
--------------System configuration dump ---------------
Interface:
 DebugLevel: 5
 DebugModel: ffffffff
 CliPort: 8888
 Partner: qlnk
 CurrentPdt: qyunsdk
 ProductNum: 1
 ShadowInt:60000
  > 1 ++++++++qyunsdk+++++++++++++
	ProductName: qyunsdk
	ProductKey: a1gMUMcUyDP
	ProductSecrt: 7ktmqKpl8wy4L1eX
	ProductTls: 1
	DeviceId: sdkpc
	DeviceSecrt: yCVxhARrz6vaioYRwyQ9fSGNBtkZTWKI
	DeviceServer:
	Prefix:
	Blacklist:
UARTEnab: 0
 	UARTName: ttyS0
 	UARTMode: 8N10
 	UARTBaud: 115200
```
---
### yuncli dump cnts
dump cnts 用于显示后台进程的Mqtt和网络用量
```
./yuncli dump cnts
yuncli Version 1.0.60
Going connect server on 8888
QYunDaemon version 1.0.60
Response from server :0
Cloud statics info
Mqtt Pub:9/2110,PAck:0/0,Sub:8/0,UnSub:0/0,Con:1/0,Dis:0/0,Keep:0/0
Net Rx:0/0,Tx:0/0
```

---
### yuncli dump status
dump status 用于显示后台进程的状态信息
```
yuncli dump status
yuncli Version 1.0.60
Going connect server on 8888
QYunDaemon version 1.0.60
Response from server :0
Cloud status
Cloud pid 15840,Run 230,Since Tue Nov 13 14:52:20 2018
Not connected 1542092170s since Thu Jan  1 08:00:00 1970

```