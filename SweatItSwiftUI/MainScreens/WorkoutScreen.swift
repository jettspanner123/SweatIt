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
    @State var exerciseOfTheDay: Array<Exercise_t> = DailyEvents.current.exerciseOfTheDay
    
    
    var body: some View {
        ScrollContentView {
            // MARK: Search box
            CustomTextField(searchText: self.$searchText, placeholder: "Search")
            
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
            .frame(maxWidth: .infinity)
            
            
            // MARK: Workouts
            SecondaryHeading(title: "Workouts")
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
            
        }
        .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
    }
}

struct DailyExerciseViewCard: View {
    
    var exercise: Exercise_t
    var body: some View {
        HStack {
            
            // MARK: Image view
            HStack {
                Image("pushups")
                    .scaleEffect(0.5)
            }
            .frame(maxHeight: .infinity)
            .frame(width: 100)
            .background(.darkBG)
            
            // MARK: Content view
            VStack(spacing: 5) {
                Text(self.exercise.exerciseName + " 🔥")
                    .font(.custom(ApplicationFonts.oswaldRegular, size: 15))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
               
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        
                        // MARK: Difficulty
                        Text(self.exercise.difficulty.rawValue)
                            .font(.system(size: 10, weight: .regular, design: .rounded))
                            .foregroundStyle(.white)
                            .padding(4)
                            .padding(.horizontal, 4)
                            .background(self.exercise.difficulty == .easy ? ApplicationLinearGradient.greenGradient : self.exercise.difficulty == .medium ? ApplicationLinearGradient.goldenGradient : ApplicationLinearGradient.redGradient)
                            .overlay {
                                Capsule()
                                    .stroke(.white.opacity(0.18))
                            }
                            .clipShape(Capsule())
                        
                        ForEach(self.exercise.targettedMuscles, id: \.self) { muscle in
                            Text(muscle.rawValue)
                                .font(.system(size: 10, weight: .regular, design: .rounded))
                                .foregroundStyle(.white)
                                .padding(4)
                                .padding(.horizontal, 4)
                                .background(ApplicationLinearGradient.redGradient)
                                .overlay {
                                    Capsule()
                                        .stroke(.white.opacity(0.18))
                                }
                                .clipShape(Capsule())
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding(.vertical)
            .overlay {
                
                // MARK: Navigation icon
                HStack {
                    Image(systemName: "chevron.right")
                        .scaleEffect(0.75)
                        .foregroundStyle(.white.opacity(0.5))
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
                .padding(25)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 80,  alignment: .leading)
        .background(.darkBG.opacity(0.54))
    }
}

struct CustomTextField: View {
    @Binding var searchText: String
    var placeholder: String
    
    var body: some View {
        TextField("", text: self.$searchText, prompt: Text(self.placeholder).foregroundStyle(.white.opacity(0.5)))
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 55)
            .padding(.horizontal)
            .background(.darkBG.opacity(0.54))
            .overlay {
                defaultShape
                    .stroke(.white.opacity(0.18))
            }
            .clipShape(defaultShape)
            .allowsHitTesting(true)
        
    }
}

#Preview {
    WorkoutScreen()
}
