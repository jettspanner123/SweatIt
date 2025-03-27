//
//  ChooseWorkoutScreen.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 26/03/25.
//

import SwiftUI

struct ChooseWorkoutScreen: View {
    
    
    //    @State var currentSelectedMuscles: Array<Extras.Muscle> = [.bicep]
    @State var currentSelectedMuscles: Dictionary<Extras.Muscle, Int> = [
        .bicep: 1,
    ]
    
    var totalExercises: Int {
        var count: Int = 0
        for (_, value) in self.currentSelectedMuscles {
            count += value
        }
        return count
    }
    
    var estimatedTime: String {
        var time: Double = .zero
        
        for (_, value) in self.currentSelectedMuscles {
            time += Double(value) * Double(Int.random(in: 4...8))
        }
        
        return String(format: "%.f", time) + " m"
        
    }
    
    @State var isSubmitButtonClicked: Bool = false
    @State var showActiveWorkoutScreen: Bool = false
    
    func generateWorkout() -> Workout_t {
        var musclesCovered: String = ""
        
        for (key, _) in self.currentSelectedMuscles {
            musclesCovered += " \(key)"
        }
        
        let allExercises: Array<Exercise_t> = Exercise.current.allExercises
        
        var exercises: Array<Exercise_t> = []
        
        for (key, value) in self.currentSelectedMuscles {
            for index in 1...value {
                    
            }
        }
        
        return .init(workoutName: "Your Workout", workoutDescription: "You custom workout coverring \(musclesCovered)", workoutCategory: .strength, workoutImage: "upperbody", exercises: [])
    }
    
    
    var body: some View {
        ScreenBuilder {
            AccentPageHeader(pageHeaderTitle: "Custom Workout")
            
            
            
            
            // MARK: Background blur
            BottomBlur()
                .offset(y: UIScreen.main.bounds.height - (55 * 2.1))
                .transition(.offset(y: 400))
            
            
            
            
            // MARK: Bottom button
            VStack {
                if self.isSubmitButtonClicked {
                    ProgressView()
                        .tint(.white)
                        .transition(.blurReplace)
                } else {
                    Text("Start Workout")
                        .foregroundStyle(.white)
                        .font(.system(size: 13 , weight: .medium, design: .rounded))
                        .transition(.blurReplace)
                }
               
            }
            .frame(width: BOTTOM_BUTTON_WIDTH, height: BOTTOM_BUTTON_HEIGHT)
            .background(ApplicationLinearGradient.redGradient)
            .clipShape(defaultShape)
            .offset(y: BOTTOM_BUTTON_OFFSET)
            .zIndex(9999)
            .ignoresSafeArea()
            .onTapGesture {
                withAnimation {
                    self.isSubmitButtonClicked = true
                    
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        self.showActiveWorkoutScreen = true
                        self.isSubmitButtonClicked = false
                    }
                }
                
                
                
            }
            
            
            ScrollContentView {
                Text("Choose what muscles you want to hit with the workout, and also choose how many exercises do you want in the workout.")
                    .font(.system(size: 12, weight: .regular, design: .rounded))
                    .foregroundStyle(.white.opacity(0.5))
                    .takeMaxWidthLeading()
                
                
                
                // MARK: Totla exercises and time taken
                HStack {
                    VStack {
                        
                        Text(String(self.totalExercises) + "💪")
                            .font(.system(size: 35, weight: .bold, design: .rounded))
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .contentTransition(.numericText(value: Double(self.totalExercises)))
                            .animation(.snappy, value: self.totalExercises)
                        
                        
                        Text("Exercises")
                            .font(.system(size: 12, weight: .regular, design: .rounded))
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                        
                    }
                    .applicationDropDownButton(height: 85)
                    
                    VStack {
                        
                        Text(self.estimatedTime)
                            .font(.system(size: 35, weight: .bold, design: .rounded))
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .contentTransition(.numericText(value: Double(self.totalExercises)))
                            .animation(.snappy, value: self.totalExercises)
                        
                        
                        Text("Estimated Time")
                            .font(.system(size: 12, weight: .regular, design: .rounded))
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                    }
                    .applicationDropDownButton(height: 85)
                    
                }
                .frame(maxWidth: .infinity)
                
                
                SectionHeader(text: "Choose Muscles")
                    .padding(.top, 25)
                
                ForEach(Extras.Muscle.allCases, id: \.self) { muscle in
                    Text(muscle.rawValue)
                        .font(.system(size: 15, weight: .regular, design: .rounded))
                        .foregroundStyle(self.currentSelectedMuscles.keys.contains(muscle) ? .white : .white.opacity(0.5))
                        .frame(maxWidth: .infinity)
                        .frame(height: 40)
                        .overlay {
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(.white.opacity(0.08))
                        }
                        .background(self.currentSelectedMuscles.keys.contains(muscle) ? ApplicationLinearGradient.blueGradientInverted : ApplicationLinearGradient.darkBGSameGradientWithOpacityHalf, in: RoundedRectangle(cornerRadius: 8))
                        .onTapGesture {
                            withAnimation {
                                if self.currentSelectedMuscles.keys.contains(muscle) {
                                    self.currentSelectedMuscles.removeValue(forKey: muscle)
                                } else {
                                    self.currentSelectedMuscles[muscle] = 1
                                }
                            }
                            //
                        }
                }
                
                SectionHeader(text: "Choose Exercise Count")
                    .padding(.top, 25)
                
                ForEach(Extras.Muscle.allCases, id: \.self) { muscle in
                    if self.currentSelectedMuscles.keys.contains(muscle) {
                        Stepper("\(muscle.rawValue) [\(self.currentSelectedMuscles[muscle]!)]", value: Binding(
                            get: { self.currentSelectedMuscles[muscle]! },
                            set: { newValue in
                                self.currentSelectedMuscles[muscle] = newValue
                            }
                        ))
                        .tint(.white)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .overlay {
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(.white.opacity(0.18))
                        }
                        .background(.darkBG.opacity(0.54), in: RoundedRectangle(cornerRadius: 8))
                    }
                    
                }
                
                
                
            }
            .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
        }
        .navigationDestination(isPresented: self.$showActiveWorkoutScreen, destination: {
            
            ActiveWorkoutScreen(workout: self.generateWorkout())
        })
    }
}

#Preview {
    ChooseWorkoutScreen()
}
