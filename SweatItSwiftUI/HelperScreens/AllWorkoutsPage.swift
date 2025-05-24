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
    
    @Binding var userCustomWorkouts: Array<Workout_t>
    @StateObject var postMethodStore = PostMethodStore()
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
                        
                        SecondaryHeading(title: "Custom Workouts")
                            .padding(.top, 25)
                        
                        if self.userCustomWorkouts.isEmpty {
                            Image(systemName: "tray.fill")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .foregroundStyle(.white.opacity(0.25))
                                .padding(.top, 25)
                            
                            Text("No Custom Workout")
                                .font(.system(size: 15, weight: .regular, design: .rounded))
                                .foregroundStyle(.white.opacity(0.25))
                                .padding(.top, 5)
                        }
                        
                        ForEach(self.userCustomWorkouts, id: \.id) { workout in
                            NavigationLink(destination: ActiveWorkoutScreen(workout: workout)) {
                                WorkoutCard(image: workout.workoutImage, name: workout.workoutImage, difficulty: workout.workoutDifficulty, sideOffset: 50)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    
                }
                .scrollDismissesKeyboard(.immediately)
                .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
            }
            
        }
    }
}
