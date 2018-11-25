CYUNSDK UART串口模块参数说明
---

# 配置文件中串口参数

| 配置文档条目     | 条目含义　　 |　取值举例  | 　特殊说明　|
| --------- | ----------- | ------------- | ---------------- |
| enabled    | 是否开启UART转发功能 | 0 1  |   |
| uartname   | 串口接口路径 | /dev/ttyUSB0  |   |
| bandrate   | 串口波特率 | 115200  |   |
| mode | 串口参数 | 8N10 | 具体含义参见下表 |


串口的配置中的mode是一个固定为４个字节的字符串，形如"8N10",其中每个字符含义如下

|　字符  | 条目含义　　 |　取值举例  | 　特殊说明 |
| --------- | ----------- | ------------- | ---------------- |
| 字符1    | data bits |  一般为　5/6/7/8,常见为8  |   |
| 字符2   |  是否奇偶校验 | N: 不校验; E:偶校验  O:　奇校验  |   |
| 字符3   | 停止位 | 1/2  |   |
| 字符4 | 　NA | NA | 暂未使用 |



# 配置文件举例

典型UART配置如下:

    config uart usb0
        option enabled 1
        option uartname '/dev/ttyUSB0'
        option mode '8N10'
        option bandrate '115200'

也可以直接在docs/Cyun-uart-config-example基础上做修改调整

# UART接口配置调试

## 通过调试信息检查

进程启动过程中会默认打印当前配置，可以通过检查输出log中的如下片段来查看UART参数是否正常载入

    QYUN --------------System configuration dump ---------------
    Interface: 
     DebugLevel: 5
     DebugModel: 7fffffff
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
    UARTEnab: 1
        UARTName: /dev/ttyUSB0
        UARTMode: 8N10
        UARTBaud: 115200


## 通过yuncli来检查

进程运行过程中，也可以通通过yuncli命令来检查配置是否正确

     ./yuncli dump config
    yuncli Version 1.0.71
    Going connect server on 8888
    QYunDaemon version 1.0.71
    Response from server :0
    --------------System configuration dump ---------------
    Interface: 
     DebugLevel: 5
     DebugModel: 7fffffff
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
    UARTEnab: 1
        UARTName: /dev/ttyUSB0
        UARTMode: 8N10
        UARTBaud: 115200


