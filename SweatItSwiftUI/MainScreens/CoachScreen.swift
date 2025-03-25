//
//  CoachScreen.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 25/03/25.
//

import SwiftUI

struct CoachScreen: View {
    var body: some View {
        ScrollContentView {
            SecondaryHeading(title: "Fitness Metrics", secondaryText: "( avg per week )")
            
            ScrollView {
                HStack {
                    
                }
            }
        }
        .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
    }
}


struct CoachCaloriesBurned: View {
    var body: some View {
        
    }
}

#Preview {
    CoachScreen()
}
