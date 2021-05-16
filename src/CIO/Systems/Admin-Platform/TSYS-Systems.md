# TSYS Systems

This article covers the (high level) systems architecture that supports TSYS/Redwood Group.
Other articles will go more in depth on specific systems. This article provides a general overview.

The architecture was designed to :

  * meet the highest levels of information assurance and reliability (at a single site)
  * support (up to) Top Secret workloads for R&D (SBIR/OTA) (non production) contract work
(by US Citizens only) being done for the United States Department of Defense/Energy/State
by various components of TSYS Group.

## Virtual Machines: Redundant (mix of active/passive active/active)

We are (with exception of R&D product development (being a hardware/IOT product) 99.9%) virtualized :

Exceptions to virtualized infrastructure:

  * raspberry pi providing stratum0 (via hat) and server room badge reader functionality (via usb badge reader and lock relay)
  * intermediate CA HSM passed through to a VM on vm3
  * UPS units connected to vm3 via usb/serial

Any further exceptions to virtual infra require CEO/board approval and extensive justification.

### Networking

* Functions
  * TFTP server
  * DHCP server
  * HaProxy (443 terminates here)
  * Dev/qa/prod Core routing/firewall
  * (multi provider) WAN edge routing/firewall
  * Static/dynamic routing
  * inbound/outbound SMTP handling
  * Caching/scanning (via ClamAV)Web proxy
  * Suricata IDS/IPS

All the above is provided on an active/passive basis via CARP IP with sub 2ms failover.

* Machines
  |VM Name | VM ID | Vm Host | Storage Enclosure| Storage Array |
  |---|---|---|---|---|
  |pfv-core-rtr01|120|vm1|stor2|tier2vm|
  |pfv-core-rtr02|xx|vm3|stor1|s1-wwwdb|

### DNS/NTP (user/server facing)

We do not expose the core domain controllers (dc2/3) directly to users or servers. Everything flows through pihole. We allow DNS (via firewall rules) to ONLY pihole 1,2 no other DNS is allowed. pihole 1,2 is only allowed to realy to the core dc, then the dc are allowed to relay to the internet (8.8.8.8).

This blocks the vast majority of spyware/trackerware/malware/c2c etc (using the pihole blacklists). DNS filtering is the first line of defense against attackers and far less false positives when doing log review.

* Functions
  * DNS (with ad filtering) (pihole)
  * NTP

* Machines

  |VM Name | VM ID | Vm Host | Storage Enclosure| Storage Array |
  |---|---|---|---|--|
  |pihole1|101|vm3|stor1|s1-wwwdb|
  |pihole2|103|vm1|stor2|tier2vm|

### Database layer

All the data for all the things. Everything is clustered, shared service model.

* Functions
  * Mysql (galera)
  * Postgresql (patroni)
  * ETcd
  * MQTT Brok
  * Rabbitmq
  * Elasticsearch
  * Longhorn
  * K3s control plane

* Machines

  |VM Name | VM ID | Vm Host | Storage Enclosure| Storage Array |
  |---|---|---|---|--|
  |db1|125|vm4|stor1|s1-wwwdb|
  |db2|126|vm5|stor2|tier2vm|
  |db3|127|vm1|stor2|tier2vm|

### Web/bizops/IT control plane application layer

All the websites for TSYS/Redwood Group live on this infra. It's served up via HAProxy (active/passive on r1/42) in an active/active setup (each node running 50% of workload, capable of 100% for handling node maintenace)

* Functions
  * All brand properties
  * Data repository (discourse)
  * IT Control plane (job clustering/monitoring/alerting/siem etc)
  * Business operations (marketing/sales/finance/etc)
  * Apache server (for non dockerized applications)
  * k3s worker nodes (we are moving all workloads to docker containers with longhorn PVC)

* Machines

  |VM Name | VM ID | Vm Host | Storage Enclosure| Storage Array |
  |---|---|---|---|--|
  |www1|123|vm5|stor2|tier2vm|
  |www2|124|vm4|stor1|s1-wwwdb|

### Line of business Application layer

* Functions
  * Guacamole (serving up rackrental customer workloads, also developer workstations)
  * Webmail (for a number of our domains, we don't use Office 365)

* Machines

  |VM Name | VM ID | Vm Host | Storage Enclosure| Storage Array |
  |---|---|---|---|--|
  |tsys-dc-02|129|vm5|stor2|tier2vm|
  |tsys-dc-03|130|vm4|stor1|s1-wwwdb|

## Network Security Monitoring

We will be using security onion in some fashion. Looking into that with OpenVAS/Lynis/Graylog as a SIEM/scanner. More to follow soon. It will be a distributed, highly available setup.

## Virtual Machines: Non Redundant

### VPN

You'll notice VPN missing from the redundant networking list. A few comments on that:

* We employ a zero trust access model for vast majority of systems
* We heavily utilize web interfaces/APIs for just about all systems/functionality and secure acces via 2fa/Univention Corporate Server ("AD") and a zero trust model.
* We do have our R&D systems behind the VPN for direct SSH access (as opposed to through various abstraction layers)
* We utilize WIreguard (via the ansible setup provided by algo trailofbits). We don't have a redundant Wireguard setup, just a single small Ubuntu VM. It's worked incredibly well and the occasional 90 seconds or so of downtime for kernel patching is acceaptable.
* Due to ITAR and other regulations, we utilize a VPN for access control. We may in the future, upon appropriate review and approval, setup haproxy with SSH SNI certifcates to route connections to R&D systems directly.

|VM Name | VM ID | Vm Host | Storage Enclosure| Storage Array |
|---|---|---|---|--|
|pfv-vpn|106|vm3|stor2|tier2vm|

### Physical Surveilance

We can take 90 seconds of downtime for occasional kernel patching and not be processing the surveilance feeds for a bit. Everyone knows that criminals just loop the footage anyway....

|VM Name | VM ID | Vm Host | Storage Enclosure| Storage Array |
|---|---|---|---|--|
|pfv-nvr|104|vm5|stor2|tier2vm|

### Building automation

We can take 90 seconds of downtime for occasional kernel patching and wait to turn on a light or whatever.

|VM Name | VM ID | Vm Host | Storage Enclosure| Storage Array |
|---|---|---|---|--|
|HomeAssistant|116|vm3|stor2|tier2vm|

### Sipwise

We can take 90 seconds of downtime for occasional kernel patching, and have the phones "stop ringing" for that long.

|VM Name | VM ID | Vm Host | Storage Enclosure| Storage Array |
|---|---|---|---|--|
|sipwise|105|vm4|stor1|s1-wwwdb|

### Online CA (Intermeidate to offline root)

We can take 90 seconds of downtime for occasional kernel patching. 

We serve the CRL and other "always on" SSL related bits via cloudflare ssl toolkit in docker using
the web/app layer over HTTP(S) and it's fully redundant.

This VM is only used occasionally to issue long lived certs or perform needed maintenance. 

It could be down for weeks/months without issue.

It's using XCA for administration and talking to the db cluster. It is locked to vm3, because
we pass through a Nitrokey HSM, works wonderully.

|VM Name | VM ID | Vm Host | Storage Enclosure| Storage Array |
|---|---|---|---|--|
|pfv-ca|131|vm3|stor1|s1-wwwdb|

### Operations/administration/management (OAM)

This is the back office IT bits.

* Functions
  * librenms (monitoring/alerting/long term metrics)
  * netdata (central dashboard)
  * upsd (central dashboard)
  * rundeck (internal orchestration only)
  * sshaudit
  * lynis
  * crash dump server
  * openvas
  * etc

  |VM Name | VM ID | Vm Host | Storage Enclosure| Storage Array |
  |---|---|---|---|--|
  |pfv-toolbox|121|vm3|stor2|tier2vm|

## Storage Infrastructure

* We keep it very simple and utilize TrueNAS Core on Dell PowerEdge 2950 with 32gb ram.
* We run zero plugins.
* We have a variety of pools setup and served out over NFS to the 10.251.30.0/24 network
* No samba, just NFS
* Utilize built in snapshots/replication for retention/backup

## Virtualization Infrastructure

* We keep it very simple and utilize Proxmox on a mix of :
  * Dell Optiplex (i3/i7) (all with 32gb ram)
  * Dell PowerEdge (dual socket, quad core xeon) (all with 32gb ram)
  * Dell Precision system (i7) (16gb ram) (with nvida quadaro card passed through to kvm guest (either windows 10 or Ubuntu Server 20.04 depending on what we need todo)
  * We run the nodes with single power supply and single OS drive.

Vm node failure is expected (we keep the likelihood low with use of thumb drives with syslog set to
only log to the virtualized logging infra), and we handle the downtime via the redundancy we
outlined above (by using virtual machines spread across hypervisors / arrays / enclosures ) and redundancy happens 
at the application level). 

Restoring a vritual server node would take maybe 30 minutes

(plug a new thumb drive, re-install, join cluster). 

In the meantime the vm has auto migrated to another node using proxmox HA functionality (if it's an SPOF VM).


## Overall system move to production status

| Hostname       | OSSEC | Rundeck | Netdata | librenms mon | librenms log | DNS | (x)DP | NTP | Slack | Lyris | SCAP | Auditd | OpenVAS | oxidized |
| -------------- | ----- | ------- | ------- | ------------ | ------------ | --- | ----- | --- | ----- | ----- | ---- | ------ | ------- | -------- |
| Pfv-vmsrv-01   | Y     | Y       | Y       | Y            | Y            | Y   | Y     | Y   |       |       |      |        |         | N/A      |
| Pfv-vmsrv-02   | Y     | Y       | Y       | Y            | Y            | Y   | Y     | Y   |       |       |      |        |         | N/A      |
| Pfv-vmsrv-03   | Y     | Y       | Y       | Y            | Y            | Y   | Y     | Y   |       |       |      |        |         | N/A      |
| Pfv-vmsrv-04   | Y     | Y       | Y       | Y            | Y            | Y   | Y     | Y   |       |       |      |        |         | N/A      |
| Pfv-vmsrv-06   | Y     | Y       | Y       | Y            | Y            | Y   | Y     | Y   |       |       |      |        |         | N/A      |
| Pfv-time1      | Y     | Y       | Y       | Y            | Y            | Y   | Y     |     |       |       |      |        |         | N/A      |
| Pfv-stor1      | N/A   | N/A     | N/A     | Y            |              | Y   | Y     | x   |       |       | N/A  | N/A    |         | N/A      |
| Pfv-stor2      | N/A   | N/A     | N/A     | Y            |              | Y   | Y     | x   |       |       | N/A  | N/A    |         | N/A      |
| Pfv-consrv01   | N/A   | N/A     | N/A     | Y            | Y            | Y   | Y     | x   |       |       | N/A  | N/A    |         | N/A      |
| Pfv-core-sw01  | N/A   | N/A     | N/A     | Y            | Y            | Y   | Y     | x   |       |       | N/A  | N/A    |         |          |
| Pfv-core-ap01  | N/A   | N/A     | N/A     | Y            | N/A          | Y   | Y     | x   |       |       | N/A  | N/A    |         |          |
| Pfv-lab-sw01   | N/A   | N/A     | N/A     | Y            |              | Y   | Y     | x   |       |       |      |        |         |          |
| Pfv-lab-sw02   | N/A   | N/A     | N/A     | Y            | Y            | Y   | Y     | x   |       |       |      |        |         |          |
| Pfv-lab-sw03   | N/A   | N/A     | N/A     | Y            |              | Y   | Y     | x   |       |       |      |        |         |          |
| Pfv-lab-sw04   | N/A   | N/A     | N/A     | Y            | Y            | Y   | Y     | x   |       |       |      |        |         |          |
| 3dpsrv         | Y     | Y       | Y       | Y            | Y            | Y   | N/A   | Y   |       |       |      |        |         | N/A      |
| Pfv-core-rtr01 | N/A   | N/A     | N/A     | Y            | Y            | Y   | Y     | x   |       |       | N/A  | N/A    |         |          |
| Pfv-core-rtr02 | N/A   | N/A     | N/A     | Y            | Y            | Y   | Y     | x   |       |       | N/A  | N/A    |         |          |
| tsys-dc-01     | Y     | Y       | Y       | Y            | Y            | Y   | Y     |     |       |       |      |        |         |          |
| tsys-dc-02     | Y     | Y       | Y       | Y            | Y            | Y   | Y     |     |       |       |      |        |         |          |
| tsys-dc-03     | Y     | Y       | Y       | Y            | Y            | Y   | Y     |     |       |       |      |        |         |          |
| Tsys-dc-04     | Y     | Y       | Y       | Y            | Y            | Y   | Y     |     |       |       |      |        |         | N/A      |
| pihole1        | Y     | Y       | Y       | Y            | Y            | Y   | Y     |     |       |       |      |        |         | N/A      |
| pihole2        | Y     | Y       | Y       | Y            | Y            | Y   | Y     |     |       |       |      |        |         | N/A      |
| pfv-toolbox    | Y     | Y       | Y       | Y            | Y            | Y   | Y     |     |       |       |      |        |         | N/A      |
| ca             | Y     | Y       | Y       | Y            | Y            | Y   | Y     |     |       |       |      |        |         | N/A      |
| www1           | Y     | Y       | Y       | Y            | Y            | Y   | Y     |     |       |       |      |        |         |          |
| www2           | Y     | Y       | Y       | Y            | Y            | Y   | Y     |     |       |       |      |        |         |          |
| www3           | Y     | Y       | Y       | Y            | Y            | Y   | Y     |     |       |       |      |        |         |          |
| db1            | Y     | Y       | Y       | Y            | Y            | Y   | Y     |     |       |       |      |        |         |          |
| db2            | Y     | Y       | Y       | Y            | Y            | Y   | Y     |     |       |       |      |        |         |          |
| db3            | Y     | Y       | Y       | Y            | Y            | Y   | Y     |     |       |       |      |        |         |          |