#!/bin/bash

#
# Usage:
# sh test.sh - Builds and tests, using docker-compose.yml
#

# Build everything
docker-compose build

# Run the containers
docker-compose up -d

# TODO: figure out how to block until redis is up, otherwise this test usually
# fails the first time it is run, but then passes every subsequent time!

# Run the test
resttest.py http://$(docker-machine ip default):5001 test.yaml
rc=$?

# Remove the containers
docker-compose rm -v -f
if [ $? -eq 0 ]; then
    echo "Test container(s) successfully deleted."
else
    echo "Could not delete test container(s). Check 'docker ps' output!" >&2
fi

# Exit with test command exit code
exit $rc
