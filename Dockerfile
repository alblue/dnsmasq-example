FROM ubuntu:20.04

MAINTAINER alex.blewitt+github@gmail.com

# See https://github.com/alblue/dnsmasq-example
# See https://alblue.bandlem.com/2020/05/using-dnsmasq.html

RUN apt update && apt install -y dnsmasq

# When docker image run, execute dnsmasq in foreground
# This can be used to mount a directory with dnsmasq.d and dnsmasq.conf:
#
# docker run --rm -it \
#  -v $(PWD)/dnsmasq.d:/etc/dnsmasq.d:ro \
#  alblue/dnsmasq \
#  dnsmasq --conf-dir /etc/dnsmasq.d --test

CMD /usr/sbin/dnsmasq --no-daemon
