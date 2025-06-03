//
//  HomeScreen.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 09/03/25.
//

import SwiftUI
import TipKit

struct HomeScreen: View {
    @EnvironmentObject var appStates: ApplicationStates
    @EnvironmentObject var healthManager: HealthManager
    
    @Binding var showAddAgendaPage: Bool
    
    @Binding var AgendaToday: Array<Agenda_t> 
    var RescentActivities: Array<Activity_t> {
        print(self.appStates.dailyActivities)
        return self.appStates.dailyActivities
    }
    
    @State var showAllActivitiesPage: Bool = false
    
    @State var currentDayStepCount: Int = .zero
    
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
    
    
    
    
    @State var showCaloriesStatsScreen: Bool = false
    @State var showCaloriesGainedStatsScreen: Bool = false
    
    
    @StateObject var postMethodStoreStateObject = PostMethodStore()
    @State var cloudinaryImageUploader = CloudinaryImageDB()
    
    @StateObject var cloudinaryMethodStoreStateObject = CloudinaryImageMethodStore()
    
    
    
    var atleastOneWorkoutCompleted: Bool {
        return self.appStates.dailyEvents.workoutsDone.count > 0
    }
    var atleastBreakFastTaken: Bool {
        for meal in self.appStates.dailyEvents.mealsHad {
            for foodItem in meal.foodItems {
                let timeInHours = Calendar.current.dateComponents([.hour], from: foodItem.timeOfHaving).hour!
                print(timeInHours, "For food item", foodItem.foodName, "Is breakfst")
                if (0...12).contains(timeInHours) {
                    return true
                }
            }
        }
        return false
    }
    
    var atleastLunchTaken: Bool {
        for meal in self.appStates.dailyEvents.mealsHad {
            for foodItem in meal.foodItems {
                let timeInHours = Calendar.current.dateComponents([.hour], from: foodItem.timeOfHaving).hour!
                print(timeInHours, "For food item", foodItem.foodName, "Is lunch")
                if (12...18).contains(timeInHours) {
                    return true
                }
            }
        }
        return false
    }
    
    var atleastDinnerTaken: Bool {
        for meal in self.appStates.dailyEvents.mealsHad {
            for foodItem in meal.foodItems {
                let timeInHours = Calendar.current.dateComponents([.hour], from: foodItem.timeOfHaving).hour!
                print(timeInHours, "For food item", foodItem.foodName, "Is dinner")
                if (18...24).contains(timeInHours) {
                    return true
                }
            }
        }
        return false
    }
    
    var atleastStepsCompleted: Bool {
        return self.appStates.dailyEvents.stepsTaken >= 15000 ? true : false
    }
    var body: some View {
        ScrollContentView {
            
            // MARK: Steps Taken card
            InformationCard(image: "Boot", title: "Steps", text: String(self.currentDayStepCount), secondaryText: "/ \(self.appStates.dailyNeeds.dailySteps)", textColor: .white, wantInformationView: false, value: Double(self.currentDayStepCount)) {}
                .background(defaultShape.fill(ApplicationLinearGradient.blueGradient).opacity(0.85))
                .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
            
            
            // MARK: Calories burned and gained
            HStack {
                
                
                // MARK: Calories burned
                InformationCard(image: "FireLogo", title: "Burned", text: String(format: "%.f kCal", self.burnedCalores), secondaryText: "", textColor: .white, wantInformationView: true) {
                    self.showCaloriesStatsScreen = true
                }
                .background(defaultShape.fill(ApplicationLinearGradient.orangeGradient).opacity(0.85))
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
                        Text("\(workout.workoutName): (\(String(format: "%.f kCal", workout.caloriesBurned)))")
                    }
                }
               
                
                
                
                // MARK: Calories gained
                InformationCard(image: "Food", title: "Consumed", text: String(format: "%.f kCal", self.consumedCalories), secondaryText: "", textColor: .white, wantInformationView: true) {
                    self.showCaloriesGainedStatsScreen = true
                }
                .background(defaultShape.fill(ApplicationLinearGradient.greenGradient).opacity(0.85))
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
            
            
            // MARK: Agenda today section
            SecondaryHeading(title: "Agenda Today")
                .padding(.top, 25)
                .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
            
            // MARK: Agenda today card
            VStack(spacing: 0) {
                
                if self.AgendaToday.isEmpty {
                    VStack(spacing: 15) {
                        Image(systemName: "tray.fill")
                            .resizable()
                            .frame(width: 80, height: 70)
                            .foregroundStyle(.white.opacity(0.25))
                        
                        Text("No Agendas Found!")
                            .font(.system(size: 12, weight: .medium, design: .rounded))
                            .foregroundStyle(.white.opacity(0.25))
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 200)
                }
                
                
                CheckBoxWithText(text: "Complete A Workout Today", checked: self.atleastOneWorkoutCompleted)
                
                CustomDivider()
                
                CheckBoxWithText(text: "Have A Neutricious Breakfast", checked: self.atleastBreakFastTaken)
                CustomDivider()

                CheckBoxWithText(text: "Have A Filling Lunch", checked: self.atleastLunchTaken)
                CustomDivider()

                CheckBoxWithText(text: "Have A Delicious Dinner", checked: self.atleastDinnerTaken)

                    
                
                
                
            }
            .frame(maxWidth: .infinity)
            .background(.darkBG)
            .overlay {
                defaultShape
                    .stroke(.white.opacity(0.18))
            }
            .clipShape(defaultShape)
            .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
            
            
            
            
            
            SecondaryHeading(title: "Quick Links")
                .padding(.top, 25)
                .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
            
            
            
            // MARK: Quick link twin buttons
            HStack {
                
                
                
                // MARK: Scan food button
                PrimaryNavigationButton(text: "Scan Food")
                    .background(defaultShape.fill(ApplicationLinearGradient.redGradient))
                    .overlay {
                        HStack {
                            Image(systemName: "barcode.viewfinder")
                                .foregroundStyle(.white.opacity(0.5))
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 15)
                    }
                    .onTapWithScaleVibrate {
                        withAnimation {
                            self.appStates.showCameraScreen = true
                        }
                    }
                
                
                
                
                
                // MARK: Custom Workout button
                NavigationLink(destination: ChooseWorkoutScreen()) {
                    
                    PrimaryNavigationButton(text: "Custom")
                        .background(defaultShape.fill(ApplicationLinearGradient.thanosGradient))
                        .overlay {
                            HStack {
                                Image(ApplicationImages.tabBarDumbbell)
                                    .resizable()
                                    .frame(width: 30, height: 25)
                                    .opacity(0.5)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 10)
                        }
                        .contextMenu {
                            Text("Click Here to create cusotm workout options.")
                        }
                    
                }
                
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
            
            
            
            // MARK: Recent Activities
            //            SecondaryHeading(title: "Recent Activities")
            //                .padding(.top, 25)
            
            HeadingWithLink(titleHeading: "Recent Activities") {
                self.showAllActivitiesPage = true
            }
            .padding(.top, 25)
            .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
            
            
            // MARK: If the activity list is empty
            
            if self.RescentActivities.isEmpty {
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
            
            
            
            // MARK: If the the activity list is not empty
            VStack(spacing: 5) {
                ForEach(self.RescentActivities.prefix(3).indices, id: \.self) { index in
                    let activity = self.RescentActivities[index]
                    NavigationLink(destination: ActivityDetailsScreen(activity: activity)) {
                        ActivityViewCard(activity: activity)
                    }
                }
                
            }
            .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
            .onChange(of: self.currentDayStepCount) {
                self.appStates.dailyEvents.stepsTaken = self.currentDayStepCount
            }
            .onChange(of: self.consumedCalories) {
                self.appStates.dailyEvents.caloriesIngestedForTheDay = self.consumedCalories
            }
            .onChange(of: self.burnedCalores) {
                self.appStates.dailyEvents.caloriesBurnedForTheDay = self.burnedCalores
            }
            .onChange(of: self.burnedCalores) {
                Task {
                    try await ApplicationEndpoints.post.setCaloriesBurnedForTheDay(forUserId: User.current.currentUser.id, withCalories: self.burnedCalores)
                }
            }
            .onChange(of: self.appStates.dailyEvents.workoutsDone) {
                print("When the shit is encountered............brr.rrrrrrrr")
                Task {
                    var workoutTiming_t: Double = .zero
                    for workout in self.appStates.dailyEvents.workoutsDone {
                        workoutTiming_t += workout.timeTaken
                    }
                    
                    try await ApplicationEndpoints.post.setWorkoutTimingsForTheDay(forUserId: User.current.currentUser.id, workoutTiming: workoutTiming_t)
                }
            }
            
            
        }
        
        .onAppear {
            Task {
                self.currentDayStepCount = await self.healthManager.getStepsToday()
            }
        }
        .sensoryFeedback(.impact, trigger: self.showAddAgendaPage)
        .navigationDestination(isPresented: self.$showCaloriesGainedStatsScreen, destination: {
            CaloriesConsumedGraphPage()
        })
        .navigationDestination(isPresented: self.$showCaloriesStatsScreen, destination: {
            CaloriesBurnedGraphPage()
        })
        .navigationDestination(isPresented: self.$showAllActivitiesPage, destination: {
            ActivityScreen(currentDayStepCount: self.currentDayStepCount)
        })
    }
}


struct InformationCardTip: Tip {
    var title: Text {
        Text("Tap and hold the card to see extra details.")
    }
}

