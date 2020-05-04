FROM ubuntu:20.04
MAINTAINER alex.blewitt@gmail.com

RUN apt update && apt install -y dnsmasq

RUN apt install -y dnsutils less

# Copy the files into the Docker image
# Can also be tested by mounting this as a volume
# so that the docker file does not need to be rebuilt
# each time a change is made
COPY dnsmasq.conf /etc
COPY dnsmasq.d /etc/dnsmasq.d

# Run the test at build time, to verify syntax
RUN /usr/sbin/dnsmasq --test

# When docker image run, execute dnsmasq in foreground
CMD /usr/sbin/dnsmasq --no-daemon
