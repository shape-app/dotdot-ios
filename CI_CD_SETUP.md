# CI/CD Setup Guide

This document explains how to configure the CI/CD pipeline for dotdot iOS.

## Overview

The CI/CD pipeline consists of two main workflows:

1. **CI Workflow** (`ci.yml`) - Runs on every PR and push to main
   - SwiftLint code quality checks
   - Build verification
   - Unit and UI tests

2. **Deploy Workflow** (`deploy.yml`) - Deploys to TestFlight
   - Automatic deployment to TestFlight Internal on main merge
   - Manual trigger for TestFlight External
   - Automated build number incrementation

## Prerequisites

Before setting up CI/CD, you need:

1. **Apple Developer Account** (Team Admin or App Manager role)
2. **App Store Connect Access** with appropriate permissions
3. **GitHub Repository** with admin access to configure secrets

## Initial Setup

### 1. Create App in App Store Connect

1. Log in to [App Store Connect](https://appstoreconnect.apple.com)
2. Go to "My Apps" and click the "+" button
3. Select "New App"
4. Fill in:
   - Platform: iOS
   - Name: dotdot
   - Primary Language: English (U.S.)
   - Bundle ID: `com.shape.dotdot`
   - SKU: `dotdot-ios` (or any unique identifier)
5. Click "Create"

### 2. Generate App Store Connect API Key

1. Go to App Store Connect → Users and Access → Keys
2. Click the "+" button to generate a new key
3. Name: `GitHub Actions CI/CD`
4. Access: **App Manager** role
5. Click "Generate"
6. **Download the .p8 file** (you can only download it once!)
7. Note the:
   - **Key ID** (e.g., `ABC123DEFG`)
   - **Issuer ID** (found at the top of the Keys page)

### 3. Create Code Signing Certificate

#### Option A: Using Fastlane Match (Recommended)

Fastlane Match stores your certificates and provisioning profiles in a git repository, making it easy to share across CI and team members.

1. Create a **private** git repository for certificates (e.g., `dotdot-ios-certificates`)

2. Run Match setup:
```bash
cd /path/to/dotdot
fastlane match init
# Select "git" as storage mode
# Enter the certificate repository URL
```

3. Generate certificates and profiles:
```bash
# Generate App Store certificate and profile
fastlane match appstore

# You'll be asked to create a passphrase - store this securely!
```

4. The certificates are now stored in your private certificate repo

#### Option B: Manual Certificate Export

1. Open Xcode → Preferences → Accounts
2. Select your Apple ID → Select your team
3. Click "Manage Certificates"
4. Create a new "Apple Distribution" certificate if you don't have one
5. Export the certificate:
   - Open Keychain Access
   - Find the "Apple Distribution" certificate
   - Right-click → Export
   - Save as `.p12` file with a password
6. Create provisioning profile in [Apple Developer Portal](https://developer.apple.com):
   - Certificates, Identifiers & Profiles → Profiles
   - Create "App Store" profile for `com.shape.dotdot`

### 4. Configure GitHub Secrets

Go to your GitHub repository → Settings → Secrets and variables → Actions

Add the following secrets:

#### Required for CI (Build and Test)
- None! CI runs without code signing

#### Required for Deployment

| Secret Name | Description | How to Get |
|------------|-------------|------------|
| `APP_STORE_CONNECT_API_KEY` | Content of the .p8 file | Open the .p8 file in a text editor, copy entire content |
| `APP_STORE_CONNECT_KEY_ID` | Key ID from App Store Connect | From step 2 above (e.g., `ABC123DEFG`) |
| `APP_STORE_CONNECT_ISSUER_ID` | Issuer ID from App Store Connect | From the top of the Keys page |
| `CERTIFICATES_P12` | Base64 encoded .p12 certificate | Run: `base64 -i certificate.p12 \| pbcopy` |
| `CERTIFICATES_PASSWORD` | Password for the .p12 file | The password you set when exporting |
| `KEYCHAIN_PASSWORD` | Temporary keychain password | Any secure random password (e.g., `openssl rand -base64 32`) |
| `FASTLANE_USER` | Apple ID email | Your Apple Developer account email |
| `FASTLANE_PASSWORD` | Apple ID password | Your Apple ID password OR app-specific password* |
| `APP_STORE_CONNECT_TEAM_ID` | Team ID from App Store Connect | App Store Connect → Account → Membership (10-digit number) |
| `DEVELOPER_PORTAL_TEAM_ID` | Team ID from Developer Portal | Developer Portal → Membership (10-character string) |

**App-Specific Password:** If you have 2FA enabled (required), generate an app-specific password:
1. Go to [appleid.apple.com](https://appleid.apple.com)
2. Sign in → Security → App-Specific Passwords
3. Generate password for "GitHub Actions"
4. Use this instead of your Apple ID password

#### Optional for Match (if using Option A)
| Secret Name | Description |
|------------|-------------|
| `MATCH_PASSWORD` | Passphrase for Match certificates |
| `MATCH_GIT_BASIC_AUTHORIZATION` | Base64 of `username:token` for private cert repo |

## Workflows

### CI Workflow (Automatic)

**Trigger:** Every pull request and push to `main`

**Steps:**
1. SwiftLint checks code quality
2. Builds the app for iOS Simulator
3. Runs all unit and UI tests
4. Uploads test results as artifacts

**Status:** Required to pass before PR can be merged

### Deploy Workflow (Automatic + Manual)

**Automatic Trigger:** Every push to `main` (after CI passes)
- Deploys to **TestFlight Internal** testing

**Manual Trigger:** GitHub Actions → Deploy to TestFlight → Run workflow
- Choose: Internal or External testing
- External testing requires external tester group setup in App Store Connect

**Steps:**
1. Increments build number automatically
2. Sets up code signing with certificates
3. Builds release IPA
4. Uploads to TestFlight
5. Tags the release in git
6. Notifies testers (if external)

## Setting Up TestFlight Testers

### Internal Testing (Automatic)

1. Go to App Store Connect → TestFlight → Internal Testing
2. All users with App Manager or Admin role can test automatically
3. They'll receive notifications when new builds are available

### External Testing (Manual)

1. Go to App Store Connect → TestFlight → External Testing
2. Create a new group (e.g., "Beta Testers")
3. Add testers by email
4. When you manually trigger the deploy workflow with "external":
   - External testers will be notified
   - Build must pass App Store review (usually quick)

## Testing the CI/CD Pipeline

### Test CI Workflow

1. Create a new branch: `git checkout -b test/ci-pipeline`
2. Make a small change (add a comment to a file)
3. Commit and push
4. Open a PR to `main`
5. Watch GitHub Actions run:
   - SwiftLint check should pass
   - Build should succeed
   - Tests should pass (may fail if no tests yet - this is expected)

### Test Deploy Workflow (Once Configured)

**Warning:** Only test deployment after setting up all secrets properly!

1. Ensure all secrets are configured in GitHub
2. Merge a PR to `main`
3. Watch the deploy workflow trigger automatically
4. Check App Store Connect → TestFlight for the new build
5. Build will say "Processing" for ~10 minutes before available

## Troubleshooting

### SwiftLint Fails
- Check that SwiftLint is installed in CI (it is by default)
- Fix linting errors locally: `swiftlint autocorrect`
- View specific errors in GitHub Actions logs

### Build Fails in CI
- Check that scheme is shared in Xcode:
  1. Open dotdot.xcodeproj
  2. Product → Scheme → Manage Schemes
  3. Ensure "dotdot" scheme has "Shared" checked
  4. Commit the .xcscheme file

### Code Signing Fails
- Verify all secrets are set correctly
- Check certificate hasn't expired in Developer Portal
- Ensure provisioning profile includes the correct App ID
- Check that bundle ID matches exactly: `com.shape.dotdot`

### TestFlight Upload Fails
- Verify App Store Connect API key is valid
- Check that app exists in App Store Connect
- Ensure you have App Manager role
- Check Fastlane logs for specific error messages

### Build Number Conflicts
- If you manually uploaded a build, CI may try to use same build number
- The workflow auto-increments based on timestamp, so this is rare
- If it happens, manually increment in Xcode and commit

## Version Management

### Version Numbers

- **Version:** Semantic versioning (e.g., `1.0.0`)
  - Manually set in Xcode before releases
  - Or use: `fastlane run increment_version_number version_number:1.0.0`

- **Build Number:** Auto-incremented by CI
  - Uses timestamp: `$(date +%s) / 60`
  - Unique for every deployment

### Creating a Release

1. Update version number in Xcode to next semantic version
2. Commit: `git commit -am "Bump version to 1.0.0"`
3. Merge to `main`
4. CI will automatically build and deploy to TestFlight Internal
5. Manually trigger external deployment if needed
6. Git tag is automatically created: `testflight/1.0.0/BUILD_NUMBER`

## Monitoring

### GitHub Actions Dashboard

- Repository → Actions tab
- View all workflow runs
- Click any run to see detailed logs
- Download test result artifacts

### App Store Connect

- TestFlight tab shows all builds
- View installation analytics
- Read crash reports
- Manage tester groups

## Maintenance

### Updating Xcode Version

When a new Xcode version is released:

1. Update `DEVELOPER_DIR` in workflow files:
```yaml
env:
  DEVELOPER_DIR: /Applications/Xcode_15.3.app/Contents/Developer
```

2. Update iOS simulator destination:
```yaml
destination: platform=iOS Simulator,name=iPhone 15,OS=17.4
```

3. Test locally before committing

### Certificate Renewal

Certificates expire after 1 year:

1. Generate new certificate using Match or manually
2. Update `CERTIFICATES_P12` secret in GitHub
3. No workflow changes needed

## Security Best Practices

1. **Never commit secrets** to the repository
2. **Rotate secrets** annually or when team members leave
3. **Use app-specific passwords** instead of Apple ID password
4. **Limit GitHub secret access** to necessary team members
5. **Enable branch protection** on `main` requiring PR reviews
6. **Review workflow runs** regularly for anomalies

## Support

For issues with:
- **GitHub Actions:** Check Actions tab logs
- **Fastlane:** Run `fastlane` locally to reproduce
- **App Store Connect:** Check [Apple Developer Forums](https://developer.apple.com/forums/)
- **Certificates:** Verify in [Developer Portal](https://developer.apple.com)

## Next Steps

Once CI/CD is set up:
1. ✅ Every PR will automatically build and test
2. ✅ Every merge to main deploys to TestFlight Internal
3. ✅ Team can test builds immediately
4. ✅ Production releases are one button click away

Now you're ready to start developing features with confidence!
