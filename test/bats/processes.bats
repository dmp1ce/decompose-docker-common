#!/usr/bin/env bats

load "$BATS_TEST_DIRNAME/bats_functions.bash"

@test "docker build process returns error code" {
  cd "$WORKING"
  echo "Corrupting docker-compose.yml to get error from build"
  echo "Syntax error" >> docker-compose.yml 
  run decompose docker_build

  echo "$output"
  [ "$status" -ne 0 ]
}

@test "Help functions do not output any errors" {
  cd "$WORKING"
  error_output=$(decompose --help 2>&1 >/dev/null)
  echo "$error_output"
  [ -z "$error_output" ]
}

function setup() {
  setup_testing_environment
} 

function teardown() {
  teardown_testing_environment
}

# vim:syntax=sh tabstop=2 shiftwidth=2 expandtab
