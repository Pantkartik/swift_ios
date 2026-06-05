# App Store Submission: Deep Dive

This guide covers the critical details of submitting your app to the App Store beyond the basic upload process.

---

## 1. Screenshots & Media

Screenshots are your first impression on users.

- **Required Sizes**:
  - **6.5" iPhone**: (e.g., iPhone 15/16 Pro Max) - 1290 x 2796 pixels.
  - **5.5" iPhone**: (e.g., iPhone 8 Plus) - 1242 x 2208 pixels.
  - **12.9" iPad Pro**: (6th Gen) - 2048 x 2732 pixels.
- **App Preview**: A short video (up to 30s) demonstrating the app's functionality. Must not contain device frames or hands touching the screen.
- **Automation Tools**: Use `fastlane frameit` to add device frames and descriptive text to screenshots automatically.

---

## 2. App Privacy (Nutrition Labels)

Apple requires developers to provide detailed information about the data collected by the app and third-party SDKs.

- **Data Types**: Identify if you collect contact info, health data, location, etc.
- **Usage**: Specify if data is used for "Third-Party Advertising", "Developer's Advertising", "Analytics", or "Product Personalization".
- **Tracking**: You must ask for permission via the `AppTrackingTransparency` (ATT) framework if you track users across other apps or websites.

> [!IMPORTANT]
> Apple now requires a **Privacy Manifest** (`PrivacyInfo.xcprivacy`) file for apps that access specific "Required Reason" APIs or bundle third-party SDKs. Failing to supply this will result in immediate rejection. See the detailed [Privacy Manifests Guide](file:///Users/pantkartik/Ios_dev/swift_ios/Distribution/Privacy_Manifests.md) for instructions.

---

## 3. App Review Guidelines

To avoid rejections, ensure your app follows these key rules:

- **Safety**: No offensive, harmful, or user-generated content without appropriate filtering.
- **Performance**: No crashes, no broken links, and fully functional on all supported devices.
- **Business**: Clear subscription terms, proper use of In-App Purchases (IAP), and adhering to Apple's payment rules.
- **Design**: Follow the Human Interface Guidelines (HIG).

### Common Rejection Reasons
1. **Guideline 2.1 - Performance (Crashes & Bugs)**: App crashes on launch or during review.
2. **Guideline 4.0 - Design (Minimum Functionality)**: UI is too simple, looks like a web wrapper, or doesn't provide enough utility.
3. **Guideline 5.1.1 - Privacy (Missing Declarations)**: Collecting data without a clear purpose, or failing to declare **Required Reason APIs** in the Privacy Manifest.
4. **Guideline 2.5.18 - Invaliding Code Signing**: Bundling third-party SDKs that are not digitally signed.

---

## 4. Metadata Optimization

- **App Name**: Up to 30 characters.
- **Subtitle**: Summary of the app (30 characters).
- **Keywords**: comma-separated list of terms (100 characters total). Do not repeat words from the app name or subtitle.
- **Description**: Detailed explanation of features and benefits. Explain what the app does clearly.

---

## 5. Versioning and Build Numbers

- **Version Number (`CFBundleShortVersionString`)**: User-facing (e.g., 1.0.0). Usually follows Semantic Versioning (`MAJOR.MINOR.PATCH`).
- **Build Number (`CFBundleVersion`)**: Internal identifier (e.g., 10). Must increase for every upload of the same version, and must be unique.
