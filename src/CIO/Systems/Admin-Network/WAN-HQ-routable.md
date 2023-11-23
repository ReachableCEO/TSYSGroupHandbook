- [WAN Network - HQ - Public Routed Space](#wan-network---hq---public-routed-space)
  - [Proxmox/opnsense interface / layer 2 info](#proxmoxopnsense-interface--layer-2-info)
  - [AT&T Small business fiber network information](#att-small-business-fiber-network-information)

# WAN Network - HQ - Public Routed Space

## Proxmox/opnsense interface / layer 2 info

net1 5c:74 vmbr1000 wan 5c:74
net17 3a:bc vmbr1000 uversebiz vtnet17 3a:bc

## AT&T Small business fiber network information

- Address:   99.91.198.81          01100011.01011011.11000110.01010 001
- Netmask:   255.255.255.248 = 29  11111111.11111111.11111111.11111 000
- Wildcard:  0.0.0.7               00000000.00000000.00000000.00000 111

- Network:   99.91.198.80/29       01100011.01011011.11000110.01010 000 (Class A)
- Broadcast: 99.91.198.87          01100011.01011011.11000110.01010 111
- HostMin:   99.91.198.81          01100011.01011011.11000110.01010 001
- HostMax:   99.91.198.86          01100011.01011011.11000110.01010 110
- Hosts/Net: 6

- WAN Rtr 1 IP: 99.91.198.81
- WAN Rtr 2 IP: 99.91.198.82

- wireguard vpn, WAN Float, SIP, other services not on 80/443 IP: 99.91.198.83

- Cloudron IP: 99.91.198.84
- Conost IP: 99.91.198.85

- GW IP: 99.91.198.86

```shell

dig @8.8.8.8 -x 99.91.198.81 +short
tsyshq-corertr-01.knownelement.com.

dig @8.8.8.8 -x 99.91.198.82 +short
tsyshq-corertr-02.knownelement.com.

dig @8.8.8.8 -x 99.91.198.83 +short
tsyshq-wanfloat.knownelement.com.

dig @8.8.8.8 -x 99.91.198.84 +short
my.knownelement.com.

dig @8.8.8.8 -x 99.91.198.85 +short
app02.knownelement.com.
```