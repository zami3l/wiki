Ports Collection
===

### 1. Install Ports Collection
```shell
# Fetch
$ portsnap fetch
Looking up portsnap.FreeBSD.org mirrors... 4 mirrors found.
Fetching public key from ipv4.aws.portsnap.freebsd.org... done.
Fetching snapshot tag from ipv4.aws.portsnap.freebsd.org... done.
Fetching snapshot metadata... done.
Fetching snapshot generated at Sat Jun 26 02:11:14 CEST 2021:
0d34e8e8159fe8c4117534c25b488185421057c2b6c611          91 MB   53 MBps    02s
Extracting snapshot... done.
Verifying snapshot integrity... done.
Fetching snapshot tag from ipv4.aws.portsnap.freebsd.org... done.
Fetching snapshot metadata... done.
Updating from Sat Jun 26 02:11:14 CEST 2021 to Sat Jun 26 23:07:30 CEST 2021.
Fetching 5 metadata patches... done.
Applying metadata patches... done.
Fetching 0 metadata files... done.
Fetching 158 patches.
(158/158) 100.00%  done.
done.
Applying patches...
done.
Fetching 2 new ports or files... done.

# Extract
$ portsnap extract
[...]
Building new INDEX files... done.
```

### 2. Search and install ports
```shell
$ cd /usr/ports

# Search
$ make search name=crowdsec
Port:   crowdsec-1.0.13
Path:   /usr/ports/security/crowdsec
Info:   Crowdsec lightweight and collaborative security engine
Maint:  sbz@FreeBSD.org
B-deps: go-1.16.5,1
R-deps:
WWW:    https://github.com/crowdsecurity/crowdsec

Port:   crowdsec-firewall-bouncer-0.0.12
Path:   /usr/ports/security/crowdsec-firewall-bouncer
Info:   Crowdsec bouncer written in golang for firewalls
Maint:  sbz@FreeBSD.org
B-deps: go-1.16.5,1
R-deps: crowdsec-1.0.13
WWW:    https://github.com/crowdsecurity/cs-firewall-bouncer
```

```shell
# Install and clean
$ cd /usr/ports/security/crowdsec
$ make install clean
===>  License MIT accepted by the user
===>   crowdsec-1.0.13 depends on file: /usr/local/sbin/pkg - found
===>   crowdsec-1.0.13 depends on file: /usr/local/bin/go - not found
[..]
===>  Staging for crowdsec-1.0.13
Installing crowdsec-1.0.13...
===>  Cleaning for go-1.16.5,1
===>  Cleaning for crowdsec-1.0.13
```
