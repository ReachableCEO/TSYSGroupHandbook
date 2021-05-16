# TSYS Group - IT Documentation - Processes - Move To Production

- [TSYS Group - IT Documentation - Processes - Move To Production](#tsys-group-it-documentation-processes-move-to-production)
  - [Provision the system](#provision-the-system)
  - [Configure the system](#configure-the-system)

## Provision the system

The below steps are performed manually for the small handful of "pet" machines (db/web/app). They are performed by the RackRental provisioner for the "cattle" machines.

* Create phpipam record
* Create forward DNS record
* Create reverse DNS record
* Install the VM
i   - Setup the hostname
  * Install SSH server
  * Configure IP address
  * Set resolver to 10.251.37.5 , 10.251.37.6



## Configure the system

* Install FetchApply

```bash
curl <http://pfv-toolbox.turnsys.net/installFetch.sh|/bin/bash>
```

FetchApply will :

* Setup NTP
* Add rundeck key to root authorized_keys
* Setup postfix to relay via pfv-toolbox
* Setup netdata agent
* Setup snmpd
* Add the tsys CA root/intermediate certs
* Harden ssh configuration
* Install logwatch
* Install molly-guard
* Patch the system
* Add system to librenms
* Add system to rundeck
* Perform any server role specific configuration
