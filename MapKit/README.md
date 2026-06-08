# MapKit in SwiftUI 🗺️

In iOS 17, Apple introduced a completely rewritten, fully declarative MapKit API for SwiftUI. Developers no longer need to bridge `MKMapView` using `UIViewRepresentable` for common tasks; maps are now first-class SwiftUI views.

## Key Components

- **Map**: The main container view that renders the interactive map interface.
- **Marker**: A standard, styled pin placed at a specific coordinate. Useful for simple points of interest.
  ```swift
  Marker("San Francisco", coordinate: sfCoordinate)
  ```
- **Annotation**: A customizable view placed at a coordinate. Unlike Marker, you can supply any SwiftUI view as its visual representation (e.g. circles, images, or interactive elements).
  ```swift
  Annotation("Coffee Shop", coordinate: shopCoord) {
      Image(systemName: "cup.and.saucer.fill")
          .padding(4)
          .background(.brown)
          .clipShape(Circle())
  }
  ```
- **MapCameraPosition**: Defines the visible area of the map (the camera's viewpoint). It can be configured with:
  - `.automatic`: Scales automatically to fit all markers/annotations.
  - `.region(MKCoordinateRegion)`: Centers on a specific coordinate span.
  - `.userLocation()`: Focuses on the user's current GPS location.
  - `.item(MKMapItem)`: Centers on a specific point of interest.

## Interactivity & Overlay Components

Modern MapKit provides modular controls that can be added inside the map's layout:
- `MapUserLocationButton()`: Moves the camera back to the user's location.
- `MapCompass()`: Displays the orientation compass.
- `MapScaleView()`: Renders the active scale indicator.

## Routing and Searches

You can use standard MapKit frameworks alongside SwiftUI Map:
- **MKLocalSearch**: Asynchronously queries the Apple Maps database for points of interest (e.g. "Pizza near me").
- **MKDirections**: Calculates routes between coordinates. The resulting `MKRoute` can be overlaid on the map using a `MapPolyline`.

---

*See `MapKit_Example.swift` for a complete example of modern maps with searching, routing, and camera controls.*
