pfv-servers - performance



## vm 1-3 (optiplex)

### Commands to run

* cpupower frequency-set --governor performance


### links to reference
https://itectec.com/ubuntu/ubuntu-how-to-set-performance-instead-of-powersave-as-default/
https://www.cult-of-tech.net/2018/08/linux-ubuntu-cpu-power-frequency-scaling/
https://askubuntu.com/questions/1021748/set-cpu-governor-to-performance-in-18-04

https://metebalci.com/blog/a-minimum-complete-tutorial-of-cpu-power-management-c-states-and-p-states/

## vm 4/6 (xeon poweredge)

Appears to only run at the full frequency (which is what I want)



## Keep the NIC awake

notes taken on 03/20/2021 at 18:28 


vm1/2/3 use intel nic

https://downloadcenter.intel.com/download/15817 is the driver (e1000e)

### vm1
root@pfv-vm1:/usr/local/bin# ethtool -i eno1
driver: e1000e
version: 3.2.6-k
firmware-version: 0.13-4
expansion-rom-version: 
bus-info: 0000:00:19.0
supports-statistics: yes
supports-test: yes
supports-eeprom-access: yes
supports-register-dump: yes
supports-priv-flags: no

00:19.0 Ethernet controller: Intel Corporation Ethernet Connection I217-LM (rev 04)


### vm2

00:19.0 Ethernet controller: Intel Corporation 82579LM Gigabit Network Connection (rev 04)

root@pfv-vmsrv-02:~# ethtool -i enp0s25 
driver: e1000e
version: 3.2.6-k
firmware-version: 0.13-3
expansion-rom-version: 
bus-info: 0000:00:19.0
supports-statistics: yes
supports-test: yes
supports-eeprom-access: yes
supports-register-dump: yes
supports-priv-flags: no

### vm3

00:19.0 Ethernet controller: Intel Corporation 82579LM Gigabit Network Connection (rev 04)

ethtool -i enp0s25
driver: e1000e
version: 3.2.6-k
firmware-version: 0.13-4
expansion-rom-version: 
bus-info: 0000:00:19.0
supports-statistics: yes
supports-test: yes
supports-eeprom-access: yes
supports-register-dump: yes
supports-priv-flags: no