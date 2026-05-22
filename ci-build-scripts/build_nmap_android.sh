#!/bin/bash
set -e

# Android CI Build Script for Nmap (Cross-Compilation)
# Note: This requires the Android NDK to be installed and configured in your CI environment.
if [ -z "$ANDROID_NDK_ROOT" ]; then
    echo "Error: ANDROID_NDK_ROOT must be set to cross-compile for Android."
    exit 1
fi

NMAP_VERSION="7.94"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
SDK_BIN_DIR="$DIR/../nmap_sdk/bin"

echo "Downloading Nmap v${NMAP_VERSION} for Android..."
curl -O https://nmap.org/dist/nmap-${NMAP_VERSION}.tar.bz2

echo "Extracting..."
tar -xjf nmap-${NMAP_VERSION}.tar.bz2

echo "Cross-compiling Nmap for Android (aarch64)..."
cd nmap-${NMAP_VERSION}

# Configure for Android ARM64 cross-compilation
# Depending on the NDK version, additional environment variables like CC and CXX might need to be explicitly set.
./configure --host=aarch64-linux-android --without-zenmap --without-ncat --without-ndiff --without-nping
make -j$(nproc)

echo "Copying binary to SDK directory..."
mkdir -p "${SDK_BIN_DIR}"
cp nmap "${SDK_BIN_DIR}/"

echo "Cleaning up..."
cd ..
rm -rf nmap-${NMAP_VERSION} nmap-${NMAP_VERSION}.tar.bz2

echo "Android Nmap compiled successfully!"