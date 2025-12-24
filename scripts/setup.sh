#!/bin/bash
# Copyright (c) 2025-present Shape
# Licensed under the MIT License
#
# Setup script for dotdot iOS development environment

set -e

echo "Setting up dotdot iOS development environment..."
echo ""

# Check Xcode installation
if ! command -v xcodebuild &> /dev/null; then
    echo "[ERROR] Xcode is not installed. Please install Xcode from the App Store."
    exit 1
fi

echo "[OK] Xcode found: $(xcodebuild -version | head -n 1)"
echo ""

# Install SwiftLint
if ! command -v swiftlint &> /dev/null; then
    echo "[INSTALL] Installing SwiftLint..."
    brew install swiftlint
else
    echo "[OK] SwiftLint found: $(swiftlint version)"
fi
echo ""

echo "[OK] Setup complete!"
echo ""
echo "Next steps:"
echo "  1. Open dotdot.xcodeproj in Xcode"
echo "  2. Select your development team in project settings"
echo "  3. Build and run (Cmd+R)"
echo ""
echo "Useful commands:"
echo "  - Run tests: xcodebuild test -scheme dotdot"
echo "  - Run linter: swiftlint"
echo ""
