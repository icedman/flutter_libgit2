# Weird building method for android

make build-ssl
make build-ssh
make touch ...<<<< if build fails
make build-ssh
make build-git2

ssh2
comment out examples and testing

git2
OPTION(USE_SSH              "Link with libssh2 to enable SSH support"        OFF)
OPTION(BUILD_SHARED_LIBS        "Build Shared Library (OFF for Static)"          OFF)
option(USE_SHA1                "Enable SHA1. Can be set to CollisionDetection(ON)/HTTPS" HTTPS)