import SwiftUI

struct DynamicIslandAnimationView: View {
    @Namespace private var animationNamespace
    @State private var isExpanded = true

    var body: some View {
        VStack {
            if isExpanded {
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color.blue)
                    .frame(width: 300, height: 200)
                    .matchedGeometryEffect(id: "musicPlayer", in: animationNamespace)
                    .onTapGesture {
                        withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
                            isExpanded.toggle()
                        }
                    }
            } else {
                HStack {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.blue)
                        .frame(width: 100, height: 50)
                        .matchedGeometryEffect(id: "musicPlayer", in: animationNamespace)
                }
                .frame(maxWidth: .infinity, alignment: .top)
                .padding()
                .onTapGesture {
                    withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
                        isExpanded.toggle()
                    }
                }
            }
        }
        .padding(.top, 50)
    }
}

#Preview {
    DynamicIslandAnimationView()
}
