# Authentication

## Password Management

### Shared Passwords

* We utilize bitwarden for shared password storage. For example for external vendors, social media etc. All external logins are 2fa.

### Privileged Access

* CEO/CFO have equivalent access in bitwarden, to absolutely everything.
* CIO has very limited access to shared passwords (just for pfv-stor until it's hooked into true command). Does not have access to domain admin or other shared passwords.
* CMO has access to all social media and all wordpress admin (but uses normal account for day to day use)

### VPN Endpoint Creation / Deletion 

* Ansible recipe for algo (update users.yml and re-run ansible) (document more soon)