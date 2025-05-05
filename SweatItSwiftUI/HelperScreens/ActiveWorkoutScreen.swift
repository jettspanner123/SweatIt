//
//  ActiveWorkoutScreen.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 10/03/25.
//

import SwiftUI


let BOTTOM_BUTTON_WIDTH: CGFloat = UIScreen.main.bounds.width - 30
let BOTTOM_BUTTON_HEIGHT: CGFloat = 45
let BOTTOM_BUTTON_OFFSET: CGFloat = UIScreen.main.bounds.height - (55 * 1.5)

let TRANSITION_SCREEN_WIDTH: CGFloat = UIScreen.main.bounds.width
let TRANSITION_SCREEN_HEIGHT: CGFloat = UIScreen.main.bounds.height
let TRANSITION_SCREEN_OFFSET: CGFloat = 0

struct ActiveWorkoutScreen: View {
    
    @EnvironmentObject var appState: ApplicationStates
    
    @State var animator: Bool = false
    
    @State var showTransitionScreen: Bool = false
    
    
    @Namespace var animatedNamespace
    
    var workout: Workout_t
    var isDirected: Bool = false
    
    var body: some View {
        ScreenBuilder {
            if self.appState.workoutStatus == .started {
                WorkoutEngine(workout: self.workout)
                    .zIndex(.infinity)
                    .transition(.offset(y: UIScreen.main.bounds.height))
            }
            
            //            if self.appState.workoutStatus == .started {
            //                WorkoutEngine(workout: self.workout)
            //                    .zIndex(.infinity)
            //            } else {
            
            AccentPageHeader_WithFavButton(pageHeaderTitle: self.workout.workoutName, workout: self.workout)
                .blur(radius: self.showTransitionScreen ? 10 : 0)
            
            
            if self.appState.workoutStatus == .ended {
                RatingsScreen()
                    .transition(.offset(y: UIScreen.main.bounds.height))
                    .zIndex(.infinity)
            }
            
            
            // MARK: Bottom workout start button
            VStack {
                if !self.showTransitionScreen {
                    Text("Start Workout")
                        .foregroundStyle(.white)
                        .font(.system(size: 13 , weight: .medium, design: .rounded))
                        .transition(.offset(y: 500))
                    
                } else {
                    CountDownTimer()
                }
                
            }
            .frame(width: self.showTransitionScreen ? TRANSITION_SCREEN_WIDTH : BOTTOM_BUTTON_WIDTH, height: self.showTransitionScreen ? TRANSITION_SCREEN_HEIGHT : BOTTOM_BUTTON_HEIGHT)
            .background(ApplicationLinearGradient.redGradient)
            .clipShape(defaultShape)
            .offset(y: self.showTransitionScreen ? TRANSITION_SCREEN_OFFSET : BOTTOM_BUTTON_OFFSET)
            .zIndex(9999)
            .onTapGesture {
                withAnimation(.smooth(duration: 0.4)) {
                    self.showTransitionScreen.toggle()
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 8) {
                    withAnimation {
                        self.showTransitionScreen = false
                    }
                }
            }
            .ignoresSafeArea()
            
            if !self.showTransitionScreen {
                BottomBlur()
                    .offset(y: UIScreen.main.bounds.height - (55 * 2.1))
                    .transition(.offset(y: 400))
            }
            
            
            
            
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
                            
                            Text(String(format: "%.f", self.workout.caloriesBurned))
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
            .blur(radius: self.showTransitionScreen ? 10 : 0)
            //            }
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 2).repeatForever(autoreverses: true)) {
                self.animator.toggle()
            }
        }
    }
}
