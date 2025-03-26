//
//  LeaderboardScreen.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 26/03/25.
//

import SwiftUI

struct LeaderboardScreen: View {
    var body: some View {
        ScreenBuilder {
            
            AccentPageHeader(pageHeaderTitle: "Leaderboard")
            
            ScrollContentView {
                Image(systemName: "tray.fill")
                    .resizable()
                    .frame(width: 100, height: 90)
                    .foregroundStyle(.white.opacity(0.25))
                    .padding(.top, 100)
                
                Text("Page will be available scoon!")
                    .font(.system(size: 15, weight: .medium, design: .rounded))
                    .foregroundStyle(.white.opacity(0.25))
            }
            .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
        }
    }
}

#Preview {
    LeaderboardScreen()
}
