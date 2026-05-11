import SwiftUI

struct Animations_Advanced: View {
    @State private var isFlipped = false
    @State private var isExpanded = false
    @Namespace private var animationNamespace
    
    var body: some View {
        VStack(spacing: 60) {
            
            // 1. 3D Flip Animation
            VStack {
                Text("3D Card Flip")
                    .font(.headline)
                
                ZStack {
                    // Back
                    RoundedRectangle(cornerRadius: 20)
                        .fill(LinearGradient(colors: [.blue, .purple], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .frame(width: 200, height: 300)
                        .overlay(Text("Back").foregroundColor(.white).font(.title))
                        .rotation3DEffect(.degrees(isFlipped ? 0 : -180), axis: (x: 0, y: 1, z: 0))
                        .opacity(isFlipped ? 1 : 0)
                    
                    // Front
                    RoundedRectangle(cornerRadius: 20)
                        .fill(LinearGradient(colors: [.orange, .red], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .frame(width: 200, height: 300)
                        .overlay(Text("Front").foregroundColor(.white).font(.title))
                        .rotation3DEffect(.degrees(isFlipped ? 180 : 0), axis: (x: 0, y: 1, z: 0))
                        .opacity(isFlipped ? 0 : 1)
                }
                .onTapGesture {
                    withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                        isFlipped.toggle()
                    }
                }
            }
            
            // 2. Matched Geometry Effect
            VStack {
                Text("Matched Geometry Effect")
                    .font(.headline)
                
                if !isExpanded {
                    HStack {
                        Circle()
                            .fill(Color.green)
                            .matchedGeometryEffect(id: "shape", in: animationNamespace)
                            .frame(width: 50, height: 50)
                        
                        Text("Small View")
                            .matchedGeometryEffect(id: "text", in: animationNamespace)
                        
                        Spacer()
                    }
                    .padding()
                    .background(Capsule().fill(Color.gray.opacity(0.2)))
                } else {
                    VStack {
                        Text("Expanded View Detail")
                            .font(.title)
                            .matchedGeometryEffect(id: "text", in: animationNamespace)
                        
                        Rectangle()
                            .fill(Color.green)
                            .matchedGeometryEffect(id: "shape", in: animationNamespace)
                            .frame(width: 300, height: 200)
                            .cornerRadius(20)
                        
                        Text("Click to collapse")
                            .font(.caption)
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 25).fill(Color.gray.opacity(0.1)))
                }
            }
            .onTapGesture {
                withAnimation(.spring(response: 0.7, dampingFraction: 0.7)) {
                    isExpanded.toggle()
                }
            }
            
            Spacer()
        }
        .padding()
    }
}
