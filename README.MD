# Post Quantum Python

A docker container that contains a build of the Python runtime that supports Post Quantum TLS provided by [AWS-LC](https://github.com/aws/aws-lc).


## Build 

To build the docker container run:

    $ docker build . -t pq-tls-python
    
To run the container

    $ docker run pq-tls-python

## Usage

### Using Requests

This container's build of AWS-LC detects TLS key exchange configuration at runtime by inspecting the `DEFAULT_GROUPS` environment variable. For example:

    $ export DEFAULT_GROUPS=x25519
    $ export DEFAULT_GROUPS=X25519MLKEM768
    $ export DEFAULT_GROUPS=X25519MLKEM768:x25519

Once the group is set, you can use requests as per normal. See `test/requests_test.py` for more info.

Changing the environment variable during execution will not change the behaviour.

The setting of `DEFAULT_GROUPS` when you run `import requests` is the **final** setting for the duration of that execution

Ensure that the this variable is set to its expected value **before** requests is imported.

The openquantumsafe project runs multiple Post Quantum standalone and Hybrid settings at test.openquantumsafe.org, on different ports. More info [here](https://test.openquantumsafe.org/assignments.json)

### Using boto3 to connect to AWS

The OQS provider uses the `DEFAULT_GROUPS` environment variable. To set to KEM schemes we set to something like:

    $ export DEFAULT_GROUPS=x25519
    $ export DEFAULT_GROUPS=X25519MLKEM768
    $ export DEFAULT_GROUPS=X25519MLKEM768:x25519

The setting of `DEFAULT_GROUPS` when you run `import boto3` is the **final** setting for the duration of that execution

Trying to re-import boto3 will not change the setting.

Currently only KMS, ACM and Secrets Manager support Hybrid Encryption using DEFAULT_GROUPS of `x25519_kyber512`

## Other Notes

You can capture data from Docker via tcpdump, for example:

    $ sudo tcpdump -A -i docker0 dst port 443 -w docker_443.pcap

And then use wireshark to verify the pcap file. 

You will look for the keyshare agreement (in decimal) that matches the hex value [here](https://github.com/open-quantum-safe/oqs-provider/blob/main/ALGORITHMS.md).
