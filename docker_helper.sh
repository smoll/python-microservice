#!/bin/bash

set -e

namespace="smoll"
current_dir="${PWD##*/}"
image_name="$namespace/$current_dir"

branch_name=$(git symbolic-ref -q HEAD)
branch_name=${branch_name##refs/heads/}
branch_name=${branch_name:-HEAD}

if [ -n "$2" ]; then
    primary_tag="$2"
else
    primary_tag="$branch_name"
fi

function build {
    docker build --tag=${image_name}:${primary_tag} .
    echo "Succesfully built: ${image_name}:${primary_tag}"
}

function tag {
    docker tag -f ${image_name}:${primary_tag} ${image_name}:latest
    echo "Tagged images:"
    echo "- ${image_name}:${primary_tag}"
    echo "- ${image_name}:latest"
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
