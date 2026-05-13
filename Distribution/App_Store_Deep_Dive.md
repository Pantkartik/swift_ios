# App Store Submission: Deep Dive

This guide covers the critical details of submitting your app to the App Store beyond the basic upload process.

## 1. Screenshots & Media

Screenshots are your first impression on users.

- **Required Sizes**:
  - **6.5" iPhone**: (e.g., iPhone 15 Pro Max) - 1290 x 2796 pixels.
  - **5.5" iPhone**: (e.g., iPhone 8 Plus) - 1242 x 2208 pixels.
  - **12.9" iPad Pro**: (6th Gen) - 2048 x 2732 pixels.
- **App Preview**: A short video (up to 30s) demonstrating the app's functionality.
- **Tools**: Use `fastlane frameit` to add device frames and text to your screenshots automatically.

## 2. App Privacy (Nutrition Labels)

Apple requires detailed information about data collection.

- **Data Types**: Identify if you collect contact info, health data, location, etc.
- **Usage**: Specify if data is used for "Third-Party Advertising", "Developer's Advertising", "Analytics", or "Product Personalization".
- **Tracking**: You must ask for permission via `AppTrackingTransparency` if you track users across other apps/websites.

## 3. App Review Guidelines

To avoid rejections, ensure your app follows these key rules:

- **Safety**: No offensive or harmful content.
- **Performance**: No crashes, no broken links, and functional on all supported devices.
- **Business**: Clear subscription terms, proper use of In-App Purchases (IAP).
- **Design**: Follow the Human Interface Guidelines (HIG).

### Common Rejection Reasons
1. **Guideline 2.1 - Performance**: App crashes or has bugs.
2. **Guideline 4.0 - Design**: UI is too simple or looks like a website.
3. **Guideline 5.1.1 - Privacy**: Collecting data without a clear purpose or privacy policy.

## 4. Metadata Optimization

- **App Name**: Up to 30 characters.
- **Subtitle**: Summary of the app (30 characters).
- **Keywords**: comma-separated list of terms (100 characters total).
- **Description**: Detailed explanation of features and benefits.

## 5. Versioning and Build Numbers

- **Version Number (`CFBundleShortVersionString`)**: User-facing (e.g., 1.0.0).
- **Build Number (`CFBundleVersion`)**: Internal identifier (e.g., 10). Must increase for every upload of the same version.
