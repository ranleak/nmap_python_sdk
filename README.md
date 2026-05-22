# Nmap Python SDK
A standalone Python SDK for Nmap that comes with a built-in, precompiled Nmap executable.

Unlike standard Nmap wrappers (which require the ```nmap``` binary to be installed on the host system) or C-extension packages (which compile on every ```pip install```), this package relies on a pre-compiled binary. This ensures lightning-fast installation and guarantees portability across environments without requiring host-level dependencies or build tools.

### ⚠️ Disclaimer
**Nmap is a powerful network scanning and security auditing tool.** You must have explicit, authorized permission to scan any target networks or IP addresses. The author of this SDK (ranleak) is not responsible for any misuse, damage, or legal consequences resulting from the use of this software.

## Installation
You can install via git, as we are not yet publishing on PyPi.
```
pip install git+https://github.com/ranleak/nmap_python_sdk
```

## Quickstart
The SDK automatically locates and uses the bundled binary, sidestepping the system ```PATH```.
```python
from nmap_sdk import NmapScanner

# Initialize the scanner
scanner = NmapScanner()

# Run a simple ping scan
ping_results = scanner.scan("192.168.1.0/24", arguments="-sn")
print(ping_results)

# Run a specific port scan
port_results = scanner.scan("127.0.0.1", arguments="-p 80,443 -sV")
print(port_results)
```

## For Developers: Building the Package
If you are cloning this repo and want to build the SDK from source, you need to compile the Nmap binary *before* building the Python wheel.

### Prerequisites
To build the Nmap binary, your build machine needs basic compilation tools (e.g., ```build-essential``` on Debian/Ubuntu, Xcode Command Line Tools on MacOS, or the Android NDK for Android).

### 1. Compile Nmap
Run the bash script corresponding to your target platform (we don't support Windows... *yet*!). This will download the Nmap source, configure it (without GUI tools to save space), compile it, and place the binary inside the Python package directory.
```
# For Linux
chmod +x ci-build-scripts/build_nmap_linux.sh
./ci-build-scripts/build_nmap_linux.sh

# For MacOS
chmod +x ci-build-scripts/build_nmap_macos.sh
./ci-build-scripts/build_nmap_macos.sh

# For Android (Requires ANDROID_NDK_ROOT to be set)
chmod +x ci-build-scripts/build_nmap_android.sh
./ci-build-scripts/build_nmap_android.sh
```

### 2. Build the Python Wheel
Once the ```nmap``` binary is located in ```nmap_sdk/bin/```, you can package the Python SDK. The MANIFEST.in file ensures the binary is included in the final distribution.
```
pip install build
python -m build
```
The resulting ```.whl``` and ```.tar.gz``` files will be located in the ```dist/``` directory.

### 3. CI/CD Considerations
Because the binary is OS and Architecture dependent, these scripts are designed to be run inside a CI/CD pipeline (like Github Actions or GitLab CI) using a matrix strategy to generate specific wheels for Linux, MacOS, and Android.

### License
This project is licensed under the MIT License. Note that Nmap itself is licensed under the Nmap Public Source License (NPSL). Please review the [Nmap licensing terms](/nmap_license.txt) if you plan to distribute this package comercially.