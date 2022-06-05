cmake_minimum_required(VERSION 3.10)
project(api LANGUAGES CXX C)

string(APPEND CMAKE_CXX_FLAGS " -std=gnu++11")
set (CMAKE_CXX_STANDARD 11)

add_library(api
  SHARED
  ./api.cpp
  exports.def
)

############################################
#
# build android
#

if (CMAKE_SYSTEM_NAME STREQUAL "Android")

if (DEFINED ENV{BUILD_SSL})
add_subdirectory(./openssl)
target_link_libraries(api PRIVATE ssl crypto)
endif()

if (DEFINED ENV{BUILD_SSH2} OR DEFINED ENV{BUILD_GIT2})
set(OPENSSL_CRYPTO_LIBRARY ${CMAKE_SOURCE_DIR}/../precompiled/android/${ANDROID_ABI}/openssl/crypto/libcrypto_1_1.a)
set(OPENSSL_SSL_LIBRARY ${CMAKE_SOURCE_DIR}/../precompiled/android/${ANDROID_ABI}/openssl/ssl/libssl_1_1.a)

set(OPENSSL_FOUND 1)
set(OPENSSL_INCLUDE_DIR ${CMAKE_SOURCE_DIR}/../precompiled/android/${ANDROID_ABI}/openssl/include)

set(USE_HTTPS "OpenSSL")

add_library(ssl
        STATIC
        IMPORTED)

set_target_properties(ssl
        PROPERTIES IMPORTED_LOCATION
        ${CMAKE_SOURCE_DIR}/../precompiled/android/${ANDROID_ABI}/openssl/ssl/libssl_1_1.a)

add_library(crypto
        STATIC
        IMPORTED)

set_target_properties(crypto
        PROPERTIES IMPORTED_LOCATION
        ${CMAKE_SOURCE_DIR}/../precompiled/android/${ANDROID_ABI}/openssl/crypto/libcrypto_1_1.a)
endif()


if (DEFINED ENV{BUILD_SSH2})

set(USE_SSH OFF)
set(BUILD_TESTING OFF)
set(BUILD_EXAMPLES OFF)

add_subdirectory(./libssh2)
target_link_libraries(api PRIVATE ssl crypto libssh2)
endif()


if (DEFINED ENV{BUILD_GIT2})

set(BUILD_CLI OFF)
set(BUILD_TESTS OFF)
set(BUILD_FUZZERS OFF)

set(LIBSSH2_FOUND 1)
set(LIBSSH2_INCLUDE_DIRS ${CMAKE_SOURCE_DIR}/libssh2/include)
set(LIBSSH2_LDFLAGS "")

set(REGEX_BACKEND "builtin")

# set(BUILD_SHARED_LIBS OFF)

add_library(libssh2
        STATIC
        IMPORTED)

set_target_properties(libssh2
        PROPERTIES IMPORTED_LOCATION
        ${CMAKE_SOURCE_DIR}/../precompiled/android/${ANDROID_ABI}/libssh2/libssh2.a)

set(LIBSSH2_LIBRARIES ${CMAKE_SOURCE_DIR}/../precompiled/android/${ANDROID_ABI}/libssh2/libssh2.a)

add_subdirectory(./libgit2)

endif()

else()

############################################
#
# build linux
#


if (DEFINED ENV{BUILD_SSL})
add_subdirectory(./openssl)
target_link_libraries(api PRIVATE ssl crypto)
endif()

if (DEFINED ENV{BUILD_SSH2} OR DEFINED ENV{BUILD_GIT2})
set(OPENSSL_CRYPTO_LIBRARY ${CMAKE_SOURCE_DIR}/../precompiled/linux/openssl/crypto/libcrypto.a)
set(OPENSSL_SSL_LIBRARY ${CMAKE_SOURCE_DIR}/../precompiled/linux/openssl/ssl/libssl.a)

set(OPENSSL_FOUND 1)
set(OPENSSL_INCLUDE_DIR ${CMAKE_SOURCE_DIR}/../precompiled/linux/openssl/include)

set(USE_HTTPS "OpenSSL")

add_library(ssl
        STATIC
        IMPORTED)

set_target_properties(ssl
        PROPERTIES IMPORTED_LOCATION
        ${CMAKE_SOURCE_DIR}/../precompiled/linux/openssl/ssl/libssl.a)

add_library(crypto
        STATIC
        IMPORTED)

set_target_properties(crypto
        PROPERTIES IMPORTED_LOCATION
        ${CMAKE_SOURCE_DIR}/../precompiled/linux/openssl/crypto/libcrypto.a)
endif()


if (DEFINED ENV{BUILD_SSH2})

set(USE_SSH OFF)
set(BUILD_TESTING OFF)
set(BUILD_EXAMPLES OFF)

add_subdirectory(./libssh2)
target_link_libraries(api PRIVATE ssl crypto libssh2)
endif()


if (DEFINED ENV{BUILD_GIT2})

set(BUILD_CLI OFF)
set(BUILD_TESTS OFF)
set(BUILD_FUZZERS OFF)

set(LIBSSH2_FOUND 1)
set(LIBSSH2_INCLUDE_DIRS ${CMAKE_SOURCE_DIR}/libssh2/include)
set(LIBSSH2_LDFLAGS "")

set(REGEX_BACKEND "builtin")

# set(BUILD_SHARED_LIBS OFF)

add_library(libssh2
        STATIC
        IMPORTED)

set_target_properties(libssh2
        PROPERTIES IMPORTED_LOCATION
        ${CMAKE_SOURCE_DIR}/../precompiled/linux/libssh2/libssh2.a)

set(LIBSSH2_LIBRARIES ${CMAKE_SOURCE_DIR}/../precompiled/linux/libssh2/libssh2.a)

add_subdirectory(./libgit2)

endif()

endif()


set_target_properties(api PROPERTIES
  BUILD_WITH_INSTALL_RPATH 1 INSTALL_RPATH "$ORIGIN")

