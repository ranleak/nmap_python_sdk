from setuptools import setup, find_packages

setup(
    name="nmap-bundled-sdk",
    version="0.1.0",
    description="Python SDK for Nmap with bundled executable",
    packages=find_packages(),
    include_package_data=True, # Crucial: Tells setuptools to read MANIFEST.in
    python_requires=">=3.7",
)