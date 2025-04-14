//
//  AllWorkoutsPage.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 14/04/25.
//

import SwiftUI

struct AllWorkoutsPage: View {
    
    @State var searchText: String = ""
    
    let workouts: Array<Workout_t> = Workout.current.exampleWorkoutList
    var body: some View {
        NavigationStack {
            ScreenBuilder {
                
                AccentPageHeader(pageHeaderTitle: "All Workouts")
                
                ScrollContentView {
                    CustomTextField(searchText: self.$searchText, placeholder: "Search")
                    
                    VStack {
                        SecondaryHeading(title: "All Workouts")
                            .padding(.top, 25)
                        
                        ForEach(self.workouts, id: \.id) { workout in
                            NavigationLink(destination: ActiveWorkoutScreen(workout: workout)) {
                                WorkoutCard(image: workout.workoutImage, name: workout.workoutName, difficulty: workout.workoutDifficulty, sideOffset: 50)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    
                }
                .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
            }
        }
    }
}

#Preview {
    AllWorkoutsPage()
}
