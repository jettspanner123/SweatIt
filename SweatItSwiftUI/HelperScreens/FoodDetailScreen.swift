//
//  FoodDetailScreen.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 14/03/25.
//

import SwiftUI

struct FoodDetailScreen: View {
    var food: Food_t = Food.current.sandwich
    @Binding var showFoodDetailsScreen: Bool
    
    @Environment(\.dismiss) var dismiss
    
    var image: UIImage {
        let image = UIImage(named: self.food.foodImage)!
        return image
    }
    
    @State var colors: Array<Color> = []
    
    
    var body: some View {
        VStack {
            VStack {
                Text(self.food.foodName)
                    .font(.custom(ApplicationFonts.oswaldRegular, size: 25))
                    .foregroundStyle(.white)
                
                CustomDivider()
                    .offset(y: -5)
                
                
                SectionHeader(text: "Food Macros")
                    .padding(.top, 5)
                // MARK: Protien, fats and carbs
                HStack {
                    
                    // MARK: Protient card
                    HStack(spacing: 5) {
                        Text(String(format: "%.f 🍖", self.food.protein))
                            .font(.custom(ApplicationFonts.oswaldRegular, size: 20))
                            .foregroundStyle(.white)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 15)
                    .padding(.vertical, 8)
                    .background(.darkBG.opacity(0.54))
                    .overlay {
                        defaultShape
                            .stroke(.white.opacity(0.18))
                    }
                    .clipShape(defaultShape)
                    
                    
                    
                    
                    // MARK: Carbs card
                    HStack(spacing: 5) {
                        Text(String(format: "%.f 🍞", self.food.carbs))
                            .font(.custom(ApplicationFonts.oswaldRegular, size: 20))
                            .foregroundStyle(.white)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 15)
                    .padding(.vertical, 8)
                    .background(.darkBG.opacity(0.54))
                    .overlay {
                        defaultShape
                            .stroke(.white.opacity(0.18))
                    }
                    .clipShape(defaultShape)
                    
                    
                    
                    
                    
                    // MARK: Fats card
                    HStack(spacing: 5) {
                        Text(String(format: "%.f 🍖", self.food.fats))
                            .font(.custom(ApplicationFonts.oswaldRegular, size: 20))
                            .foregroundStyle(.white)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 15)
                    .padding(.vertical, 8)
                    .background(.darkBG.opacity(0.54))
                    .overlay {
                        defaultShape
                            .stroke(.white.opacity(0.18))
                    }
                    .clipShape(defaultShape)
                }
                
                
                
                // MARK: Other food details
                
                SectionHeader(text: "Other Details")
                    .padding(.top, 15)

                CustomList {
                    
                    SpaceSeparatedKeyValue(key: "Calories", value: String(format: "%.f kCal", self.food.calories))
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                    
                    CustomDivider()
                    
                    
                    SpaceSeparatedKeyValue(key: "Time", value: ApplicationHelper.getTimeString(from: self.food.timeOfHaving))
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                    
                    CustomDivider()
                    
                    SpaceSeparatedKeyValue(key: "Quantity", value: String(format: "%.1f gm", self.food.foodQuantity))
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                    
                    CustomDivider()
                    
                    
                    if self.food.foodDescription.split(separator: "").count > 20 {
                        
                        SpaceSeparatedKeyValue(key: "Description Provided", value: "")
                            .padding(.horizontal)
                            .padding(.top, 5)
                        
                        Text(self.food.foodDescription)
                            .font(.system(size: 15, weight: .regular, design: .rounded))
                            .foregroundStyle(.white.opacity(0.5))
                            .takeMaxWidthLeading()
                            .padding(.horizontal)
                            .padding(.bottom, 5)
                        
                    } else {
                        SpaceSeparatedKeyValue(key: "Description Provided", value: self.food.foodDescription)
                            .padding(.horizontal)
                            .padding(.vertical, 5)
                    }
                    
                }
                
                
                SimpleButton(content: {
                   Text("Okay")
                        .font(.system(size: 13, weight: .medium, design: .rounded))
                        .foregroundStyle(.white)
                }, backgroundLinearGradient: ApplicationLinearGradient.thanosGradient, some: {
                    withAnimation {
                        self.showFoodDetailsScreen = false
                    }
                })
                .padding(.top, 25)

                
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(.darkBG, in: defaultShape)
            .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
            .shadow(radius: 10)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}


