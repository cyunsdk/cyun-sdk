CYUN SDK 测试工具　配置文件转换为mqtt.fx profile
---

### 转换config文件为mqtt.fx　profile ###
本工具能够将config(CYUN SDK 使用的配置文件以连接对应额云服务器)　转换为mqtt.fx使用的profile，从而方便的切换不同工具的使用
本工具和CYUN SDK独立，即使不使用CYUN SDK,也可以创建config文件，然后运行本工具以产生对应的profile文件．
本工具只能运行于Linux系统上，阿里云的profile文件产生需要主机上安装openssl.

---
#### 准备config文件
参考 [连接各物联网云文档](../../README.md) 创建对应的config文件，无需运行对应的yundaemon进程．

---
#### 将config文件转换为mqtt.fx的profile

　　　　cd tools/mqttfx/
    cp target_config testconfig
    ./cyun-config-to-mqtt.sh ./testconfig

生成的CYUN-xxxx.json文件即为mqtt.fx直接使用的profile.
注意，mqtt.fx 1.7里面的improt无法正确导入clientId,导入产生的profile前，需要先打开该json文件，将其中的
>"clientId" : "xxxxxxx",

clientId拷贝出来，mqtt.fx导入文件后，再修改其配置，将配置页面的ClientId填写为记录的值．

