#!/bin/bash

set -e

namespace="smoll"
current_dir="${PWD##*/}"
image_name="$namespace/$current_dir"

branch_name=$(git symbolic-ref -q HEAD)
branch_name=${branch_name##refs/heads/}
branch_name=${branch_name:-HEAD}

if [ -z "$1" ]; then
    primary_tag="$1"
else
    primary_tag="$branch_name"
fi

docker build --tag=${image_name}:${primary_tag} .
docker tag -f ${image_name}:${primary_tag} ${image_name}:latest
docker push ${image_name}
