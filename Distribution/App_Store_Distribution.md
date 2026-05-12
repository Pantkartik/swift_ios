# App Store Distribution Preparation

Getting your app from Xcode to the App Store involves several steps and requirements.

## 1. Prerequisites

- **Apple Developer Program**: A paid membership ($99/year) is required to distribute apps.
- **App Store Connect**: The portal where you manage your apps, screenshots, and metadata.

## 2. Certificates & Profiles

- **Development Certificate**: Used to run the app on your physical devices.
- **Distribution Certificate**: Used to sign the app for the App Store.
- **App ID**: A unique identifier for your app (Bundle ID).
- **Provisioning Profile**: Links your app, certificate, and device.

## 3. Preparing for Submission

### App Icon & Metadata
- Provide icons in various sizes (1024x1024 for App Store).
- Write descriptions, keywords, and support URLs.
- Prepare screenshots for different device sizes.

### Privacy Policy
- Required for all apps on the App Store.

## 4. Distribution Flow

1. **Archive**: In Xcode, go to `Product > Archive` using a real device or `Generic iOS Device`.
2. **Validate**: Check for common issues before uploading.
3. **Distribute**: Upload to App Store Connect.
4. **TestFlight**: Distribute the build to internal or external testers.
5. **Submit for Review**: Send the build to Apple's review team.

## 5. TestFlight

- **Internal Testing**: Up to 100 members of your team (immediate access).
- **External Testing**: Up to 10,000 testers (requires initial Beta App Review).
- **Public Link**: Allow anyone to join the beta via a URL.

## Tips for Success

- Follow the **Human Interface Guidelines (HIG)**.
- Ensure your app doesn't crash on launch.
- Provide a test account for reviewers if your app requires login.
```
