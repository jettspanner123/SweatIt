//
//  ActiveWorkoutScreen.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 10/03/25.
//

import SwiftUI

struct ActiveWorkoutScreen: View {
    
    @State var animator: Bool = false
    
    var workout: Workout_t
    
    var body: some View {
        ScreenBuilder {
            AccentPageHeader(pageHeaderTitle: self.workout.workoutName)
            
            ScrollContentView {
               
                SecondaryHeading(title: "Workout Description")
                
                Text(self.workout.workoutDescription)
                    .font(.system(size: 12, weight: .regular, design: .rounded))
                    .foregroundStyle(.white.opacity(0.5))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 10)
                
                
                SecondaryHeading(title: "Workout Details")
                    .padding(.top, 25)
                
                
                // MARK: Workout statistics
                HStack {
                    
                    // MARK: Calores burned
                    HStack(spacing: 5) {
                       
                        VStack(spacing: -10) {
                            
                            Text(String(format: "%d", 200))
                                .font(.custom(ApplicationFonts.oswaldRegular, size: 30))
                                .foregroundStyle(.white)
                            
                            
                            Text("kCal")
                                .font(.custom(ApplicationFonts.oswaldRegular, size: 15))
                                .foregroundStyle(.white.opacity(0.54))
                        }
                        
                        Text("🔥")
                            .font(.system(size: 50))
                       
                        
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                    
                    // MARK: Time taken
                    HStack {
                        VStack(spacing: -10) {
                            
                            let workoutTimeTaken = ApplicationHelper.formatSeconds(seconds: Int(self.workout.timeTaken))
                            Text(workoutTimeTaken.split(separator: " ").first!)
                                .font(.custom(ApplicationFonts.oswaldRegular, size: 30))
                                .foregroundStyle(.white)
                            
                            
                            Text(workoutTimeTaken.split(separator: " ").last!)
                                .font(.custom(ApplicationFonts.oswaldRegular, size: 15))
                                .foregroundStyle(.white.opacity(0.54))
                        }
                        
                        Text("🕘")
                            .font(.system(size: 50))
                        
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .overlay {
                        Text("~")
                            .font(.custom(ApplicationFonts.oswaldRegular, size: 30))
                            .foregroundStyle(.white)
                            .offset(x: -55, y: -5)
                    }
                    
                }
                .frame(maxWidth: .infinity)
                .frame(height: 100)
                .padding(.horizontal, 25)
                .background(
                    ApplicationLinearGradient.redGradient
                )
                .overlay {
                    defaultShape
                        .stroke(.white.opacity(0.18))
                }
                .clipShape(defaultShape)
                
                
                // MARK: list of exercises
                   
                HStack {
                    SecondaryHeading(title: "Exercises")
                        .padding(.top, 25)
                    
                   
                    Text(String(self.workout.exercises.count))
                        .font(.custom(ApplicationFonts.oswaldRegular, size: 20))
                        .foregroundStyle(.white)
                        .padding(10)
                        .background(
                            Circle()
                                .fill(ApplicationLinearGradient.redGradient)
                        )
                        .padding(.top, 25)
                        .offset(y: 1)
                }
                .padding(.trailing, 5)
                
                ForEach(self.workout.exercises, id: \.id) { exercise in
                    NavigationLink(destination: ExerciseDetailsScreen(exercise: exercise)) {
                        ExerciseViewCard(exercise: exercise)
                    }
                    
                }
            }
            .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 2).repeatForever(autoreverses: true)) {
                self.animator.toggle()
            }
        }
    }
}


struct ExerciseViewCard: View {
    
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
            .background(.white)
            
            // MARK: Content view
            VStack {
                Text(self.exercise.exerciseName)
                    .font(.system(size: 13, weight: .regular, design: .rounded))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                
                Spacer()
                // MARK: Targetted muscles
                HStack {
                    ForEach(self.exercise.targettedMuscles, id: \.self) { muscle in
                        Text(muscle.rawValue)
                            .font(.system(size: 10, weight: .regular, design: .rounded))
                            .foregroundStyle(.white.opacity(0.5))
                            .padding(4)
                            .padding(.horizontal, 4)
                            .background(.darkBG.opacity(0.54))
                            .overlay {
                                Capsule()
                                    .stroke(.white.opacity(0.18))
                            }
                            .clipShape(Capsule())
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding()
            .overlay {
                
                // MARK: Navigation icon
                HStack {
                    Image(systemName: "chevron.right")
                        .scaleEffect(0.75)
                        .foregroundStyle(.white.opacity(0.5))
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.horizontal, 25)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 90,  alignment: .leading)
        .background(.darkBG.opacity(0.54))
        .overlay {
            defaultShape
                .stroke(.white.opacity(0.18))
        }
        .clipShape(defaultShape)
    }
}

