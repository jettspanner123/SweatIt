//
//  RecommendationSettingPage.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 05/06/25.
//

import SwiftUI

struct RecommendationScreen: View {
    
    @EnvironmentObject var appStates: ApplicationStates
    
    enum SegmentTypes: String, CaseIterable {
        case foodItems = "Food Items", workout = "Workout"
    }
    
    @State var currentSelectedSegment: SegmentTypes = .foodItems
    var body: some View {
        ScreenBuilder {
            AccentPageHeader(pageHeaderTitle: "Recommendations")
            
            ScrollContentView {
                HStack {
                    ForEach(SegmentTypes.allCases, id: \.self) { caseType in
                        HStack {
                            Image(systemName: "person.3.fill")
                                .foregroundStyle(self.currentSelectedSegment == caseType ? .white : .white.opacity(0.5))
                            
                            Text(caseType.rawValue)
                                .font(.system(size: 13, weight: .medium, design: .rounded))
                                .foregroundStyle(self.currentSelectedSegment == caseType ? .white : .white.opacity(0.5))
                        }
                        .applicationDropDownButton(self.currentSelectedSegment == caseType ? ApplicationLinearGradient.blueGradientInverted : ApplicationLinearGradient.darkBGSameGradientWithOpacityHalf, height: 40)
                        .onTapWithScaleVibrate {
                            withAnimation {
                                self.currentSelectedSegment = caseType
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.bottom, 25)
                
                
                if self.currentSelectedSegment == .foodItems {
                    
                    if self.appStates.alreadyRecommendedFoodItems.isEmpty {
                        NotFoundView(text: "No Food Recommendation")
                            .transition(.offset(y: UIScreen.main.bounds.height))
                    }
                    ForEach(self.appStates.alreadyRecommendedFoodItems, id: \.id) { foodItem in
                        let food_t: FoodItem = .init(foodName: foodItem.foodName, foodDescription: foodItem.foodDescription, foodType: foodItem.foodType.rawValue, foodImage: "", foodQuantity: foodItem.foodQuantity, calories: foodItem.calories, protein: foodItem.protein, carbs: foodItem.carbs, fats: foodItem.fats, protienPerGram: foodItem.protein, carbsPerGram: foodItem.carbs, fatsPerGram: foodItem.fats, caloriesPerGram: foodItem.calories, mealType: "Breakfast ☕️")
                        FoodRecommendationViewCard(food: food_t,deleteRecommendationView: true ,actualArray: self.$appStates.recommendedFoodItems)
                            .transition(.offset(y: UIScreen.main.bounds.height))
                    }
                } else {
                    NotFoundView(text: "No Workout Recommendation")
                        .transition(.offset(y: UIScreen.main.bounds.height))
                }
                
            }
            .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
        }
    }
}
