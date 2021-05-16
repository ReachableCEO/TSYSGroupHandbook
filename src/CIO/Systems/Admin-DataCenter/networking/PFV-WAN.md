# PFV WAN

- [PFV WAN](#pfv-wan)
  - [Introduction](#introduction)
    - [Provider](#provider)
  - [IP Allocation](#ip-allocation)
  - [Diagram](#diagram)
  - [Security considerations](#security-considerations)
  - [Availaiblity considerations](#availaiblity-considerations)

## Introduction

The HQ data center provides both corporate network and WAN services. We utilize AT&T Uverse Busienss CLass VDSL service for IP transit.

### Provider

- AT&T Uverse
- Business DSL (fiber overbuild is projected for late 2021)
- 60 down/20 up is what I see in speed tests

## IP Allocation

- Static IP setup : <https://forums.att.com/conversations/att-internet-features/how-do-i-setup-an-att-internet-static-ip/5defee02bad5f2f606ea4054>

```text
Broadband Connection Up
Broadband Network Type Lightspeed
Broadband IPv4 Address 107.140.191.0
Gateway IPv4 Address 107.140.188.1
MAC Address 84:bb:69:e1:b1:e1
Primary DNS 68.94.156.9
Secondary DNS 68.94.157.9
Primary DNS Name 
Secondary DNS Name  
```

```text
Address:   104.182.29.16         01101000.10110110.00011101.00010 000
Netmask:   255.255.255.248 = 29  11111111.11111111.11111111.11111 000
Wildcard:  0.0.0.7               00000000.00000000.00000000.00000 111
=>
Network:   104.182.29.16/29      01101000.10110110.00011101.00010 000 (Class A)
Broadcast: 104.182.29.23         01101000.10110110.00011101.00010 111
HostMin:   104.182.29.17         01101000.10110110.00011101.00010 001
HostMax:   104.182.29.22         01101000.10110110.00011101.00010 110
Hosts/Net: 6                     
```

- 104.182.29.16 (network address)
- 104.182.29.17 rtr1
- 104.182.29.18 rtr2
- 104.182.29.19 float
- 104.182.29.20 FNFMail
- 104.182.29.21 WWW testing
- 104.182.29.22 (gateway)
- 104.182.29.23 (broadcast)

## Diagram

## Security considerations

## Availaiblity considerations
