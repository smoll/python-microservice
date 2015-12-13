#!/bin/bash

# Assume the image has already been built/tagged by docker_helper.sh

test_container_name="pmtest"

# Start a container
docker run -d -p 5001:5000 --name ${test_container_name} smoll/python-microservice:latest

# Run the test
resttest.py http://$(docker-machine ip default):5001 test.yaml
rc=$?

# Remove the container
docker rm -f ${test_container_name}
if [ $? -eq 0 ]; then
    echo "Test container successfully deleted."
else
    echo "Could not delete test container named '${test_container_name}'. Check 'docker ps' output!" >&2
fi

# Exit with test command exit code
exit $rc
