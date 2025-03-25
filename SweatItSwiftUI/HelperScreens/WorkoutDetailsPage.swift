//
//  WorkoutDetailsPage.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 26/03/25.
//

import SwiftUI

struct WorkoutDetailsPage: View {
    
    var workout: Workout_t
    
    var body: some View {
        ScreenBuilder {
                
            AccentPageHeader(pageHeaderTitle: self.workout.workoutName)
            
            ScrollContentView {
                SectionHeader(text: "Workout Details")
                
                CustomList {
                    SpaceSeparatedKeyValue(key: "Name", value: self.workout.workoutName)
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                    
                    CustomDivider()
                    
                    SpaceSeparatedKeyValue(key: "Duration", value: ApplicationHelper.formatSeconds(seconds: Int(self.workout.timeTaken)) + " ⏰")
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                    
                    CustomDivider()
                    
                    
                    SpaceSeparatedKeyValue(key: "Calories Burned", value: String(format: "%.f 🔥", self.workout.caloriesBurned))
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                    
                    CustomDivider()
                    
                    
                    SpaceSeparatedKeyValue(key: "Difficulty", value: self.workout.workoutDifficulty.rawValue)
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                    
                    CustomDivider()
                    
                    
                    SpaceSeparatedKeyValue(key: "Category", value: self.workout.workoutCategory.rawValue)
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                    
                   
                }
                
                
                
                SectionHeader(text: "Exercises")
                    .padding(.top, 25)
                
                ForEach(self.workout.exercises, id: \.id) { exercise in
                    NavigationLink(destination: ExerciseDetailsScreen(exercise: exercise)) {
                        ExerciseViewCard(exercise: exercise)
                    }
                }
            }
            .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
        }
    }
}
