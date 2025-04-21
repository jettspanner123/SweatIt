//
//  ShowAllFoodAndMealsScreen.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 26/03/25.
//

import SwiftUI

struct ShowAllFoodAndMealsScreen: View {
    
    @Binding var date: String
    
    @State var weeklyData: Array<DailyEvents_t> = DailyEvents.current.weeklyEvents
    @State var currentSelectedFoodItem: Food_t? = nil
    @State var showFoodDetails: Bool = false
    
    var currentSelectedData: DailyEvents_t? {
        for data in weeklyData where ApplicationHelper.formatDateToHumanReadableWithoutTime(date: data.date) == date {
            return data
        }
        return nil
        
    }
    var body: some View {
        ScreenBuilder {
            
            
            if self.showFoodDetails {
                FoodDetailScreen(food: self.currentSelectedFoodItem!, showFoodDetailsScreen: self.$showFoodDetails)
                    .zIndex(ApplicationBounds.dialogBoxZIndex)
                    .transition(.offset(y: UIScreen.main.bounds.height))
            }
            
            if self.showFoodDetails {
                CustomBackDrop()
            }
            
            AccentPageHeader(pageHeaderTitle: "Food & Meals")
            
            ScrollContentView {
                if let currentSelectedData {
                    ForEach(currentSelectedData.mealsHad, id: \.id) { meal in
                        ForEach(meal.foodItems, id: \.id) { food in
                            FoodViewCard(food: food)
                                .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
                                .onTapWithScale {
                                    self.currentSelectedFoodItem = food
                                    withAnimation {
                                        self.showFoodDetails = true
                                    }
                                }
                        }
                    }
                }
            }
        }
    }
}

