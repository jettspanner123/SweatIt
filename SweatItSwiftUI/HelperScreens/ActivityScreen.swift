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
    
    
    var workoutTiming: Double {
        return Double(self.appStates.dailyEvents.workoutsDone.reduce(0) { $0 + $1.timeTaken })
    }
    
    
    var body: some View {
        ScreenBuilder {
            AccentPageHeader(pageHeaderTitle: "Activities")
                .transition(.offset(y: -140))
            
            ScrollContentView {
                
                
                
                
                
                // MARK: Calories Burned and water consumed
                HStack {
                    InformationCard(image: "FireLogo", title: "Burned", text: String(format: "%.f kCal", self.burnedCalores), secondaryText: "", textColor: .white, wantInformationView: false, content: {
                        
                    })
                    .background(defaultShape.fill(ApplicationLinearGradient.orangeGradient))
                    
                    
                    // MARK: Calories Burned card
                    InformationCard(image: "Water", title: "Water", text: String(format: "%.f ml", self.appStates.dailyEvents.waterIntakeForTheDay), secondaryText: "", textColor: .white, wantInformationView: false) {
                        
                    }
                    .background(defaultShape.fill(ApplicationLinearGradient.blueGradient))
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)

                
                
                
                
                
                
                // MARK: Workout done and calories consumed
                HStack {
                    InformationCard(image: "Dumbbell", title: "Workout", text: ApplicationHelper.formatSeconds(seconds: Int(self.workoutTiming)), secondaryText: "", textColor: .appBloodRedDark, wantInformationView: false) {
                        
                    }
                    .background(defaultShape.fill(ApplicationLinearGradient.whiteGradient))
                    
                    
                    // MARK: Calories Burned card
                    InformationCard(image: "FireLogo", title: "Consumed", text: String(format: "%.f kCal", self.consumedCalories), secondaryText: "", textColor: .white, wantInformationView: false) {
                        
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
                
                CustomProgressBar(goalValue: Double(self.appStates.dailyNeeds.dailySteps), currentValue: Double(self.currentDayStepCount), siUnit: "Steps", loadingBarBackground: ApplicationLinearGradient.blueGradientInverted, background: .appBlueDark.opacity(0.54))
                    .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
                
               

                
                
                SecondaryHeading(title: "All Activities")
                    .padding(.top, 25)
                    .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
                
                
                // MARK: If the activity list ie empty
                if self.appStates.dailyActivities.isEmpty {
                    VStack {
                        VStack {
                            Image(systemName: "figure.run")
                                .resizable()
                                .frame(width: 50, height: 70)
                                .foregroundStyle(.white.opacity(0.25))
                            
                            Text("No Activities Performed Yet!")
                                .font(.system(size: 15, weight: .regular, design: .rounded))
                                .foregroundStyle(.white.opacity(0.25))
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding(.vertical, 30)
                    }
                    .applicationDropDownButton()
                    .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
                }
                
                
                
                
                
                // MARK: If the activity list is not empty
                VStack(spacing: 5) {
                    ForEach(self.appStates.dailyActivities, id: \.id) { activity in
                        NavigationLink(destination: ActivityDetailsScreen(activity: activity)) {
                            ActivityViewCard(activity: activity)
                        }
                    }
                    
                }
                .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
            }
        }
        
    }
}

