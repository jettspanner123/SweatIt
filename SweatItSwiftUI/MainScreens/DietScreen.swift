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
                GeometryReader { geometryProx in
                    
                    let proxySize = geometryProx.size
                    ZStack(alignment: .leading) {
                        
                        
                        
                        
                        // MARK: Total Caores Had today
                        GeometryReader { textProxy in
                            HStack {
                                
                                let caloriesConsumed = 20
                                let totalCharacters = String(caloriesConsumed).count
                                Text(String(caloriesConsumed))
                                    .font(.custom(ApplicationFonts.oswaldRegular, size: 20))
                                    .foregroundStyle(.white)
                                    .offset(x: (proxySize.width * 0.5) + (totalCharacters == 4 ? -60 : totalCharacters == 3 ? -45 : -35))
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                            .zIndex(11)
                        }
                        .frame(height: 45)
                        .zIndex(11)
                        
                        
                        
                        // MARK: Goal calories to have
                        
                        HStack {
                           Text("1800 kCal")
                                .font(.custom(ApplicationFonts.oswaldRegular, size: 15))
                                .foregroundStyle(.white.opacity(0.25))
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
                        .padding(.horizontal)
                        
                        
                        
                        
                        // MARK: Actual loading bar
                        HStack {
                            GeometryReader { loadingBarReader in
                                HStack {
                                    
                                }
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .background(.blue)
                                .phaseAnimator([], content: { content, phase in
                                    
                                }, animation: { phase in
                                    
                                })
                                
                                
                            }
                        }
                        .frame(maxHeight: .infinity)
                        .frame(width: proxySize.width * 0.5)
                        .background(ApplicationLinearGradient.greenGradient)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .frame(height: 45)
                    .background(.darkBG.opacity(0.54), in: .rect(cornerRadius: 12))
                    .overlay {
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(.white.opacity(0.08))
                    }
                }
                
            }
            .frame(maxWidth: .infinity)
            .frame(height: 45)
            
            
            
            
            
            
            
            
            
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

