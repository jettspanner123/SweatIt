//
//  DietScreen.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 11/03/25.
//

import SwiftUI


struct DietScreen: View {
    
    @EnvironmentObject var appStates: ApplicationStates
    
    var foodItemList: Array<Food_t> {
        var allFoods: Array<Food_t> = []
        for meal in self.appStates.dailyEvents.mealsHad {
            for food in meal.foodItems {
                allFoods.append(food)
            }
        }
        return allFoods
            
    }
    
    var caloriesConsumed: Double {
        var totalCaloriesConsumed: Double = .zero
        for meal in self.appStates.dailyEvents.mealsHad {
            for food in meal.foodItems {
                totalCaloriesConsumed += food.calories
            }
        }
        return totalCaloriesConsumed
    }
    
    var caloriesBurned: Double {
        return self.appStates.dailyEvents.workoutsDone.reduce(0) { $0 + $1.caloriesBurned }
    }
    
    
    
    var body: some View {
        ScrollContentView {
            
            
            
            HStack {
                
                // MARK: Scan food button
                PrimaryNavigationButton(text: "Scan Food")
                    .background(ApplicationLinearGradient.redGradient, in: defaultShape)
                    .overlay(alignment: .leading) {
                        Image(systemName: "barcode.viewfinder")
                            .foregroundStyle(.white)
                            .padding(.horizontal)
                    }
                    .onTapWithScaleVibrate(scaleBy: 0.85) {
                        withAnimation {
                            self.appStates.showCameraScreen = true
                        }
                    }
                
                
                
                
                
                // MARK: Search Food button
                PrimaryNavigationButton(text: "Find Food")
                    .background(ApplicationLinearGradient.thanosGradient, in: defaultShape)
                    .overlay(alignment: .leading) {
                        Image(systemName: "magnifyingglass")
                            .foregroundStyle(.white)
                            .padding(.horizontal)
                    }
                    .onTapWithScaleVibrate(scaleBy: 0.85) {
                        
                    }
            }
            .frame(maxWidth: .infinity)
            
            
            // MARK: Nutiritions
            SecondaryHeading(title: "Nutrition", secondaryText: "( per gram of body weight )")
                .padding(.top, 20)
            
            HStack {
                
                InformationCard(image: "FireLogo", title: "Burned", text: String(format: "%.f kCal", self.caloriesBurned), secondaryText: "", textColor: .white, wantInformationView: true) {
                    
                }
                .background(defaultShape.fill(ApplicationLinearGradient.orangeGradient).opacity(0.85))
                
                InformationCard(image: "Food", title: "Consumed", text: String(format: "%.f kCal", self.caloriesConsumed), secondaryText: "", textColor: .white, wantInformationView: true) {
                    
                }
                .background(defaultShape.fill(ApplicationLinearGradient.greenGradient).opacity(0.85))
            }
            .frame(maxWidth: .infinity)
            
            
            // MARK: Protein, Carbs and Fats here.
            MacrosViewCard()
            
            
            
            SecondaryHeading(title: "Calories Intake", secondaryText: "( As per \(ApplicationHelper.formatDateToHumanReadable(date: .now)) )")
                .padding(.top, 20)
           
            if self.appStates.dailyEvents.mealsHad.isEmpty {
                
            }
            
            VStack(spacing: 0) {
                
                ForEach(self.foodItemList.indices, id: \.self) { index in
                    FoodCard(food: self.foodItemList[index])
                        .onTapGesture {
                            self.appStates.currentSelectedFood = self.foodItemList[index]
                            withAnimation {
                                self.appStates.showFoodDetails = true
                            }
                        }
                    
                    if index != self.foodItemList.count - 1 {
                        CustomDivider()
                    }
                }
                
            }
            .frame(maxWidth: .infinity)
            .background(.darkBG.opacity(0.54))
            .overlay {
                defaultShape
                    .stroke(.white.opacity(0.18))
            }
            .clipShape(defaultShape)
            
            
            
        }
        .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
    }
}

