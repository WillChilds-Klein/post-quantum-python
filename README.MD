# Post Quantum Python

A docker container that supports Post Quantum TLS provided in CPython. All PQ
capabilities are derived from public packages with no need to build anything from
source.

## Build 

To build the docker container run:

    $ docker build . -t pq-tls-python
    
To run the container

    $ docker run --trm -it pq-tls-python

## Usage

### Using `ssl` Sockets

### Using Requests

Requests uses `urllib3` for HTTP(S), which in turn uses python's standard library `ssl`
module. The `ssl` module uses system OpenSSL, which as of OpenSSL 3.5.0 enables PQ TLS
by default.

### Using boto3 to connect to AWS

You'll need to set temporary role credentials in the container's environment. Currently
only KMS, ACM and Secrets Manager support PQ TLS.

## Other Notes

You can capture data from Docker via tcpdump, for example:

    $ sudo tcpdump -A -i docker0 dst port 443 -w docker_443.pcap

And then use wireshark to verify the pcap file. 

You will look for the keyshare agreement (in decimal) that matches the hex value
[here](https://github.com/open-quantum-safe/oqs-provider/blob/main/ALGORITHMS.md).
