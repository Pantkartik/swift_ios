import SwiftUI

// Mock AI Manager for SwiftUI Integration
class SentimentAnalyzer: ObservableObject {
    @Published var sentiment: String = "Unknown"
    @Published var isAnalyzing: Bool = false
    
    func analyze(text: String) {
        isAnalyzing = true
        // Simulate network or model latency
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.isAnalyzing = false
            if text.contains("happy") || text.contains("love") {
                self.sentiment = "😊 Positive"
            } else if text.contains("sad") || text.contains("angry") {
                self.sentiment = "😢 Negative"
            } else {
                self.sentiment = "😐 Neutral"
            }
        }
    }
}

struct AIView: View {
    @StateObject private var analyzer = SentimentAnalyzer()
    @State private var inputText: String = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Text("AI Sentiment Analysis")
                .font(.largeTitle)
                .bold()
            
            TextField("Enter text here...", text: $inputText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button(action: {
                analyzer.analyze(text: inputText)
            }) {
                HStack {
                    if analyzer.isAnalyzing {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    }
                    Text(analyzer.isAnalyzing ? "Analyzing..." : "Analyze Sentiment")
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .disabled(inputText.isEmpty || analyzer.isAnalyzing)
            
            VStack {
                Text("Result:")
                    .font(.headline)
                Text(analyzer.sentiment)
                    .font(.title)
                    .foregroundColor(sentimentColor)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(12)
            
            Spacer()
        }
        .padding()
    }
    
    private var sentimentColor: Color {
        if analyzer.sentiment.contains("Positive") { return .green }
        if analyzer.sentiment.contains("Negative") { return .red }
        return .gray
    }
}

// Preview
struct AIView_Previews: PreviewProvider {
    static var previews: some View {
        AIView()
    }
}
