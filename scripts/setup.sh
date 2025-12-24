#!/bin/bash

# Setup script for dotdot iOS development environment

set -e

echo "🚀 Setting up dotdot iOS development environment..."
echo ""

# Check Xcode installation
if ! command -v xcodebuild &> /dev/null; then
    echo "❌ Xcode is not installed. Please install Xcode from the App Store."
    exit 1
fi

echo "✅ Xcode found: $(xcodebuild -version | head -n 1)"
echo ""

# Check Ruby
if ! command -v ruby &> /dev/null; then
    echo "❌ Ruby is not installed. Please install Ruby."
    exit 1
fi

echo "✅ Ruby found: $(ruby --version)"
echo ""

# Install Bundler
if ! command -v bundle &> /dev/null; then
    echo "📦 Installing Bundler..."
    gem install bundler
else
    echo "✅ Bundler found: $(bundle --version)"
fi
echo ""

# Install Ruby dependencies
echo "📦 Installing Ruby dependencies (Fastlane, CocoaPods)..."
bundle install
echo ""

# Install SwiftLint
if ! command -v swiftlint &> /dev/null; then
    echo "📦 Installing SwiftLint..."
    brew install swiftlint
else
    echo "✅ SwiftLint found: $(swiftlint version)"
fi
echo ""

# Install CocoaPods dependencies (if Podfile exists)
if [ -f "Podfile" ]; then
    echo "📦 Installing CocoaPods dependencies..."
    bundle exec pod install
    echo ""
fi

# Open project
echo "✅ Setup complete!"
echo ""
echo "📝 Next steps:"
echo "  1. Open dotdot.xcodeproj in Xcode"
echo "  2. Select your development team in project settings"
echo "  3. Build and run (⌘R)"
echo ""
echo "🔧 Useful commands:"
echo "  • Run tests: bundle exec fastlane test"
echo "  • Run linter: swiftlint"
echo "  • Build app: bundle exec fastlane build"
echo ""
echo "📚 Documentation:"
echo "  • CI Setup: See CI_SETUP.md"
echo "  • Tech Spec: See TECH_SPEC.md"
echo ""
