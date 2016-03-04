#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"


function setup_testing_environment() {
  echo "Setup Docker testing environment"
  # Create dind daemon with a mount to project.
  docker run --privileged --name decompose-docker-common-testing -d docker:dind
}

function run_tests() {
  echo "Running BATS tests"
  bats "$DIR/bats/dind.bats"
}

function teardown_testing_environment() {
  echo "Teardown Docker testing environment"
  docker rm -f decompose-docker-common-testing
}

function main() {
  local return_code=0

  setup_testing_environment
  run_tests || local return_code=1
  teardown_testing_environment

  exit $return_code
}

main

# vim:syntax=sh tabstop=2 shiftwidth=2 expandtab
