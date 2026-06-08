import WidgetKit
import SwiftUI

// MARK: - 1. Timeline Entry
/// The model that defines the data structure for each rendering state of the widget.
struct CryptoPriceEntry: TimelineEntry {
    let date: Date
    let coinName: String
    let symbol: String
    let priceUSD: Double
    let change24h: Double // Percentage change, e.g. +3.45 or -1.20
    let history: [Double] // Historical prices for charting (medium/large size)
}

// MARK: - 2. Timeline Provider
/// The provider generates timelines of entries instructing WidgetKit when to render updates.
struct CryptoTimelineProvider: TimelineProvider {
    typealias Entry = CryptoPriceEntry

    // Placeholder view shown before data is loaded or when previewing
    func placeholder(in context: Context) -> CryptoPriceEntry {
        CryptoPriceEntry(
            date: Date(),
            coinName: "Bitcoin",
            symbol: "BTC",
            priceUSD: 65000.0,
            change24h: 2.5,
            history: [64000, 64200, 64800, 65000]
        )
    }

    // A fast snapshot representation (e.g. when choosing widgets in the widget gallery)
    func getSnapshot(in context: Context, completion: @escaping (CryptoPriceEntry) -> Void) {
        let entry = CryptoPriceEntry(
            date: Date(),
            coinName: "Bitcoin",
            symbol: "BTC",
            priceUSD: 65000.0,
            change24h: 2.5,
            history: [64000, 64200, 64800, 65000]
        )
        completion(entry)
    }

    // Creates the actual timeline entries containing the current and future states.
    func getTimeline(in context: Context, completion: @escaping (Timeline<CryptoPriceEntry>) -> Void) {
        var entries: [CryptoPriceEntry] = []
        let currentDate = Date()
        
        // In a real-world scenario, you would perform an asynchronous network request here.
        // Because getTimeline runs in the background, we can fetch remote APIs.
        
        // Let's generate a simulated timeline covering the next 1 hour in 15-minute intervals.
        let basePrices = [65000.0, 65250.0, 64900.0, 65100.0, 65400.0]
        let baseChanges = [2.5, 2.9, 2.3, 2.7, 3.1]
        
        for index in 0..<5 {
            let entryDate = Calendar.current.date(byAdding: .minute, value: index * 15, to: currentDate) ?? currentDate
            let price = basePrices[index]
            let change = baseChanges[index]
            
            let entry = CryptoPriceEntry(
                date: entryDate,
                coinName: "Bitcoin",
                symbol: "BTC",
                priceUSD: price,
                change24h: change,
                history: Array(basePrices.prefix(index + 1))
            )
            entries.append(entry)
        }
        
        // Request a timeline refresh after the last entry's date is reached.
        let refreshDate = Calendar.current.date(byAdding: .hour, value: 1, to: currentDate) ?? currentDate
        let timeline = Timeline(entries: entries, policy: .after(refreshDate))
        completion(timeline)
    }
}

// MARK: - 3. Widget Entry View
/// SwiftUI View responsible for laying out the widget based on the active WidgetFamily.
struct CryptoWidgetEntryView: View {
    var entry: CryptoTimelineProvider.Entry
    
    // Environment property to detect the current widget size/family
    @Environment(\.widgetFamily) var family

    var body: some View {
        switch family {
        case .systemSmall:
            SmallWidgetView(entry: entry)
        case .systemMedium:
            MediumWidgetView(entry: entry)
        case .accessoryCircular:
            CircularAccessoryView(entry: entry)
        default:
            // Fallback for larger or unsupported styles
            MediumWidgetView(entry: entry)
        }
    }
}

// MARK: - Subviews for Widget Families

struct SmallWidgetView: View {
    let entry: CryptoPriceEntry
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(entry.symbol)
                    .font(.headline)
                    .bold()
                Spacer()
                Text("📈")
            }
            
            Spacer()
            
            Text(entry.priceUSD, format: .currency(code: "USD"))
                .font(.title3)
                .minimumScaleFactor(0.75)
                .bold()
            
            HStack(spacing: 4) {
                Image(systemName: entry.change24h >= 0 ? "arrow.up.right" : "arrow.down.right")
                Text("\(entry.change24h >= 0 ? "+" : "")\(entry.change24h, specifier: "%.2f")%")
            }
            .font(.caption)
            .bold()
            .foregroundColor(entry.change24h >= 0 ? .green : .red)
        }
        .padding()
        .containerBackground(.background, for: .widget)
    }
}

struct MediumWidgetView: View {
    let entry: CryptoPriceEntry
    
    var body: some View {
        HStack(spacing: 16) {
            VStack(alignment: .leading, spacing: 6) {
                Text(entry.coinName)
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Text(entry.symbol)
                    .font(.title2)
                    .bold()
                
                Text(entry.priceUSD, format: .currency(code: "USD"))
                    .font(.title3)
                    .bold()
                
                HStack(spacing: 4) {
                    Image(systemName: entry.change24h >= 0 ? "arrow.up.right" : "arrow.down.right")
                    Text("\(entry.change24h >= 0 ? "+" : "")\(entry.change24h, specifier: "%.2f")%")
                }
                .font(.caption2)
                .bold()
                .foregroundColor(entry.change24h >= 0 ? .green : .red)
            }
            
            Spacer()
            
            // Render a basic line path representing historical performance
            GeometryReader { geo in
                let points = entry.history
                if points.count > 1 {
                    Path { path in
                        let width = geo.size.width
                        let height = geo.size.height
                        let minVal = points.min() ?? 0
                        let maxVal = points.max() ?? 1
                        let delta = maxVal - minVal == 0 ? 1 : maxVal - minVal
                        
                        let stepX = width / CGFloat(points.count - 1)
                        
                        for i in 0..<points.count {
                            let x = CGFloat(i) * stepX
                            let normalizedY = CGFloat((points[i] - minVal) / delta)
                            let y = height - (normalizedY * height * 0.8) - (height * 0.1)
                            
                            if i == 0 {
                                path.move(to: CGPoint(x: x, y: y))
                            } else {
                                path.addLine(to: CGPoint(x: x, y: y))
                            }
                        }
                    }
                    .stroke(entry.change24h >= 0 ? Color.green : Color.red, lineWidth: 3)
                }
            }
            .frame(width: 120, height: 60)
        }
        .padding()
        .containerBackground(.background, for: .widget)
    }
}

struct CircularAccessoryView: View {
    let entry: CryptoPriceEntry
    
    var body: some View {
        VStack(spacing: 0) {
            Text(entry.symbol)
                .font(.system(size: 10, weight: .bold))
            Text(entry.priceUSD, format: .number.notation(.compactName))
                .font(.system(size: 12, weight: .semibold))
        }
        .containerBackground(.background, for: .widget)
    }
}

// MARK: - 4. Main Widget Declaration
// Note: This would ordinarily carry the @main attribute if it were the entry point
// of a Widget Extension target.
struct CryptoWidget: Widget {
    let kind: String = "CryptoWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: CryptoTimelineProvider()) { entry in
            CryptoWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Crypto Tracker")
        .description("Track your favorite cryptocurrencies in real-time.")
        .supportedFamilies([.systemSmall, .systemMedium, .accessoryCircular])
    }
}

// MARK: - Preview Provider
#Preview(as: .systemSmall) {
    CryptoWidget()
} loop: {
    CryptoPriceEntry(
        date: Date(),
        coinName: "Bitcoin",
        symbol: "BTC",
        priceUSD: 65000.0,
        change24h: 2.5,
        history: [64000, 64200, 64800, 65000]
    )
}
