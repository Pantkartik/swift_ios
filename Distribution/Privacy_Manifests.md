# Privacy Manifests & Required Reason APIs 🛡️

Since Spring 2024, Apple requires all iOS apps and third-party SDKs submitted to the App Store to include a **Privacy Manifest** (`PrivacyInfo.xcprivacy`) if they collect data or use specific APIs classified as "Required Reason" APIs. 

This document outlines how to create and configure a Privacy Manifest for your application.

---

## 1. What is a Privacy Manifest?

A Privacy Manifest is a property list (`.plist`) file named `PrivacyInfo.xcprivacy` added to your app target or SDK. It declares:
1. **Whether the app tracks users** (according to App Tracking Transparency guidelines).
2. **The domains used for tracking** (which are blocked by iOS if the user denies tracking permission).
3. **The categories of data collected** and how they are used.
4. **The "Required Reason" APIs used** by your code or dependencies, and the valid reasons for using them.

---

## 2. Required Reason APIs

To prevent fingerprinting (identifying a device based on its hardware/software configuration), Apple restricts the use of certain APIs. If your app or third-party SDK uses any of these, you must declare them in the `NSPrivacyAccessedAPITypes` array.

| API Category | Covered APIs / Symbols | Declared Key | Common Valid Reasons |
|---|---|---|---|
| **File Timestamp** | `getattrlist`, `stat`, `fstat`, `NSURLContentModificationDateKey` | `NSPrivacyAccessedAPICategoryFileTimestamp` | - Displaying file metadata to the user.<br>- Accessing files within the app's container. |
| **System Boot Time** | `sysctl`, `sysctlbyname` (e.g. `kern.boottime`) | `NSPrivacyAccessedAPICategorySystemBootTime` | - Measuring elapsed time between events.<br>- Performance profiling inside the app. |
| **Disk Space** | `statfs`, `NSVolumeFreeSpaceKey`, `volumeInformationRegularFileAllocatedFileSizeKey` | `NSPrivacyAccessedAPICategoryDiskSpace` | - Checking space before downloading files.<br>- Deleting temporary files when disk is low. |
| **Active Keyboard** | `activeInputModes` | `NSPrivacyAccessedAPICategoryActiveInputModes` | - Customizing input options based on keyboard language. |
| **User Defaults** | `UserDefaults`, `NSUserDefaults` | `NSPrivacyAccessedAPICategoryUserDefaults` | - Storing app settings and preferences.<br>- Accessing user defaults within the same App Group. |

> [!WARNING]
> Using a Required Reason API without declaring it in `PrivacyInfo.xcprivacy`, or declaring it with an invalid reason code, will result in an automated warning email from App Store Connect, followed by an immediate App Store review rejection in future submissions.

---

## 3. Privacy Manifest XML Template

Below is a complete template of a `PrivacyInfo.xcprivacy` file containing declarations for tracking, data collection (Device ID), and common Required Reason APIs (User Defaults and Disk Space).

Create this file in Xcode via `File > New > File...` and choose the **App Privacy File** template (which creates `PrivacyInfo.xcprivacy`).

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <!-- 1. Tracking declaration (Boolean) -->
    <key>NSPrivacyTracking</key>
    <false/>
    
    <!-- 2. Tracking domains blocked when tracking is disabled -->
    <key>NSPrivacyTrackingDomains</key>
    <array>
        <!-- <string>tracking.example.com</string> -->
    </array>
    
    <!-- 3. Collected data types (Nutrition labels) -->
    <key>NSPrivacyCollectedDataTypes</key>
    <array>
        <dict>
            <key>NSPrivacyCollectedDataType</key>
            <string>NSPrivacyCollectedDataTypeDeviceID</string>
            <key>NSPrivacyCollectedDataTypeLinked</key>
            <true/>
            <key>NSPrivacyCollectedDataTypeTracking</key>
            <false/>
            <key>NSPrivacyCollectedDataTypePurposes</key>
            <array>
                <string>NSPrivacyCollectedDataTypePurposeAppFunctionality</string>
            </array>
        </dict>
    </array>
    
    <!-- 4. Required Reason APIs and their specific reason codes -->
    <key>NSPrivacyAccessedAPITypes</key>
    <array>
        <!-- Example: Declaring User Defaults usage -->
        <dict>
            <key>NSPrivacyAccessedAPIType</key>
            <string>NSPrivacyAccessedAPICategoryUserDefaults</string>
            <key>NSPrivacyAccessedAPIReasons</key>
            <array>
                <!-- CA92.1: Access info to store/read preferences inside the app -->
                <string>CA92.1</string>
            </array>
        </dict>
        
        <!-- Example: Declaring Disk Space usage -->
        <dict>
            <key>NSPrivacyAccessedAPIType</key>
            <string>NSPrivacyAccessedAPICategoryDiskSpace</string>
            <key>NSPrivacyAccessedAPIReasons</key>
            <array>
                <!-- 85F4.1: Access disk space to check size before file writes -->
                <string>85F4.1</string>
            </array>
        </dict>
    </array>
</dict>
</plist>
```

---

## 4. Third-Party SDK Requirements

Apple publishes a list of **commonly used third-party SDKs** that must include their own `PrivacyInfo.xcprivacy` file and must be digitally signed when packaged as binary dependencies. 

If you bundle any of these SDKs (e.g., Firebase, Alamofire, Lottie, SDWebImage, Facebook SDK) in your app:
1. Ensure you are using the latest version of the SDK containing the Privacy Manifest.
2. If the SDK is a binary `.xcframework`, ensure it is signed by the vendor to avoid signature validation failures during App Store upload.
