# App Clips Development

App Clips provide a small part of an app that’s discoverable at the moment it’s needed, loading within seconds to complete a specific task.

## Key Concepts

- **Size Limit:** The App Clip binary must be very small (e.g., under 10MB uncompressed) to ensure instant loading.
- **Discoverability:** App Clips are discovered via NFC tags, QR codes, Safari App Banners, Maps, and Messages.
- **Transient Nature:** They are not permanently installed on the home screen like a full app. If a user doesn't use an App Clip for 30 days, the system may remove it.

## Invocation

App Clips are launched via URLs. The URL contains the payload that the App Clip needs to understand its context.
- **App Clip Experiences:** You configure these in App Store Connect. They map a specific URL to your App Clip.
- **Handling Invocations:** In SwiftUI, you handle the invocation using `.onContinueUserActivity(NSUserActivityTypeBrowsingWeb) { userActivity in ... }`.

## Project Structure

- **App Clip Target:** An App Clip is a separate target within your Xcode project.
- **Shared Code:** You must share code between your main app target and your App Clip target to avoid duplication. This is typically done by adding files to both targets or extracting shared logic into a Swift Package or framework.

## Limitations

App Clips have several restrictions to protect user privacy:
- Cannot access HealthKit data.
- Cannot access Apple Music.
- Limited background processing capabilities.
- Restricted access to Location, Camera, and Microphone (requires ephemeral permission).
- Cannot access Contacts, Files, or Photos directly.

## Development Workflow

1.  **Add an App Clip Target:** In Xcode, go to File > New > Target and select App Clip.
2.  **Define the Experience:** Determine the core task you want users to complete (e.g., ordering coffee, paying for parking).
3.  **Share Assets and Code:** Carefully select which assets and code files belong to both the app and the App Clip to minimize the App Clip's size.
4.  **Handle Invocation:** Parse the URL payload when the App Clip is launched to deep-link the user directly to the relevant content.
5.  **Test Locally:** Configure an Environment Variable `_XCAppClipURL` in your Xcode scheme to simulate an invocation URL.
6.  **Offer Full App:** Use `SKOverlay` to encourage users to download the full app after completing their task.
