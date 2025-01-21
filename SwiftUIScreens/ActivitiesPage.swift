//
//  ActivitiesPage.swift
//  SweatIt
//
//  Created by Uddeshya Singh on 19/01/25.
//

import SwiftUI

struct ActivitiesPage: View {
    var body: some View {
        ZStack {
            AccentPageHeader(pageHeaderTitle: "Activities", action: {})
            ScrollView(showsIndicators: false) {
                VStack(spacing: 12) {
                    HStack(spacing: 15) {
                        CaloriesBurned(caloriesBurned: 193)
                        Hydrated(waterAmount: 500)
                    }
                    
                    HStack(spacing: 12) {
                        WorkoutTiming(workoutTiming: 1)
                        CaloriesConsumed(caloriesConsumed: 1900, totalCalories: 2500)
                    }
                    .padding(.bottom, 5)
                    
                    StepTrackerView(steps: 8702, caloriesBurned: 870)
                    
                    HeadingWithLink(titleHeading: "Exercise Stats", extraHeading: "Most Popular Exercises this week", showExtraHeading: true)
                    
                    ExerciseExpandableCard(exerciseName: "Bycycle Crunches", muscleGroups: ["Arms", "Chest"], weekdays: [(true, 1), (false, 2), (true, 3), (true, 4), (false, 5), (true, 6)], colors: [Color("AppLavaOne"), Color("AppLavaTwo")])
                    ExerciseExpandableCard(exerciseName: "Decline Pushups", muscleGroups: ["Chest", "Triceps", "Shoulders" ], weekdays: [(true, 1), (true, 2), (false, 3), (true, 4), (true, 5), (true, 6)], colors: [Color("AppLavaPurpleOne"), Color("AppLavaPurpleTwo")])
                }
                .padding(.top, 100)
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
    ActivitiesPage()
}
