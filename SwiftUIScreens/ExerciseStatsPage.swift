//
//  ExerciseStatsPage.swift
//  SweatIt
//
//  Created by Uddeshya Singh on 20/01/25.
//

import SwiftUI

struct ExerciseStatsPage: View {
    var body: some View {
        ZStack {
            AccentPageHeader(pageHeaderTitle: "Exercise Stats", action: {})
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    ExerciseExpandableCard(exerciseName: "Bycycle Crunches", muscleGroups: ["Core", "Abs", "Oblique"], weekdays: [(true, 1),(true, 2),(true, 3),(true, 4),(true, 5),(true, 6)], colors: [Color("AppBlueLight"), Color("AppBlueDark")])
                    ExerciseExpandableCard(exerciseName: "Bycycle Crunches", muscleGroups: ["Core", "Abs", "Oblique"], weekdays: [(true, 1),(true, 2),(true, 3),(true, 4),(true, 5),(true, 6)], colors: [Color("AppLavaOne"), Color("AppLavaTwo")])
                    ExerciseExpandableCard(exerciseName: "Bycycle Crunches", muscleGroups: ["Core", "Abs", "Oblique"], weekdays: [(true, 1),(true, 2),(true, 3),(true, 4),(true, 5),(true, 6)], colors: [Color("AppLavaPurpleOne"), Color("AppLavaPurpleTwo")])
                    ExerciseExpandableCard(exerciseName: "Bycycle Crunches", muscleGroups: ["Core", "Abs", "Oblique"], weekdays: [(true, 1),(true, 2),(true, 3),(true, 4),(true, 5),(true, 6)], colors: [Color("AppGreenLight"), Color("AppGreenDark")])
                    ExerciseExpandableCard(exerciseName: "Bycycle Crunches", muscleGroups: ["Core", "Abs", "Oblique"], weekdays: [(true, 1),(true, 2),(true, 3),(true, 4),(true, 5),(true, 6)], colors: [Color("AppLavaOne"), Color("AppLavaPurpleTwo")])
                    ExerciseExpandableCard(exerciseName: "Bycycle Crunches", muscleGroups: ["Core", "Abs", "Oblique"], weekdays: [(true, 1),(true, 2),(true, 3),(true, 4),(true, 5),(true, 6)], colors: [Color("AppThanosLight"), Color("AppThanosDark")])
                }
                .padding(.top, 105)
                .padding(.bottom, 50)
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            LinearGradient(gradient: Gradient(colors: [Color("DarkBG"), .black]), startPoint: UnitPoint(x: 0.5, y: 0), endPoint: UnitPoint(x: 0.5, y: 1.6))
        )
    }
}

#Preview {
    ExerciseStatsPage()
}
