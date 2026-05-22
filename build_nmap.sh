#!/bin/bash
set -e

# Define Nmap version
NMAP_VERSION="7.94"
SDK_BIN_DIR="$(pwd)/nmap_sdk/bin"

echo "Downloading Nmap v${NMAP_VERSION}..."
curl -O https://nmap.org/dist/nmap-${NMAP_VERSION}.tar.bz2

echo "Extracting..."
tar -xjf nmap-${NMAP_VERSION}.tar.bz2

echo "Compiling Nmap..."
cd nmap-${NMAP_VERSION}

# Configure Nmap without a GUI (Zenmap) or Ncat to save space
./configure --without-zenmap --without-ncat --without-ndiff --without-nping
make -j$(nproc)

echo "Copying binary to SDK directory..."
mkdir -p "${SDK_BIN_DIR}"
cp nmap "${SDK_BIN_DIR}/"

echo "Cleaning up..."
cd ..
rm -rf nmap-${NMAP_VERSION} nmap-${NMAP_VERSION}.tar.bz2

echo "Nmap compiled and placed in nmap_sdk/bin/nmap successfully!"