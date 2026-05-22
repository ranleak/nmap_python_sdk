#!/bin/bash
set -e

# Linux CI Build Script for Nmap
NMAP_VERSION="7.94"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
SDK_BIN_DIR="$DIR/../nmap_sdk/bin"

echo "Downloading Nmap v${NMAP_VERSION} for Linux..."
curl -O https://nmap.org/dist/nmap-${NMAP_VERSION}.tar.bz2

echo "Extracting..."
tar -xjf nmap-${NMAP_VERSION}.tar.bz2

echo "Compiling Nmap for Linux..."
cd nmap-${NMAP_VERSION}

# Configure Nmap without a GUI or extra tools to save space
./configure --without-zenmap --without-ncat --without-ndiff --without-nping
make -j$(nproc)

echo "Copying binary to SDK directory..."
mkdir -p "${SDK_BIN_DIR}"
cp nmap "${SDK_BIN_DIR}/"

echo "Cleaning up..."
cd ..
rm -rf nmap-${NMAP_VERSION} nmap-${NMAP_VERSION}.tar.bz2

echo "Linux Nmap compiled successfully!"