//
//  AddMealScreen.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 24/03/25.
//

import SwiftUI

struct AddMealScreen: View {
    
    @State var meals: Array<Meal_t> = Meal.current.exampleMeals
    
    var body: some View {
        ScreenBuilder {
            
            AccentPageHeader(pageHeaderTitle: "Manage Meals")
            
            ScrollContentView {
                
                
                
                // MARK: Twin buttons
                HStack {
                    
                    PrimaryNavigationButton(text: "Create Meal", leadingPadding: 25)
                        .background(
                            defaultShape
                                .fill(ApplicationLinearGradient.redGradient)
                        )
                        .overlay {
                            HStack {
                                Image(systemName: "plus")
                                    .foregroundStyle(.white.opacity(0.5))
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal)
                            
                        }
                    
                    
                    
                    
                    PrimaryNavigationButton(text: "Manage Meals", leadingPadding: 25)
                        .background(
                            defaultShape
                                .fill(ApplicationLinearGradient.thanosGradient)
                        )
                        .overlay {
                            HStack {
                                Image(systemName: "plus")
                                    .foregroundStyle(.white.opacity(0.5))
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal)
                        }
                }
                
                
                
                
                
                
                
                
                    
            }
            .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
        }
    }
}




#Preview {
    AddMealScreen()
}
