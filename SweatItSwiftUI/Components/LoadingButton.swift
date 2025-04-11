//
//  LoadingButton.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 10/04/25.
//

import SwiftUI

struct LoadingButton: View {
    
    @Binding var isLoading: Bool
    var backgroundGradient: LinearGradient = ApplicationLinearGradient.redGradient
    var action: () -> Void = {}
    
    var body: some View {
        HStack {
            if self.isLoading {
                ProgressView()
                    .tint(.white)
                    .transition(.blurReplace)
            } else {
                Text("LogIn")
                    .font(.system(size: 15, weight: .medium, design: .rounded))
                    .foregroundStyle(.white)
                    .transition(.blurReplace)
            }
        }
        .frame(maxWidth: self.isLoading ? 45 : UIScreen.main.bounds.width)
        .frame(height: 45)
        .background(self.backgroundGradient)
        .clipShape(defaultShape)
        .onTapWithVibration {
            self.action()
        }
        
    }
}
