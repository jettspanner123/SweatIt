//
//  WorkoutScreen.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 09/03/25.
//

import SwiftUI

struct WorkoutScreen: View {
    
    @State var searchText: String = ""
    
    @State var workouts: Array<Workout_t> = Workout.current.exampleWorkoutList
    var filteredWorkouts: Array<Workout_t> {
        Workout.current.exampleWorkoutList.filter { $0.workoutName.lowercased().starts(with: self.searchText.lowercased()) }
    }
    
    var filteredExercises: Array<Exercise_t> {
        Exercise.current.allExercises.filter { $0.exerciseName.lowercased().starts(with: self.searchText.lowercased()) }
    }
    
    @State var exerciseOfTheDay: Array<Exercise_t> = [Exercise.current.allExercises.randomElement()!, Exercise.current.allExercises.randomElement()!]
    @State var showAllWorkoutsPage: Bool = false
    
    
    var body: some View {
        ScrollContentView {
            // MARK: Search box
            CustomTextField(searchText: self.$searchText, placeholder: "Search")
            
            if self.searchText.isEmpty {
                // MARK: Double navigation button
                
                HStack {
                    
                    NavigationLink(destination: ChallengesScreen()) {
                        PrimaryNavigationButton(text: "Challenges")
                            .padding(.leading)
                            .background(defaultShape.fill(ApplicationLinearGradient.redGradient))
                            .overlay {
                                HStack {
                                    Image("xbox")
                                        .scaleEffect(0.75)
                                        .offset(y: 1)
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal, 15)
                            }
                    }
                    
                    NavigationLink(destination: ChooseWorkoutScreen()) {
                        PrimaryNavigationButton(text: "Today Split")
                            .padding(.leading)
                            .background(defaultShape.fill(ApplicationLinearGradient.thanosGradient))
                            .overlay {
                                HStack {
                                    Image("bucket")
                                        .scaleEffect(0.75)
                                        .offset(y: 1)
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal, 15)
                            }
                    }
                }
                .frame(maxWidth: .infinity)
                
                
                // MARK: Workouts
                
                HeadingWithLink(titleHeading: "Workouts") {
                    self.showAllWorkoutsPage = true
                }
                .padding(.top, 20)

                ForEach(self.workouts, id: \.id) { workout in
                    NavigationLink(destination: ActiveWorkoutScreen(workout: workout)) {
                        WorkoutCard(image: workout.workoutImage, name: workout.workoutName, difficulty: workout.workoutDifficulty, sideOffset: 50)
                    }
                }
                
                SecondaryHeading(title: "Exercise of the day")
                    .padding(.top, 20)
                
                
                VStack(spacing: 0) {
                    
                    
                    // MARK: First Exercise of the day
                    NavigationLink(destination: ExerciseDetailsScreen(exercise: self.exerciseOfTheDay.first!)) {
                        DailyExerciseViewCard(exercise: self.exerciseOfTheDay.first!)
                            .overlay {
                                UnevenRoundedRectangle(cornerRadii: .init(topLeading: 17, topTrailing: 17))
                                    .stroke(.white.opacity(0.18))
                            }
                            .clipShape(UnevenRoundedRectangle(cornerRadii: .init(topLeading: 17, topTrailing: 17)))
                    }
                    
                    NavigationLink(destination: ExerciseDetailsScreen(exercise: self.exerciseOfTheDay.last!)) {
                        DailyExerciseViewCard(exercise: self.exerciseOfTheDay.last!)
                            .overlay {
                                UnevenRoundedRectangle(cornerRadii: .init(bottomLeading: 17, bottomTrailing: 17))
                                    .stroke(.white.opacity(0.18))
                            }
                            .clipShape(UnevenRoundedRectangle(cornerRadii: .init(bottomLeading: 17, bottomTrailing: 17)))
                    }
                    
                }
            } else {
                
                
                
                SectionHeader(text: "Workouts")
                    .padding(.top, 15)
                
                
                
                if self.filteredWorkouts.count != 0 {
                    ForEach(self.filteredWorkouts, id: \.id) { workout in
                        NavigationLink(destination: ActiveWorkoutScreen(workout: workout)) {
                            WorkoutCard(image: workout.workoutImage, name: workout.workoutName, difficulty: workout.workoutDifficulty, sideOffset: 50)
                        }
                    }
                }
                
                if self.filteredExercises.count != 0 {
                    SectionHeader(text: "Exercises")
                        .padding(.top, 25)
                    
                    ForEach(self.filteredExercises, id: \.id) { exercise in
                        NavigationLink(destination: ExerciseDetailsScreen(exercise: exercise)) {
                            ExerciseViewCard(exercise: exercise)
                        }
                    }
                }
                
            }
            
        }
        .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
        .navigationDestination(isPresented: self.$showAllWorkoutsPage, destination: {
            AllWorkoutsPage()
        })
    }
}







