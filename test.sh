#! /bin/bash

set -e

python3 ssl_socket_test.py

python3 requests_test.py

python3 boto_client_test.py
