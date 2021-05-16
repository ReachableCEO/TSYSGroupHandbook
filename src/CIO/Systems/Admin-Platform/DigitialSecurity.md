#IT Security

## Logging
Currently into librenms central store
rsyslog configured to forward

## Monitoring 
nedata for high fidelity metrics (push)
librenms for up/down (pull)

## Secrets

### Passwords (user secrets)
bitwarden

### Server secrets
envwarden

#### certs/keys

* Public facing (lets encrypt)

We use HTTP challenge via Opnsense LE/HA Proxy . All public facing certs live in OpnSense.


## IDS/IPS

## RBAC
