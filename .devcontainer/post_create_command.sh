#!/bin/bash
set -e

sudo apt-get update && sudo apt-get install -y wget unzip

# Download LibTorch
LIBTORCH_URL="https://download.pytorch.org/libtorch/cpu/libtorch-cxx11-abi-shared-with-deps-2.4.0%2Bcpu.zip"
LIBTORCH_DIR="/usr/local/libtorch"

wget -O libtorch.zip "$LIBTORCH_URL"
sudo unzip libtorch.zip -d /usr/local
rm libtorch.zip

# Set environment variables
echo "export LIBTORCH=$LIBTORCH_DIR" >> ~/.bashrc
echo "export LD_LIBRARY_PATH=$LIBTORCH_DIR/lib:$LD_LIBRARY_PATH" >> ~/.bashrc

# Configure bundle to use the correct torch directory
echo "Setting torch directory to: $LIBTORCH_DIR"
bundle config build.torch-rb --with-torch-dir="$LIBTORCH_DIR"

# Verify the torch directory exists
echo "Verifying torch directory:"
ls -l "$LIBTORCH_DIR" || echo "Torch directory not found at $LIBTORCH_DIR"

bin/setup
