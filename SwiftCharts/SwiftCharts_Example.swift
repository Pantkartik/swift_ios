import SwiftUI
import Charts

// MARK: - Data Models
struct MonthlyRevenue: Identifiable, Hashable {
    let id = UUID()
    let month: String
    let amount: Double
    let category: String // "Software" or "Hardware"
}

// MARK: - Example View
struct SwiftCharts_ExampleView: View {
    
    // Sample static dataset
    @State private var revenueData: [MonthlyRevenue] = [
        MonthlyRevenue(month: "Jan", amount: 4500, category: "Software"),
        MonthlyRevenue(month: "Jan", amount: 2100, category: "Hardware"),
        MonthlyRevenue(month: "Feb", amount: 5200, category: "Software"),
        MonthlyRevenue(month: "Feb", amount: 1800, category: "Hardware"),
        MonthlyRevenue(month: "Mar", amount: 6100, category: "Software"),
        MonthlyRevenue(month: "Mar", amount: 2900, category: "Hardware"),
        MonthlyRevenue(month: "Apr", amount: 5800, category: "Software"),
        MonthlyRevenue(month: "Apr", amount: 3100, category: "Hardware"),
        MonthlyRevenue(month: "May", amount: 7200, category: "Software"),
        MonthlyRevenue(month: "May", amount: 4000, category: "Hardware"),
        MonthlyRevenue(month: "Jun", amount: 8900, category: "Software"),
        MonthlyRevenue(month: "Jun", amount: 4500, category: "Hardware")
    ]
    
    // Chart type selection state
    @State private var chartType: ChartType = .bar
    
    // Interactive drag/tap selection states (iOS 17+)
    @State private var rawSelectedMonth: String? = nil
    
    enum ChartType: String, CaseIterable, Identifiable {
        case bar = "Bar Chart"
        case line = "Line Chart"
        var id: String { self.rawValue }
    }
    
    // Compute monthly totals for selection lookup
    private var totalRevenueByMonth: [String: Double] {
        var totals: [String: Double] = [:]
        for entry in revenueData {
            totals[entry.month, default: 0.0] += entry.amount
        }
        return totals
    }
    
    // Compute general monthly average
    private var overallAverage: Double {
        let total = revenueData.reduce(0.0) { $0 + $1.amount }
        return total / Double(Set(revenueData.map { $0.month }).count)
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    
                    // Chart Type Picker Selector
                    Picker("Chart Type", selection: $chartType) {
                        ForEach(ChartType.allCases) { type in
                            Text(type.rawValue).tag(type)
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding(.horizontal)
                    
                    // Active Selected Indicator (Tooltip readout)
                    if let rawSelectedMonth, let amount = totalRevenueByMonth[rawSelectedMonth] {
                        VStack(spacing: 4) {
                            Text("Total Revenue in \(rawSelectedMonth)")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Text(amount, format: .currency(code: "USD"))
                                .font(.title2)
                                .bold()
                        }
                        .padding()
                        .background(Color.secondary.opacity(0.1))
                        .cornerRadius(12)
                    } else {
                        VStack(spacing: 4) {
                            Text("Tap & Drag on Chart")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Text("Select data point")
                                .font(.title2)
                                .bold()
                                .opacity(0.5)
                        }
                        .padding()
                    }
                    
                    // Main Chart Container
                    Chart {
                        // 1. Data Rendering (Bar / Line marks)
                        ForEach(revenueData) { data in
                            if chartType == .bar {
                                BarMark(
                                    x: .value("Month", data.month),
                                    y: .value("Revenue", data.amount)
                                )
                                .foregroundStyle(by: .value("Type", data.category))
                                .cornerRadius(4)
                            } else {
                                LineMark(
                                    x: .value("Month", data.month),
                                    y: .value("Revenue", data.amount)
                                )
                                .interpolationMethod(.catmullRom) // Smooth curves
                                .foregroundStyle(by: .value("Type", data.category))
                                .lineStyle(StrokeStyle(lineWidth: 3.0))
                                
                                PointMark(
                                    x: .value("Month", data.month),
                                    y: .value("Revenue", data.amount)
                                )
                                .foregroundStyle(by: .value("Type", data.category))
                            }
                        }
                        
                        // 2. Average Target Overlay Indicator
                        RuleMark(
                            y: .value("Average", overallAverage)
                        )
                        .lineStyle(StrokeStyle(lineWidth: 1.5, dash: [5, 5]))
                        .foregroundStyle(.gray)
                        .annotation(position: .top, alignment: .trailing) {
                            Text("Avg: \(overallAverage, format: .currency(code: "USD").precision(.fractionLength(0)))")
                                .font(.caption2)
                                .foregroundColor(.gray)
                                .bold()
                        }
                        
                        // 3. Render Tooltip Rule on Drag Selection
                        if let rawSelectedMonth {
                            RuleMark(
                                x: .value("Selected Month", rawSelectedMonth)
                            )
                            .foregroundStyle(Color.secondary.opacity(0.3))
                            .zIndex(-1)
                        }
                    }
                    .frame(height: 300)
                    .padding()
                    
                    // Hook iOS 17+ Chart interaction listener
                    .chartXSelection(value: $rawSelectedMonth)
                    
                    // Configure Color Palettes
                    .chartForegroundStyleScale([
                        "Software": Color.blue.gradient,
                        "Hardware": Color.teal.gradient
                    ])
                    
                    // Chart Axes styling configurations
                    .chartYAxis {
                        AxisMarks(position: .leading, values: .automatic) { value in
                            AxisGridLine(stroke: StrokeStyle(lineWidth: 0.5))
                            AxisTick()
                            AxisValueLabel(format: Decimal.FormatStyle.Currency.currency(code: "USD").presentation(.narrow))
                        }
                    }
                    
                    // Static legend below the chart
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Analysis Notes:")
                            .font(.headline)
                        Text("• Software sales remain the primary driver, growing rapidly heading into Q2.")
                            .font(.callout)
                            .foregroundColor(.secondary)
                        Text("• Hardware sales remained stable, showing seasonal jumps in March and June.")
                            .font(.callout)
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                }
            }
            .navigationTitle("Sales Analytics 📊")
        }
    }
}

#Preview {
    SwiftCharts_ExampleView()
}
