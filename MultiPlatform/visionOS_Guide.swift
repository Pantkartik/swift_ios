import SwiftUI
import RealityKit

// MARK: - visionOS App Entry Point
@main
struct VisionOSApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .windowStyle(.volumetric) // Unique to visionOS for 3D windows

        ImmersiveSpace(id: "SolarSystem") {
            SolarSystemView()
        }
    }
}

struct ContentView: View {
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
    
    var body: some View {
        VStack {
            Text("Welcome to visionOS")
                .font(.extraLargeTitle)
            
            Button("Launch Immersive Space") {
                Task {
                    await openImmersiveSpace(id: "SolarSystem")
                }
            }
        }
    }
}

struct SolarSystemView: View {
    var body: some View {
        // Placeholder for RealityKit 3D content
        Text("3D Solar System rendering here")
    }
}
