//
//  ActivityScreen.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 09/03/25.
//

import SwiftUI

struct ActivityScreen: View {
    
    @EnvironmentObject var appStates: ApplicationStates
    var currentDayStepCount: Int
    
    @State var weeklyData: Array<DailyEvents_t> = DailyEvents.current.weeklyEvents
    
    
    var caloriesBurnedByWalking: Double {
        return Double(self.currentDayStepCount) * Double(User.current.currentUser.currentWeight * 0.0005)
    }
    
    var burnedCalores: Double {
        let caloriesBurnedByExercise = self.appStates.dailyEvents.workoutsDone.reduce(0) { $0 + $1.caloriesBurned }
        let caloriesBurnedByWalking: Double = Double(self.currentDayStepCount) * Double(User.current.currentUser.currentWeight * 0.0005)
        return caloriesBurnedByWalking + caloriesBurnedByExercise
    }
    
    var consumedCalories: Double {
        var totalCaloriesConsumed: Double = .zero
        
        for meal in self.appStates.dailyEvents.mealsHad {
            for food in meal.foodItems {
                totalCaloriesConsumed += food.calories
            }
        }
        
        return totalCaloriesConsumed
    }
    
    
    var body: some View {
        ScreenBuilder {
            AccentPageHeader(pageHeaderTitle: "Activities")
                .transition(.offset(y: -140))
            
            ScrollContentView {
                
                
                
                
                
                // MARK: Calories Burned and water consumed
                HStack {
                    InformationCard(image: "FireLogo", title: "Burned", text: String(format: "%.f kCal", self.burnedCalores), secondaryText: "", textColor: .white, wantInformationView: true, content: {
                        
                    })
                    .background(defaultShape.fill(ApplicationLinearGradient.orangeGradient))
                    .contextMenu {
                        if self.appStates.dailyEvents.workoutsDone.isEmpty {
                            VStack {
                                Text("No workouts done yet! 🥺")
                                    .font(.custom(ApplicationFonts.oswaldRegular, size: 15))
                            }
                        }
                        
                        if self.caloriesBurnedByWalking != .zero {
                            Text(String(format: "%.1f kCal From Walking", self.caloriesBurnedByWalking))
                        }
                        
                        ForEach(self.appStates.dailyEvents.workoutsDone, id: \.id) { workout in
                            Text("\(workout.workoutName): [\(String(format: "%.f kCal", workout.caloriesBurned))]")
                        }
                    }
                    
                    
                    // MARK: Calories Burned card
                    InformationCard(image: "Water", title: "Water", text: "500 ml", secondaryText: "", textColor: .white, wantInformationView: true) {
                        
                    }
                    .background(defaultShape.fill(ApplicationLinearGradient.blueGradient))
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)

                
                
                
                
                
                
                // MARK: Workout done and calories consumed
                HStack {
                    InformationCard(image: "Dumbbell", title: "Workout", text: "> 1 Hr", secondaryText: "", textColor: .appBloodRedDark, wantInformationView: true) {
                        
                    }
                    .background(defaultShape.fill(ApplicationLinearGradient.whiteGradient))
                    
                    
                    // MARK: Calories Burned card
                    InformationCard(image: "FireLogo", title: "Consumed", text: "1900 kCal", secondaryText: "", textColor: .white, wantInformationView: true) {
                        
                    }
                    .background(defaultShape.fill(ApplicationLinearGradient.greenGradient))
                    .contextMenu {
                        if self.appStates.dailyEvents.workoutsDone.isEmpty {
                            VStack {
                                Text("No meals had yet! 🥺")
                                    .font(.custom(ApplicationFonts.oswaldRegular, size: 15))
                            }
                        }
                        
                        ForEach(self.appStates.dailyEvents.mealsHad, id: \.id) { meal in
                            Text("\(meal.mealName): [\(String(format: "%.f kCal", meal.totalCalories))]")
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)

                
                
                
                
                // MARK: Step counter
                
                VStack {
                    Text("Step Counter")
                        .font(.system(size: 20, weight: .regular, design: .rounded))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    ZStack {
                        Circle()
                            .trim(from: 0.15, to: 0.85)
                            .stroke(LinearGradient(colors: [Color.appGreenDark, Color.appGreenLight], startPoint: .trailing, endPoint: .leading), style: StrokeStyle(lineWidth: 30, lineCap: .round, lineJoin: .round))
                            .rotationEffect(.degrees(90))
                            .opacity(0.25)
                            .padding(25)
                            .zIndex(1)
                        
                        Circle()
                            .trim(from: 0.15, to: 0.7)
                            .stroke(LinearGradient(colors: [Color.appGreenDark, Color.appGreenLight], startPoint: .trailing, endPoint: .leading), style: StrokeStyle(lineWidth: 30, lineCap: .round, lineJoin: .round))
                            .rotationEffect(.degrees(90))
                            .padding(25)
                            .zIndex(1)
                        
                        Image("Walking")
                            .scaleEffect(0.75)
                        
                        Text("\(self.weeklyData.last!.stepsTaken)")
                            .font(.custom(ApplicationFonts.oswaldRegular, size: 28))
                            .foregroundStyle(ApplicationLinearGradient.greenGradient)
                            .offset(y: 75)
                        
                    }
                    
                    Text("Calories Burned")
                        .font(.system(size: 15, weight: .medium, design: .rounded))
                        .foregroundStyle(.white.opacity(0.5))
                        .takeMaxWidthLeading()
                        .padding(.top)
                    
                    let caloriesBurned: Double = ApplicationHelper.estimatedCaloriesBurned(steps: self.weeklyData.last!.stepsTaken, weightInKg: Double(75))
                    
                    Text(String(format: "%.f", caloriesBurned))
                        .font(.custom(ApplicationFonts.oswaldRegular, size: 25))
                        .foregroundStyle(ApplicationLinearGradient.redGradient)
                        .takeMaxWidthLeading()
                    
                    
                }
                .frame(maxWidth: .infinity)
                .frame(height: 300, alignment: .topLeading)
                .padding(20)
                .background(.darkBG.opacity(0.54))
                .overlay {
                    defaultShape
                        .stroke(.white.opacity(0.18))
                }
                .clipShape(defaultShape)
                .padding(.top, 10)
                .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
                
            }
        }
        
    }
}

