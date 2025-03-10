//
//  ExerciseStatisticsScreen.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 09/03/25.
//

import SwiftUI

struct ExerciseStatisticsScreen: View {
    var body: some View {
        ScreenBuilder {
            AccentPageHeader(pageHeaderTitle: "Exercises")
            
            ScrollContentView {
                ExerciseExpandableCard(exerciseText: "Pushups")
                    .background(defaultShape.fill(ApplicationLinearGradient.lavaGradient))
                ExerciseExpandableCard(exerciseText: "Squats")
                    .background(defaultShape.fill(ApplicationLinearGradient.blueGradient))
                ExerciseExpandableCard(exerciseText: "Pushups")
                    .background(defaultShape.fill(ApplicationLinearGradient.greenGradient))
                ExerciseExpandableCard(exerciseText: "Pushups")
                    .background(defaultShape.fill(ApplicationLinearGradient.orangeGradient))
            }
            .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
        }
    }
}

#Preview {
    ExerciseStatisticsScreen()
}
