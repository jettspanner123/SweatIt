//
//  FullScreenLoadingView.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 04/06/25.
//

import SwiftUI

struct FullScreenLoadingView: View {
    var body: some View {
        VStack {
            VStack {
                ProgressView()
                    .tint(.white)
                    .scaleEffect(1.5)
                    .offset(y: 8)
                
                
                Text("Analizing Food Data")
                    .font(.system(size: 15, weight: .medium, design: .rounded))
                    .foregroundStyle(.white)
                    .padding(10)
                    .offset(y: 8)
            }
            .padding()
            .overlay {
                defaultShape
                    .stroke(.white.opacity(0.18))
            }
            .background(AppBackgroundBlur(radius: 100, opaque: true))
            .background(.darkBG.opacity(0.54))
            .clipShape(defaultShape)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding * 2)
        .zIndex(ApplicationBounds.dialogBoxZIndex)
        .ignoresSafeArea()
    }
}

