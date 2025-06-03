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
    
    var caloricPercentage: Double {
        let something = self.caloriesConsumed / self.appStates.dailyNeeds.dailyCalories
        if something > 1 { return 1}
        return something
    }
    
    var caloriesBurned: Double {
        return self.appStates.dailyEvents.workoutsDone.reduce(0) { $0 + $1.caloriesBurned }
    }
    
    func loadingBarTextOffset(proxySize: CGSize) -> Double {
        let totalCharacters = String(self.caloriesConsumed).count
        print(totalCharacters)
        if self.caloricPercentage < 0.1 {
            return 15
        }
        let toReturn = (proxySize.width * self.caloricPercentage) + (totalCharacters == 4 ? -70 : totalCharacters == 3 ? -75 : -80)
        return abs(toReturn)
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
                                
                                
                                Text(String(format: "%.f kCl", self.caloriesConsumed))
                                    .font(.custom(ApplicationFonts.oswaldRegular, size: 20))
                                    .foregroundStyle(.white)
                                    .offset(x: self.loadingBarTextOffset(proxySize: proxySize))
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                            .zIndex(11)
                        }
                        .frame(height: 45)
                        .zIndex(11)
                        
                        
                        
                        // MARK: Goal calories to have
                        
                        HStack {
                            let dailyCaloriesIntake: Double = self.appStates.dailyNeeds.dailyCalories
                            Text(String(format: "%.f kCal", dailyCaloriesIntake))
                                .font(.custom(ApplicationFonts.oswaldRegular, size: 15))
                                .foregroundStyle(.white.opacity(0.25))
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
                        .padding(.horizontal)
                        
                        
                        
                        
                        // MARK: Actual loading bar
                        HStack {
                        }
                        .frame(maxHeight: .infinity)
                        .frame(width: proxySize.width * self.caloricPercentage)
                        .background(ApplicationLinearGradient.greenGradient)
                        
                        
                        
                        // MARK: Marker if completed diet for today
                        if self.caloriesConsumed >= self.appStates.dailyNeeds.dailyCalories {
                            HStack {
                                Image(systemName: "checkmark.seal.fill")
                                    .foregroundStyle(.white)
                            }
                        }
                        
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
            
            
            
            // MARK: IF not food items yet
            if self.appStates.dailyEvents.mealsHad.isEmpty {
                NotFoundView(text: "No Food Consumed")
                    .padding(.bottom)
            }
            
            
            
            // MARK: List of food items
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
        .onChange(of: self.caloriesConsumed) {
            self.appStates.dailyEvents.caloriesIngestedForTheDay = self.caloriesConsumed
        }
    }
}


struct CustomProgressBar: View {
    
    @EnvironmentObject var appStates: ApplicationStates
    
    var goalValue: Double
    var currentValue: Double
    var siUnit: String
    var loadingBarBackground: LinearGradient
    var background: Color
    
    var percentage: Double {
        let something = self.currentValue / self.goalValue
        if something > 1 { return 1 }
        return something
    }
    
    
    func loadingBarTextOffset(proxySize: CGSize) -> Double {
        let totalCharacters = String(self.currentValue).count
        if self.percentage < 0.1 {
            return 15
        }
        let toReturn = (proxySize.width * self.percentage) - 60
        return abs(toReturn)
    }
    
    var body: some View {
        HStack {
            GeometryReader { geometryProx in
                
                let proxySize = geometryProx.size
                ZStack(alignment: .leading) {
                    
                    
                    
                    
                    // MARK: Total Caores Had today
                    GeometryReader { textProxy in
                        HStack {
                            
                            
                            Text(String(format: "%.f", self.currentValue))
                                .font(.custom(ApplicationFonts.oswaldRegular, size: 20))
                                .foregroundStyle(.white)
                                .offset(x: self.loadingBarTextOffset(proxySize: proxySize))
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                        .zIndex(11)
                    }
                    .frame(height: 45)
                    .zIndex(11)
                    
                    
                    
                    // MARK: Goal calories to have
                    
                    HStack {
                        Text(String(format: "%.f \(self.siUnit)", self.goalValue))
                            .font(.custom(ApplicationFonts.oswaldRegular, size: 15))
                            .foregroundStyle(.white.opacity(0.25))
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
                    .padding(.horizontal)
                    
                    
                    
                    
                    // MARK: Actual loading bar
                    HStack {
                    }
                    .frame(maxHeight: .infinity)
                    .frame(width: proxySize.width * self.percentage)
                    .background(self.loadingBarBackground)
                    
                    
                    
                    // MARK: Marker if completed diet for today
                    if self.currentValue >= self.goalValue {
                        HStack {
                            Image(systemName: "checkmark.seal.fill")
                                .foregroundStyle(.white)
                        }
                    }
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(height: 45)
                .background(self.background)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .overlay {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(.white.opacity(0.08))
                }
                
                
                
            }
            
        }
        .frame(maxWidth: .infinity)
        .frame(height: 45)
    }
}
