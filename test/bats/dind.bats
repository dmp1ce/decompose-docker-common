#!/usr/bin/env bats

@test "test dind" {
  local project_directory=$(readlink -f "$BATS_TEST_DIRNAME/../../")
  # Copy volume so we can safely dereference symlinks
  # Create docker container for doing tests
  docker run -v $project_directory:/project --rm --link decompose-docker-common-testing:docker docker sh -c "cp -rL /project /project-no-symlinks && docker build -t tester /project-no-symlinks/test/bats/fixtures/docker-compose/."

  docker run --rm --link decompose-docker-common-testing:docker docker run --rm tester echo "Is this working?"
}

@test "another test" {
  docker run --rm --link decompose-docker-common-testing:docker docker run busybox echo "hello"
  echo "more"
} 

# vim:syntax=sh tabstop=2 shiftwidth=2 expandtab
