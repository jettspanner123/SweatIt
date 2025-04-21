//
//  ScannedFoodDetailScreen.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 22/04/25.
//

import SwiftUI

struct ScannedFoodDetailScreen: View {
    @EnvironmentObject var appStates: ApplicationStates
    
    @State var foodItem: Optional<Food_t> = nil
    var body: some View {
        ScreenBuilder {
            
            
            AccentPageHeader_NoAction(pageHeaderTitle: "Scanned Food")
            
            ScrollContentView {
                
//              "[food_name,description_of_food_item_atleast_3_lines_dont_use_any_commas_here,estimated_quantity_in_gm_only_number,total_calories_only_numbers,protien_only_numbers,carbohydrates_only_numbers,fats_only_numbers], and this should be the only data that comes in, nothing else, do not keep the array brackets, only comma separated values, there should be no prefix or postfix things, if no food is found simply give me null"
                Text(self.foodItem.debugDescription)
                    .foregroundStyle(.white)
            }
        }
        .onAppear {
            let foodData = self.appStates.scannedFoodDetail.split(separator: ",")
            print(foodData, foodData.count)
            let foodName: String = foodData[0].trimmingCharacters(in: .whitespacesAndNewlines)
            let foodDescription = foodData[1].trimmingCharacters(in: .whitespacesAndNewlines)
            let foodQuantity = Double(foodData[2].trimmingCharacters(in: .whitespacesAndNewlines)) ?? .zero
            let foodCalories = Double(foodData[3].trimmingCharacters(in: .whitespacesAndNewlines)) ?? .zero
            let foodProtien: Double = Double(foodData[4].trimmingCharacters(in: .whitespacesAndNewlines)) ?? .zero
            let foodCarbs = Double(foodData[5].trimmingCharacters(in: .whitespacesAndNewlines)) ?? .zero
            let foodFats = Double(foodData[6].trimmingCharacters(in: .whitespacesAndNewlines)) ?? .zero
            self.foodItem = .init(foodName: foodName, foodDescription: foodDescription, foodQuantity: foodQuantity, calories: foodCalories, foodImage: "", foodType: .clean, protein: foodProtien, carbs: foodCarbs, fats: foodFats)
        }
    }
}
