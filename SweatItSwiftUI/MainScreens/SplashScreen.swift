//
//  SplashScreen.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 11/03/25.
//

import SwiftUI

struct SplashScreen: View {
    var body: some View {
        HStack {
            Image("DSVG")
                .resizable()
                .frame(width: 80, height: 80)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .addAppLinearGradient()
        .zIndex(10000)
    }
}

#Preview {
    SplashScreen()
}
