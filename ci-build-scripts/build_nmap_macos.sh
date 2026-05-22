#!/bin/bash
set -e

# macOS CI Build Script for Nmap
NMAP_VERSION="7.94"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
SDK_BIN_DIR="$DIR/../nmap_sdk/bin"

echo "Downloading Nmap v${NMAP_VERSION} for macOS..."
curl -O https://nmap.org/dist/nmap-${NMAP_VERSION}.tar.bz2

echo "Extracting..."
tar -xjf nmap-${NMAP_VERSION}.tar.bz2

echo "Compiling Nmap for macOS..."
cd nmap-${NMAP_VERSION}

# Configure Nmap without extra tools
./configure --without-zenmap --without-ncat --without-ndiff --without-nping
# macOS uses sysctl to determine the number of CPU cores
make -j$(sysctl -n hw.ncpu)

echo "Copying binary to SDK directory..."
mkdir -p "${SDK_BIN_DIR}"
cp nmap "${SDK_BIN_DIR}/"

echo "Cleaning up..."
cd ..
rm -rf nmap-${NMAP_VERSION} nmap-${NMAP_VERSION}.tar.bz2

echo "macOS Nmap compiled successfully!"