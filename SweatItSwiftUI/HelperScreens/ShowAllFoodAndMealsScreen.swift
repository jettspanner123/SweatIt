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
    
    var currentSelectedData: DailyEvents_t? {
        for data in weeklyData where ApplicationHelper.formatDateToHumanReadableWithoutTime(date: data.date) == date {
            return data
        }
        return nil
        
    }
    var body: some View {
        ScreenBuilder {
            AccentPageHeader(pageHeaderTitle: "Food & Meals")
            
            ScrollContentView {
                if let currentSelectedData {
                    ForEach(currentSelectedData.mealsHad, id: \.id) { meal in
                        ForEach(meal.foodItems, id: \.id) { food in
                            NavigationLink(destination: FoodDetailScreen(food: food)) {
                                FoodViewCard(food: food)
                            }
                            .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
                        }
                    }
                }
            }
        }
    }
}

