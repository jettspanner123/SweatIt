//
//  DynamicLoadingScreen.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 24/04/25.
//

import SwiftUI

struct DynamicLoadingScreen: View {
    var body: some View {
        ScreenBuilder {
            ZStack(alignment: .bottom) {
                
                HStack {
                    Text("Loading")
                        .font(.system(size: 15, weight: .regular, design: .rounded))
                        .foregroundStyle(.white)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                
//                VStack {
//                    
//                }
//                .frame(maxWidth: .infinity)
//                .frame(height: 100)
//                .background(ApplicationLinearGradient.redGradient)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        }
    }
}

#Preview {
    DynamicLoadingScreen()
}
