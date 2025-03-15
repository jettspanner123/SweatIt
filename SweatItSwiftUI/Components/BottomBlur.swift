import SwiftUI

struct BottomBlur: View {
    
    var body: some View {
        HStack {
            
        }
        .frame(maxWidth: .infinity)
        .frame(height: 120)
        .background(AppBackgroundBlur(radius: 10, opaque: false).blur(radius: 10))
        .zIndex(9998)
    }
}
