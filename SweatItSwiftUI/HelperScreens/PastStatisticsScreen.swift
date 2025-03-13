//
//  PastStatisticsScreen.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 14/03/25.
//

import SwiftUI

struct PastStatisticsScreen: View {
    var body: some View {
        ScreenBuilder {
            
            AccentPageHeader(pageHeaderTitle: "Past Statistics")
                
            ScrollContentView {
                
            }
            .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
        }
    }
}

#Preview {
    PastStatisticsScreen()
}
