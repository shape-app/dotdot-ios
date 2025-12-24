# CI Setup Guide

This document explains how the CI (Continuous Integration) pipeline works for dotdot iOS.

## Overview

The CI pipeline runs on every pull request and push to `main` to ensure code quality:

1. **SwiftLint** - Code quality checks
2. **Build Verification** - Ensures the app compiles successfully
3. **Tests** - Runs unit and UI tests

> **Note:** Deployment to TestFlight will be added later when features are ready (Phase 6-9 per tech spec). The Fastfile contains deployment lanes for future use.

## How It Works

### CI Workflow (Automatic)

**Trigger:** Every pull request and push to `main`

**Steps:**
1. ✅ SwiftLint checks code quality
2. ✅ Builds the app for iOS Simulator
3. ✅ Runs all unit and UI tests
4. ✅ Uploads test results as artifacts

**Status:** Required to pass before PR can be merged (when branch protection is enabled)

## Prerequisites

For CI to work, you only need:
- ✅ **GitHub Repository** (already set up)
- ✅ **SwiftLint** (installed automatically in CI)

No Apple Developer account or certificates needed for CI - it builds for simulator without code signing.

## Testing the CI Pipeline

### Test CI Workflow

1. Create a new branch: `git checkout -b test/ci-pipeline`
2. Make a small change (add a comment to a file)
3. Commit and push
4. Open a PR to `main`
5. Watch GitHub Actions run:
   - SwiftLint check should pass
   - Build should succeed
   - Tests should pass (may fail if no tests yet - this is expected)

## Troubleshooting

### SwiftLint Fails
- Check that SwiftLint is installed locally: `swiftlint version`
- Fix linting errors locally: `swiftlint autocorrect`
- View specific errors in GitHub Actions logs

### Build Fails in CI
- Check that scheme is shared in Xcode:
  1. Open `dotdot.xcodeproj`
  2. Product → Scheme → Manage Schemes
  3. Ensure "dotdot" scheme has "Shared" checked
  4. Commit the `.xcscheme` file

### Tests Fail
- This is expected if you haven't written tests yet
- Add tests in `dotdotTests/` (unit tests) or `dotdotUITests/` (UI tests)
- Run tests locally first: `xcodebuild test -project dotdot.xcodeproj -scheme dotdot`

## Local Development

### Running CI Checks Locally

```bash
# Run SwiftLint
swiftlint

# Build the app
xcodebuild clean build -project dotdot.xcodeproj -scheme dotdot

# Run tests
xcodebuild test -project dotdot.xcodeproj -scheme dotdot
```

Or use Fastlane (after running `bundle install`):

```bash
# Run linting
bundle exec fastlane lint

# Run tests
bundle exec fastlane test

# Build app
bundle exec fastlane build
```

## Monitoring

### GitHub Actions Dashboard

- Repository → Actions tab
- View all workflow runs
- Click any run to see detailed logs
- Download test result artifacts

## Maintenance

### Updating Xcode Version

When a new Xcode version is released:

1. Update `DEVELOPER_DIR` in `.github/workflows/ci.yml`:
```yaml
env:
  DEVELOPER_DIR: /Applications/Xcode_15.3.app/Contents/Developer
```

2. Update iOS simulator destination:
```yaml
destination: platform=iOS Simulator,name=iPhone 15,OS=17.4
```

3. Test locally before committing

## Future: Deployment (To Be Added)

When ready to add TestFlight deployment (Phase 6-9):

- Fastfile already contains `deploy_testflight` lane for future use
- Will require App Store Connect setup
- See Fastfile comments for deployment configuration
- Will add `.github/workflows/deploy.yml` when needed

## Support

For issues with:
- **GitHub Actions:** Check Actions tab logs
- **SwiftLint:** Run locally to reproduce: `swiftlint lint`
- **Build/Tests:** Try building locally in Xcode first
