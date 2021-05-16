# TSYS Group - HQ data center documentation - runbook

- [TSYS Group - HQ data center documentation - runbook](#tsys-group-hq-data-center-documentation-runbook)
	- [Introduction](#introduction)
	- [Prerequisites and requirements](#prerequisites-and-requirements)
	- [Scenarios](#scenarios)
		- [Power lost and internet access isn't working after power is restored](#power-lost-and-internet-access-isn-t-working-after-power-is-restored)
		- [UPS  battery fails](#ups-battery-fails)
		- [Air conditioning fails (E5 error)](#air-conditioning-fails-e5-error)

## Introduction

This book covers recovery scenarios for PFV. It is meant to be executed inside the PFV server room.


## Prerequisites and requirements

* Be in the PFV server room
* Have a headlamp so your hands are free
* Go slow and easyo
* Ask for help
* Lift up the cardboard on rack3 (bottom rack of the two half racks next to rack 5), so you can press buttons on the Keyboard/Video/Mouse (KVM) switcher


## Scenarios


### Power lost and internet access isn't working after power is restored

The Virtual machines are set to automatically start on boot of the virtual server hosts. However the virtual server hosts boot faster than the storage hosts. 
So a manual intervention is needed to restore service.

Procedure:

Step 1) 

Ensure that storage enclosures are at the login prompt. You'll be confirming two systems:

* pfv-stor1 
* pfv-stor2

The buttons on the KVM switcher with the label 

* s1
* s2

will show you the output from pfv-stor1/pfv-stor2 respectively (on the monitor sitting on top of the UPS rack)

* Press the button with the label s1
* Look at the monitor 
* Ensure it's at a login prompt. 

* Press the button with the label s2
* Look at the monitor 
* Ensure it's at a login prompt. 

Step 2) 

Restart pfv-vm1

Procedure:

1) reboot the system labeled pfv-vm1:

	* Press the button on the KVM switcher labeled v1
	* quickly press and let go of the power button (just tap it and release). This will start a shutdown of the system. 
	* wait for power off and observe the output on the monitor . It will print out status as it shuts down.
	* Press the power button and let go of the power button (just tape it and release). This will start the system back up. 
	* wait for power on and observe the output on the monitor . It will print out status as it starts up and will end at a login prompt.
	* wait two minutes
	* see if internet is working

2) start the guests by logging into the console of vm1 by typing at the login prompt 

root
<password from the envelope in the safe>

Then type: qm start 120 
This will start up the router

Then type: qm start 106
This will start up the virtual private network 

You can use the command:

``` qm list ```

to get the current state 

You may see additional systems other than those listed below, when you run qm list. They are not critical path for production and can be started by ops team once core critical path is operational.

* pfv-vmsrv-01

root@pfv-vm1:~# qm list
      VMID NAME                 STATUS     MEM(MB)    BOOTDISK(GB) PID       
       120 pfv-core-rtr01       running    2048              20.00 3786     << this is the virtual router, if it's down, nothing else will work .
       106 pfv-vpn              running    2048              50.00 12814    << vpn server. No one will be able to access the network remotely if it's down 

If the above two systems are functioning , then IT can start up the other systems remotely.



### UPS  battery fails 

Sometimes the UPS will continue to function, passing through utility power, with an active alarm.

Other times it will fail.

1) Report this to ops team as an incident, including 
	* which UPS (they  are labeled front/back) is having an issue  
	* nature of the issue (total failure, alarm)
	* include a picture of the front which will have some information

2) Replace the battery
	* Access printed manual in the file cabinet in server room
	* Follow battery replacement procedure
	* Take pictures as you pull the battery pack out, to allow for easier re-wiring
	* Go to batteries plus with the failed batteries (we replace whole packs at once) and they'll sell you replacements for the pack
	* Wire pack and place into UPS

### Air conditioning fails (E5 error)

1) Shut down and unplug air conditioning unit
2) Take air conditioning unit outside (front porch)
3) Drain reservoir
