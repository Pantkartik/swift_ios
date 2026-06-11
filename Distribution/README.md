# Distribution & App Store 🚀

This section covers the essential steps for preparing, signing, testing, and submitting your iOS applications to the App Store.

## 📁 Documentation Guides

- 📘 [App Store Distribution Basics](file:///Users/pantkartik/Ios_dev/swift_ios/Distribution/App_Store_Distribution.md): Learn about Apple Developer Account requirements, signing certificates, provisioning profiles, archiving, and TestFlight.
- 📙 [App Store Submission: Deep Dive](file:///Users/pantkartik/Ios_dev/swift_ios/Distribution/App_Store_Deep_Dive.md): Explore screenshot sizes, app review guidelines, common rejection reasons, metadata optimization, and versioning strategies.
- 🛡️ [Privacy Manifests & Required Reason APIs](file:///Users/pantkartik/Ios_dev/swift_ios/Distribution/Privacy_Manifests.md): Learn how to implement `PrivacyInfo.xcprivacy` to satisfy Apple's strict privacy policy guidelines.
- 🔑 [Code Signing & Troubleshooting](file:///Users/pantkartik/Ios_dev/swift_ios/Distribution/Code_Signing_Troubleshooting.md): Understand keys, certificates, App IDs, and provisioning profiles, with diagnostic tips for Xcode errors.
- ✈️ [TestFlight & Beta Testing](file:///Users/pantkartik/Ios_dev/swift_ios/Distribution/TestFlight_Beta_Testing.md): Step-by-step setup for internal and external beta testing, managing public links, and gathering tester feedback.

---

## 📌 Distribution Methods Comparison

When sharing your app with testers and users, choose the method that matches your needs:

| Method | Audience Limit | Review Required? | Expiration | Best For |
|---|---|---|---|---|
| **Development** | Up to 100 registered devices | No | 1 year (profiles expire) | Local debugging & active development |
| **Ad-Hoc** | Up to 100 registered devices | No | 1 year (profiles expire) | Internal QA testing outside App Store Connect |
| **TestFlight (Internal)** | Up to 100 team members | No | 90 days per build | Rapid internal testing within the development team |
| **TestFlight (External)** | Up to 10,000 testers | Yes (Beta App Review) | 90 days per build | Large-scale public beta testing |
| **App Store (Production)** | Unlimited | Yes (App Review) | Never | Public customer release |

---

## 🛠️ App Store Release Checklist

Before submitting your app to Apple for final approval, ensure you have ticked all items below:

- [ ] **App Icon**: 1024x1024px PNG with no transparency.
- [ ] **Screenshots**: High-resolution screenshots for 6.5" iPhones, 5.5" iPhones, and 12.9" iPads.
- [ ] **Privacy Policy URL**: A hosted website link stating your data handling policies.
- [ ] **Privacy Manifest**: A `PrivacyInfo.xcprivacy` file containing required disclosures.
- [ ] **Reviewer Demo Credentials**: A test account username and password if your app requires login.
- [ ] **Contact Info**: Technical and marketing contact details.

> [!TIP]
> To automate these repetitive distribution tasks, check out the [DevOps Section](file:///Users/pantkartik/Ios_dev/swift_ios/DevOps/README.md) to set up Fastlane and CI/CD pipelines.
