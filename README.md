This is an example configuration of how to set up DNSMasq for DNS, DHCP and
blocking undesired adverts. It is similar to the approach used by pi-hole,
but without the requirement to run an HTTP server, and not needing insecure
installation operational instructions or in a docker container requiring
root and/or admin capabilities in order to execute.

DNSMasq example configuration
=============================

DNSMasq home page is http://www.thekelleys.org.uk/dnsmasq/ and questions
relating to its use should be directed to the appropriate mailing lists.
On Ubuntu systems, dnsmasq can be installed with:

* apt update; apt -y install dnsmasq

The following configuration files are provided:

* [DNSMasq configuration file](dnsmasq.conf)
  - Loads all configuration files in `/etc/dnsmasq.d/*.conf`
* [Blackhole example file](dnsmasq.d/blackhole.conf)
  - Shows how an address can be blackholed at the DNS server
* [Master configuration file](dnsmasq.d/defaults.conf)
  - Log messages to `/var/log/dnsmasq.log` (`log-facility`)
  - Log messages asynchronously (`log-async`)
  - Only respond on the local interfaces (`local-service`)
* [DHCP sample configuration file](dnsmasq.d/dhcp.conf)
  - Authoratitve DHCP server (`dhcp-authoratitve`)
  - Leases in `/var/run/dnsmasq.leases` (`dhcp-leasefile`)
  - Send DNS server via IPv6 if enaled (`option6:dns-server`)
* [DNS](dnsmasq.d/dns.conf)
  - Do not forward unqualified names (`domain-needed`)
  - Do not forward requests for private networks (`bogus-priv`)
  - Do not read the `/etc/resolv.conf` file (`no-resolv` and `no-poll`)
  - Do not read the `/etc/hosts` file (`no-hosts`)
  - Enlarged cache size (`cache-size`)
  - Local DHCP caches may be cached for 60s (`local-ttl`)
* DNS upstream servers (combined or individually)
  - [dns-google](dnsmasq.d/dns-google)
  - [dns-cloudflare](dnsmasq.d/dns-cloudflare)
* Blocking DNS over HTTP(s) where available
  - [dns-no-doh.conf](dnsmasq.d/dns-no-doh.conf)
* [DNSSEC configuration, with dnssec enabled](dnsmasq.d/dnssec.conf)
  - Ensure signed DNSSEC entries are correct (`dnssec`)
  - DNSSEC for unsigned entries *not* enabled (`dnssec-check-unsigned`)
  - Load entries from `/usr/share/dnsmasq-base/trust-anchors.conf`
* Workarounds
  - Workaround for [Wink2K hosts](dnsmasq.d/workaround-win2k.conf) (`filterwin2k`)
  - Delay for [Raspberry Pi hosts](dnsmasq.d/workaround-pi.conf) (`dhcp-reply-delay`)
  - Disabling [WPAD hosts](dnsmasq.d/workaround-wpad.conf) for proxy auto discovery (`hostname-ignore`)
  - Disable `.corp` lookups for [Microsoft hosts](dnsmasq.d/workaround-corp.conf) (`local=/corp/`)

Testing
=======

There is a [Dockerfile](Dockerfile) present which can be used to test dnsmasq
configurations. When building the docker image, it will run `dnsmasq --test`
to verify syntax, and when executing, it will run the daemon in foreground
mode so that results can be seen as they run.

    $ docker build . -t dnsmasq
    $ docker run --rm -it --name dnsmasq -v $(PWD)/dnsmasq.d:/etc/dnsmasq.d:ro dnsmasq
    $ docker exec -it dnsmasq dig @localhost example.com
