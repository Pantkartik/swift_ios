# Advanced GitHub Actions for iOS

This guide covers advanced configurations for automating iOS workflows using GitHub Actions.

## 1. Managing Secrets

To build and distribute your app, you'll need sensitive information like API keys, certificates, and provisioning profiles.

- **GitHub Secrets**: Store these in `Settings > Secrets and variables > Actions`.
- **Environment Variables**: Access them in your workflow:
  ```yaml
  env:
    APP_STORE_CONNECT_API_KEY: ${{ secrets.APP_STORE_CONNECT_API_KEY }}
  ```

## 2. Caching Dependencies

Speed up your builds by caching `Pods` or `Swift Package Manager` dependencies.

```yaml
- name: Cache SwiftPM
  uses: actions/cache@v4
  with:
    path: .build
    key: ${{ runner.os }}-spm-${{ hashFiles('**/Package.resolved') }}
    restore-keys: |
      ${{ runner.os }}-spm-
```

## 3. Fastlane Integration

Fastlane simplifies complex tasks like code signing and App Store uploads.

```yaml
- name: Run Fastlane
  run: bundle exec fastlane beta
  env:
    MATCH_PASSWORD: ${{ secrets.MATCH_PASSWORD }}
    FASTLANE_APPLE_APPLICATION_SPECIFIC_PASSWORD: ${{ secrets.FASTLANE_APPLE_APPLICATION_SPECIFIC_PASSWORD }}
```

## 4. Conditional Jobs

Run specific jobs only when certain files change.

```yaml
jobs:
  deploy:
    if: github.ref == 'refs/heads/main'
    runs-on: macos-latest
    steps:
      - name: Deploy to TestFlight
        run: ./deploy_script.sh
```

## 5. Matrix Builds

Test your app across multiple iOS versions or devices.

```yaml
strategy:
  matrix:
    destination: ['platform=iOS Simulator,name=iPhone 15', 'platform=iOS Simulator,name=iPad Pro (12.9-inch)']
```

## 6. Self-Hosted Runners

For faster builds or specialized hardware, you can use your own Mac mini as a GitHub Actions runner. This avoids the cost and wait times of GitHub-hosted macOS runners.
