# TSYS Group - HQ data center documentation - power

- [TSYS Group - HQ data center documentation - power](#tsys-group-hq-data-center-documentation-power)
  - [Introduction](#introduction)
  - [Circuits](#circuits)
  - [Outlets](#outlets)
  - [Surge Protectors](#surge-protectors)
  - [Extension cords](#extension-cords)
  - [UPS  units](#ups-units)
    - [Prod](#prod)
    - [UPS5](#ups5)
    - [UPS7](#ups7)
  - [R&D](#r-d)
    - [UPS1](#ups1)
    - [UPS3](#ups3)
    - [UPS4](#ups4)
    - [UPS6](#ups6)
- [PDU](#pdu)
    - [Unmanaged PDUs](#unmanaged-pdus)
    - [Managed PDUs](#managed-pdus)

## Introduction

This article covers the electrical power setup for the HQ data center. We've grown it over time, bringing online more and more protected capacity as we got good deals on UPS/batteries etc and have added additional load.

## Circuits

The server room is fed by two 20amp circuits:

* Circuit 8a serving:
  * dedicated air conditioner (see our cooling article for details on that)
  * vm(1-3) servers
  * network equipment
  * overhead and led lighting

* Circuit (xx) serving:
  * pfv-stor1/stor2 enclosures and drive arrays
  * vm(4-6)

(future plan)

* Connect a new outlet to the 20 amp circuit currently serving front porch outlet (which shares a wall with the server room). 
* This would provide sustained 15 amps for the RackRental.net rentable inventory.

## Outlets

We have upgraded the standard 15amp outlets that serve the server room, to 20amp outlets. This allows us to run a full 15amps sustained load (on 20amp circuits)

## Surge Protectors

We utilize GE surge protectors , rated for 15amps. They are about $50.00 apiece. These are placed upstream of the UPS units (between the wall outlet and the UPS extension cord).

## Extension cords

We do not have outlets close to the UPS stack. We utilize 15amp rated extension cords (from the surge protectors) to feed the UPS inputs.

## UPS  units

### Prod

* UPS2
  * Make/Model: Dell UPS Rack 1000W LV
  * PDU served:
    * UMPDU1
  * Protected load:
    * pfv-stor1/pfv-stor2 (Dell PowerEdge 2950s)
    * backup USB drives and USB hub
    * external scratch/backup arrays
  * Protected Load Runtime: 12 minutes

### UPS5

* CyberPower UPS (details tbd)
* PDU served:
  * UMPDU4
  * BenchPDU
  * Cameras
* Protected load:
  * pfv-vm1/2/3
  * pfv-time1
  * pfv-labsw*
  * pfv-core-ap01
  * pfv-coresw-01
  * pfv-labsw*
* Protected Load Runtime: 12 minutes

### UPS7

* PDUs served: n/a
* Monitoring server: n/a (un-monitored ups)
* Protected load: locking relay for server room

## R&D

### UPS1

### UPS3

### UPS4

### UPS6

# PDU

### Unmanaged PDUs

### Managed PDUs
