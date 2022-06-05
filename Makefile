all: build-ssl build-ssh2 build-git2

linux: build-ssl-linux build-ssh2-linux build-git2-linux

.PHONY: build-ssl build-ssh2 build-git2
	
build-ssl:
	mkdir -p precompiled/android/arm64-v8a/openssl/crypto
	mkdir -p precompiled/android/armeabi-v7a/openssl/crypto
	mkdir -p precompiled/android/x86/openssl/crypto
	mkdir -p precompiled/android/x86_64/openssl/crypto
	mkdir -p precompiled/android/arm64-v8a/openssl/ssl
	mkdir -p precompiled/android/armeabi-v7a/openssl/ssl
	mkdir -p precompiled/android/x86/openssl/ssl
	mkdir -p precompiled/android/x86_64/openssl/ssl
	BUILD_SSL=1 flutter build apk -v
	cp -rf android/app/.cxx/cmake/release/arm64-v8a/openssl/include precompiled/android/arm64-v8a/openssl
	cp -rf android/app/.cxx/cmake/release/armeabi-v7a/openssl/include precompiled/android/armeabi-v7a/openssl
	cp -rf android/app/.cxx/cmake/release/x86/openssl/include precompiled/android/x86/openssl
	cp -rf android/app/.cxx/cmake/release/x86_64/openssl/include precompiled/android/x86_64/openssl
	cp -rf android/app/.cxx/cmake/release/arm64-v8a/openssl/crypto/*.a precompiled/android/arm64-v8a/openssl/crypto
	cp -rf android/app/.cxx/cmake/release/armeabi-v7a/openssl/crypto/*.a precompiled/android/armeabi-v7a/openssl/crypto
	cp -rf android/app/.cxx/cmake/release/x86/openssl/crypto/*.a precompiled/android/x86/openssl/crypto
	cp -rf android/app/.cxx/cmake/release/x86_64/openssl/crypto/*.a precompiled/android/x86_64/openssl/crypto
	cp -rf android/app/.cxx/cmake/release/arm64-v8a/openssl/ssl/*.a precompiled/android/arm64-v8a/openssl/ssl
	cp -rf android/app/.cxx/cmake/release/armeabi-v7a/openssl/ssl/*.a precompiled/android/armeabi-v7a/openssl/ssl
	cp -rf android/app/.cxx/cmake/release/x86/openssl/ssl/*.a precompiled/android/x86/openssl/ssl
	cp -rf android/app/.cxx/cmake/release/x86_64/openssl/ssl/*.a precompiled/android/x86_64/openssl/ssl

build-ssh2:
	mkdir -p precompiled/android/arm64-v8a/libssh2
	mkdir -p precompiled/android/armeabi-v7a/libssh2
	mkdir -p precompiled/android/x86/libssh2
	mkdir -p precompiled/android/x86_64/libssh2
	BUILD_SSH2=1 flutter build apk -v
	cp -rf android/app/.cxx/cmake/release/arm64-v8a/libssh2/src/*.a precompiled/android/arm64-v8a/libssh2
	cp -rf android/app/.cxx/cmake/release/armeabi-v7a/libssh2/src/*.a precompiled/android/armeabi-v7a/libssh2
	cp -rf android/app/.cxx/cmake/release/x86/libssh2/src/*.a precompiled/android/x86/libssh2
	cp -rf android/app/.cxx/cmake/release/x86_64/libssh2/src/*.a precompiled/android/x86_64/libssh2
	cp -rf android/app/.cxx/cmake/release/arm64-v8a/libssh2/src/*.a precompiled/android/arm64-v8a/libssh2
	cp -rf android/app/.cxx/cmake/release/armeabi-v7a/libssh2/src/*.a precompiled/android/armeabi-v7a/libssh2
	cp -rf android/app/.cxx/cmake/release/x86/libssh2/src/*.a precompiled/android/x86/libssh2
	cp -rf android/app/.cxx/cmake/release/x86_64/libssh2/src/*.a precompiled/android/x86_64/libssh2

build-git2:
	mkdir -p precompiled/android/arm64-v8a/libgit2
	mkdir -p precompiled/android/armeabi-v7a/libgit2
	mkdir -p precompiled/android/x86/libgit2
	mkdir -p precompiled/android/x86_64/libgit2
	BUILD_GIT2=1 flutter build apk -v
	cp -rf android/app/.cxx/cmake/release/arm64-v8a/libgit2/*.a precompiled/android/arm64-v8a/libgit2
	cp -rf android/app/.cxx/cmake/release/armeabi-v7a/libgit2/*.a precompiled/android/armeabi-v7a/libgit2
	cp -rf android/app/.cxx/cmake/release/x86/libgit2/*.a precompiled/android/x86/libgit2
	cp -rf android/app/.cxx/cmake/release/x86_64/libgit2/*.a precompiled/android/x86_64/libgit2

clean:
	rm -rf precompiled
	rm -rf android/app/.cxx

touch:
	touch libs/CMakeLists.txt

build-ssl-linux:
	mkdir -p precompiled/linux/openssl/crypto
	mkdir -p precompiled/linux/openssl/ssl
	BUILD_SSL=1 flutter build linux -v
	cp -rf build/linux/x64/release/libs/openssl/include precompiled/linux/openssl
	cp -rf build/linux/x64/release/libs/openssl/crypto/*.a precompiled/linux/openssl/crypto
	cp -rf build/linux/x64/release/libs/openssl/ssl/*.a precompiled/linux/openssl/ssl

build-libssh2-linux:
	mkdir -p precompiled/linux/libssh2
	BUILD_SSH2=1 flutter build linux -v
	cp -rf build/linux/x64/release/libs/libssh2/src/*.a precompiled/linux/libssh2
	cp -rf build/linux/x64/release/libs/libssh2/src/*.h precompiled/linux/libssh2

build-libgit2-linux:
	mkdir -p precompiled/linux/libgit2
	BUILD_GIT2=1 flutter build linux -v
	cp -rf build/linux/x64/release/libs/libgit2/*.a precompiled/linux/libgit2
