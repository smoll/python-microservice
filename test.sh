#!/bin/bash

#
# Usage:
# sh test.sh - Builds and tests, using docker-compose.yml
#

# Build everything
docker-compose build

# Run the app containers
docker-compose up -d web redis

# TODO: figure out how to block until redis is up, otherwise this test usually
# fails the first time it is run, but then passes every subsequent time!

# Run the test
docker-compose run tester resttest.py http://web:5000 test.yaml
rc=$?

# Remove the containers
docker-compose kill
docker-compose rm -f
if [ $? -eq 0 ]; then
    echo "Test container(s) successfully deleted."
else
    echo "Could not delete test container(s). Check 'docker ps' output!" >&2
fi

# Exit with test command exit code
exit $rc
