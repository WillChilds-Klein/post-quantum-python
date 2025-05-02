#! /bin/bash

set -e

python3 tests/ssl_socket_test.py
python3 tests/requests_test.py
python3 tests/boto_client_test.py
