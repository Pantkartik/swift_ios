import SwiftUI

struct Animations_Basics: View {
    @State private var scale: CGFloat = 1.0
    @State private var angle: Double = 0.0
    @State private var opacity: Double = 1.0
    
    var body: some View {
        VStack(spacing: 50) {
            Text("SwiftUI Animations")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            // 1. Implicit Animation
            Circle()
                .fill(Color.blue)
                .frame(width: 100, height: 100)
                .scaleEffect(scale)
                .onTapGesture {
                    scale += 0.2
                }
                .animation(.spring(response: 0.5, dampingFraction: 0.6), value: scale)
            
            // 2. Explicit Animation
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.purple)
                .frame(width: 100, height: 100)
                .rotationEffect(.degrees(angle))
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 1.0)) {
                        angle += 360
                    }
                }
            
            // 3. Repeating Animation
            Button("Animate Opacity") {
                withAnimation(Animation.linear(duration: 1).repeatForever(autoreverses: true)) {
                    opacity = 0.3
                }
            }
            .opacity(opacity)
            
            Spacer()
        }
        .padding()
    }
}

// Note: This is a standalone View example for learning purposes.
