import SwiftUI
import MapKit

// MARK: - Location Model
struct Landmark: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
    let category: String
    
    // Equatable conformance
    static func == (lhs: Landmark, rhs: Landmark) -> Bool {
        lhs.id == rhs.id
    }
}

// MARK: - MapKit Example View
struct MapKit_ExampleView: View {
    // Standard coordinates
    static let applePark = CLLocationCoordinate2D(latitude: 37.3348, longitude: -122.0090)
    static let sfGoldenGate = CLLocationCoordinate2D(latitude: 37.8199, longitude: -122.4783)
    
    // Core landmark list
    @State private var landmarks = [
        Landmark(name: "Apple Park", coordinate: MapKit_ExampleView.applePark, category: "Tech"),
        Landmark(name: "Golden Gate Bridge", coordinate: MapKit_ExampleView.sfGoldenGate, category: "Sightseeing")
    ]
    
    // Camera position state
    @State private var position: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: MapKit_ExampleView.applePark,
            span: MKCoordinateSpan(latitudeDelta: 0.15, longitudeDelta: 0.15)
        )
    )
    
    // Search states
    @State private var searchText = ""
    @State private var searchResults: [MKMapItem] = []
    
    // Routing states
    @State private var selectedLandmark: Landmark?
    @State private var route: MKRoute?
    @State private var isCalculatingRoute = false
    
    var body: some View {
        NavigationStack {
            VStack {
                // Search Input Field
                HStack {
                    TextField("Search nearby (e.g. Coffee, Hotel)", text: $searchText)
                        .textFieldStyle(.roundedBorder)
                        .autocorrectionDisabled()
                    
                    Button("Search") {
                        performSearch()
                    }
                    .buttonStyle(.borderedProminent)
                }
                .padding()
                
                // Map container using the iOS 17+ Map view
                Map(position: $position, selection: $selectedLandmark) {
                    
                    // 1. Static Markers
                    ForEach(landmarks) { landmark in
                        Marker(landmark.name, coordinate: landmark.coordinate)
                            .tint(landmark.category == "Tech" ? .blue : .orange)
                            .tag(landmark) // Makes the marker selectable
                    }
                    
                    // 2. Custom Annotations for Search Results
                    ForEach(searchResults, id: \.self) { item in
                        Annotation(
                            item.name ?? "Found Place",
                            coordinate: item.placemark.coordinate
                        ) {
                            Image(systemName: "mappin.circle.fill")
                                .font(.title)
                                .foregroundColor(.red)
                                .background(Color.white.clipShape(Circle()))
                        }
                    }
                    
                    // 3. Render Route Polyline if available
                    if let route {
                        MapPolyline(route)
                            .stroke(.blue, lineWidth: 5)
                    }
                }
                .mapControls {
                    // Standard system map overlay buttons
                    MapUserLocationButton()
                    MapCompass()
                    MapScaleView()
                }
                .frame(maxHeight: .infinity)
                
                // Bottom panel actions
                HStack(spacing: 20) {
                    Button(action: {
                        withAnimation {
                            position = .region(
                                MKCoordinateRegion(
                                    center: MapKit_ExampleView.applePark,
                                    span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                                )
                            )
                        }
                    }) {
                        Label("Apple Park", systemImage: "building.2")
                    }
                    .buttonStyle(.bordered)
                    
                    Button(action: {
                        withAnimation {
                            position = .region(
                                MKCoordinateRegion(
                                    center: MapKit_ExampleView.sfGoldenGate,
                                    span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
                                )
                            )
                        }
                    }) {
                        Label("Golden Gate", systemImage: "bridge")
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Draw Route") {
                        calculateRoute()
                    }
                    .disabled(isCalculatingRoute)
                    .buttonStyle(.borderedProminent)
                }
                .padding()
            }
            .navigationTitle("Maps Guide 🗺️")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    // MARK: - Local Search Implementation
    private func performSearch() {
        guard !searchText.isEmpty else { return }
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchText
        
        // Target the search around Apple Park
        request.region = MKCoordinateRegion(
            center: MapKit_ExampleView.applePark,
            span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        )
        
        let search = MKLocalSearch(request: request)
        Task {
            do {
                let response = try await search.start()
                await MainActor.run {
                    self.searchResults = response.mapItems
                    // Auto scale camera to fit items
                    self.position = .automatic
                }
            } catch {
                print("Search failed: \(error)")
            }
        }
    }
    
    // MARK: - Directions Routing Implementation
    private func calculateRoute() {
        isCalculatingRoute = true
        
        let request = MKDirections.Request()
        // Route from Apple Park to Golden Gate Bridge
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: MapKit_ExampleView.applePark))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: MapKit_ExampleView.sfGoldenGate))
        request.transportType = .automobile
        
        let directions = MKDirections(request: request)
        Task {
            do {
                let response = try await directions.calculate()
                if let firstRoute = response.routes.first {
                    await MainActor.run {
                        self.route = firstRoute
                        // Scale camera to fit the full line
                        self.position = .automatic
                        self.isCalculatingRoute = false
                    }
                }
            } catch {
                print("Routing failed: \(error)")
                await MainActor.run {
                    self.isCalculatingRoute = false
                }
            }
        }
    }
}

#Preview {
    MapKit_ExampleView()
}
