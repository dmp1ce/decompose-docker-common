#!/bin/bash

function setup_testing_environment() {
  echo "Setting up Docker testing environment ..."
  # Create dind daemon with a mount to project.
  testing_env_build=$(docker run --privileged --name decompose-docker-docker-testing -d docker:dind)
  [ "$?" == "1" ] && echo "$testing_env_build"

  # Build testing image
  local project_directory=$(readlink -f "$DIR/../")
  local tmp_tester_build="/tmp/decompose-docker-docker-testing"
  # Copy volume so we can safely dereference symlinks
  # Create docker container for doing tests
  cp -rL "$project_directory/." "$tmp_tester_build"
  cp "$project_directory/test/Dockerfile.tester" "$tmp_tester_build/Dockerfile"
  local testing_env_build=$(docker build -t decompose-docker-docker-testing-tester "$tmp_tester_build/.")
  [ "$?" == "1" ] && echo "$testing_env_build"
}

function run_tests() {
  local tester_image="docker run --rm --link decompose-docker-docker-testing:docker \
decompose-docker-docker-testing-tester"

  $tester_image bats /app/test/bats
}

function teardown_testing_environment() {
  echo "Teardown Docker testing environment ..."
  testing_env_cleanup=$(docker rm -fv decompose-docker-docker-testing)
  [ "$?" == "1" ] && echo "$testing_env_cleanup"

  local tmp_tester_build="/tmp/decompose-docker-docker-testing"
  mv "$tmp_tester_build" "$tmp_tester_build-$(uuidgen)"

  testing_env_cleanup=$(docker rmi decompose-docker-docker-testing-tester)
  [ "$?" == "1" ] && echo "$testing_env_cleanup"
}
