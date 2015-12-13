# Dockerized Python Microservice
Will use this for "spiking" various deployment strategies.

## Usage

0. Build, tag, test and push to Docker Hub

    ```bash
    make
    ```

0. Push a custom tag, e.g. `smoll/python-microservice:0.1`

    ```bash
    sh docker_helper.sh tag 0.1
    sh docker_helper.sh push
    ```
