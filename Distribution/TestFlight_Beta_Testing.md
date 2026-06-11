# TestFlight & Beta Testing Guide ✈️

TestFlight is Apple's official platform for distributing pre-release builds of iOS, iPadOS, macOS, watchOS, tvOS, and visionOS apps to beta testers. It is crucial for gathering user feedback, identifying crashes, and validating features before the public App Store release.

---

## 1. Internal vs. External Testing

TestFlight offers two primary testing programs, serving different purposes:

| Feature | Internal Testing | External Testing |
|---|---|---|
| **Audience** | App Store Connect Team Members (Admin, Developer, App Manager roles). | Any user with an email address or access to a Public Link. |
| **Max Testers** | Up to 100 per App Store Connect account. | Up to 10,000 per app. |
| **Beta App Review**| **Not Required**. Builds are available to test immediately after processing. | **Required** for the first build of each new major/minor version. |
| **Build Access** | Immediate access to all active builds. | Only builds specifically sent to external groups after passing review. |
| **Invitation Method**| Assigned directly in App Store Connect. | Email invite or public link. |

---

## 2. Setting Up TestFlight: Step-by-Step

### Step 1: Upload a Build from Xcode
1. Set the build destination to **Any iOS Device (arm64)** or a connected physical device.
2. Go to `Product > Archive` in the menu.
3. Once the archive completes, click **Distribute App** in the Organizer.
4. Select **TestFlight & App Store** and click **Distribute**.
5. Follow the prompts to sign and upload your build to App Store Connect.

### Step 2: Configure Internal Testing
1. Log in to [App Store Connect](https://appstoreconnect.apple.com).
2. Select your app, then go to the **TestFlight** tab.
3. Under the **Users** section on the left, click **Internal Testing**.
4. Click the **+** icon to select existing App Store Connect users and invite them.
5. Testers will receive an email containing a redemption code to access the app.

### Step 3: Configure External Testing
1. In the **TestFlight** tab, click **External Groups** on the left.
2. Click the **+** icon, name your group (e.g., "Public Beta Testers"), and create it.
3. Inside the group:
   - Go to the **Builds** tab and click **+** to select a processed build.
   - Complete the **Beta Information** form (description of what to test, contact email, and reviewer credentials if required).
   - Click **Submit for Review**.
4. Once the build is approved by Beta App Review, you can add testers:
   - Go to the **Testers** tab in your group.
   - Add testers individually by email, OR **Enable Public Link** to generate a reusable invite URL.

---

## 3. Public Links vs. Email Invites

Using the right invitation method depends on how you want to scale your beta program:

### Email Invites (Targeted Beta)
- **Best for**: Closed groups of trusted users, VIPs, or enterprise stakeholders.
- **Controls**: Testers are invited explicitly. You can remove individual testers at any time.

### Public Links (Open Beta)
- **Best for**: Stress-testing servers, community-driven development, and marketing campaigns.
- **Controls**: 
  - You can set a limit on how many testers can join via the link (e.g., cap at 500).
  - You can disable the link at any time to stop new sign-ups.

---

## 4. Collecting Tester Feedback & Crash Logs

TestFlight makes it easy for users to report bugs and developers to triage them:

### How Testers Submit Feedback
- **Screenshots**: A tester can take a screenshot in-app, click the preview window, choose **Share**, and click **Share Beta Feedback**. They can write comments and draw annotations.
- **Crash Reports**: If the app crashes, the tester will receive a prompt to share crash data and write a description of what they were doing when the crash occurred.

### How Developers Retrieve Feedback
- **App Store Connect**:
  - Go to **TestFlight > Feedback > Crashes** or **Screenshots**.
  - Review attachments, tester device info (iOS version, device model, battery level, free disk space), and user descriptions.
- **Xcode Organizer**:
  - Open Xcode, go to `Window > Organizer`.
  - Select the **Crashes** or **Feedback** tab.
  - Review symbols and stack traces directly alongside your source code to resolve bugs.

---

## 5. Tips for Passing Beta App Review

Unlike App Store Review, Beta App Review is typically faster and less strict, but it can still lead to rejections. To avoid delays:

> [!WARNING]
> If your app requires a sign-in or login sequence, you **must** provide valid test account credentials in the "Beta Information" section. Failure to do so will result in an immediate rejection under Guideline 2.1 (Performance).

- Provide clear **Test Details** explaining what features external testers should focus on.
- Ensure the app doesn't crash on launch.
- If the app uses background modes (e.g., location, audio), explain why in the review notes.
