#!/bin/bash

set -e

namespace="smoll"
current_dir="${PWD##*/}"
image_name="$namespace/$current_dir"

branch_name=$(git symbolic-ref -q HEAD)
branch_name=${branch_name##refs/heads/}
branch_name=${branch_name:-HEAD}

if [ -n "$2" ]; then
    additional_tag="$2"
else
    additional_tag="latest"
fi

# Builds image with tag of current git branch name
function build {
    docker build --tag=${image_name}:${branch_name} .
    echo "Succesfully built: ${image_name}:${branch_name}"
}

# If param $2 is passed in, uses it as tag, otherwise uses tag of "latest"
function tag {
    docker tag -f ${image_name}:${branch_name} ${image_name}:${additional_tag}
    echo "Successfully tagged: ${image_name}:${additional_tag}"
    echo "All images:"
    docker images ${image_name}
}

function push {
    docker push ${image_name}
}

case $1 in
  build)
    build "$@"
  ;;
  tag)
    tag "$@"
  ;;
  push)
    push "$@"
  ;;
  *)
    echo "Not a valid function: $1"
  ;;
esac
