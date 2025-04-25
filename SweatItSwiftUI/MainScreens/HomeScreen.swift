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
        return self.appStates.dailyActivities
    }
    
    @State var showAllActivitiesPage: Bool = true
    
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
    
    
    
    var body: some View {
        ScrollContentView {
            
            // MARK: Steps Taken card
            InformationCard(image: "Boot", title: "Steps", text: String(self.currentDayStepCount), secondaryText: "/ 12000", textColor: .white, wantInformationView: true, value: Double(self.currentDayStepCount)) {
                print("Hello world")
            }
            .background(defaultShape.fill(ApplicationLinearGradient.blueGradient).opacity(0.85))
            .contextMenu {
                
            }
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
                        Text("\(workout.workoutName): [\(String(format: "%.f kCal", workout.caloriesBurned))]")
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
                
                ForEach(self.AgendaToday.indices, id: \.self) { index in
                    CheckBoxWithText(text: self.AgendaToday[index].title, checked: self.$AgendaToday[index].isDone)
                        .padding(.horizontal, 15)
                        .padding(.vertical, 15)
                    
                    
                    if index != self.AgendaToday.count - 1 {
                        CustomDivider()
                    }
                }
                
                
                
            }
            .frame(maxWidth: .infinity)
            .background(.darkBG)
            .overlay {
                defaultShape
                    .stroke(.white.opacity(0.18))
            }
            .clipShape(defaultShape)
            .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
            
            
            // MARK: Create agenda button
            
            HStack {
                Text("Create Agenda")
                    .font(.system(size: 12, weight: .medium, design: .rounded))
                    .foregroundStyle(.white.opacity(0.95))
                    .frame(maxWidth: .infinity)
                
                
            }
            .frame(maxWidth: .infinity)
            .frame(height: 40)
            .background(ApplicationLinearGradient.redGradient.opacity(0.85), in: RoundedRectangle(cornerRadius: 8))
            .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
            .onTapGesture {
                withAnimation {
                    self.showAddAgendaPage = true
                }
            }
            
            
            
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
                ForEach(self.RescentActivities, id: \.id) { activity in
                    NavigationLink(destination: ActivityDetailsScreen(activity: activity)) {
                        ActivityViewCard(activity: activity)
                    }
                }
                
            }
            .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
            
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

