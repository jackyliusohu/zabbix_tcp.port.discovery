# zabbix_tcp.port.discovery

zabbix 的强大不用多说，我也是zabbix fans，下面介绍一下zabbix自动监控服务器端口。

分以下几步：


1.git clone git@github.com:jackyliusohu/zabbix_tcp.port.discovery.git #下载模板和脚本文件




2.把tcp-service-discovery.sh、servcie_discovery.conf 分别放入zabbix_agentd目录和scripts目录 #目录位置按自己的结构来。





3.在zabbix 模板导入xml文件，此时创建了tcp.port.discovery模板，接下来就可以使用了。