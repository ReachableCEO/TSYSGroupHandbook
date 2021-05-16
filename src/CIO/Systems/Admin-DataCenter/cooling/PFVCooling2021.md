# TSYS Group - HQ data center documentation -  cooling

## Introduction

Cooling is a critical component of any data center. It is often the dominate consumer of energy.

We keep our data center at about 70 degrees F.

## Make / model

We have a

* HiSense Portable Air Conditioner (standalone) the manual lists several possible models, unsure which exact one we have. It was about 700.00 at Lowes with a multiple year replacement warranty.

which is rated for:

* 15,000 BTU

It draws about 7 amps when the compressor is running.

With our heat load, the compressor does cycle on/off ,so it keeps cool pretty efficiently from an energy perspective.

## Tips/tricks

* Extended exhaust house

We moved the air conditioner to the front of the racks (cold aisle) and extended the exhaust
hose todo so.

* Heat barrier

 We deployed a cardboard heat barrier above the racks, to keep hot air behind the racks. We also have a vent duct (made of cardboard) to a panel we removed above the doorway.

* Insulation

  * Insulate the exhaust hose!

* Air movers
  * We have a tower fan in the hot row (back), pushing the heat towards the duct.
  * We have two small blowers in the cold row (front) helping "kick back" the air blowing from the HiSense.

## Instrumentation

We use:

* temper usb probe
* lm-sensors
* DRAC

all consumed via SNMP by librenms to monitor/alert on temperature.This lets us find hot/cold spots across the racks and make any necessary adjustments.