import SwiftUI

struct DynamicLoadingScreen: View {
    @Binding var showSplashScreen: Bool
    
    @State var scaleX: CGFloat = .zero
    @State var isDataLoading: Bool = false
    @StateObject var applicationHelperStateObject = ApplicationHelper()
    
    
    var body: some View {
        VStack {
            Image(ApplicationImages.dumbbellSVG)
                .resizable()
                .frame(width: 100, height: 75)
            
            if self.applicationHelperStateObject.isDataLoading {
                ProgressView()
                    .tint(.white)
                    .transition(.blurReplace.combined(with: .scale))
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(ApplicationLinearGradient.redGradient)
        .onChange(of: self.applicationHelperStateObject.isDataLoading) {
            if !self.applicationHelperStateObject.isDataLoading {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    withAnimation(.snappy(duration: 1.25).delay(1)) {
                        self.showSplashScreen = false
                    }
                }
            }
        }
        .onAppear {
            Task {
                try await self.applicationHelperStateObject.loadEveryImportantData()
            }
        }
    }
}

