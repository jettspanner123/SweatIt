//
//  DietScreen.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 11/03/25.
//

import SwiftUI

struct DietScreen: View {
    
    @State var foodItemList: Array<Food_t> = [Food.current.apple, Food.current.friedChicken, Food.current.sandwich, Food.current.smoothie]
    
    @State var dietCompletedPrecentage: CGFloat = 20.0
    
    @Binding var showCameraScreen: Bool 
    var body: some View {
        ScrollContentView {
            
            
            
            // MARK: Add food button
                
            PrimaryNavigationButton(text: "Add Food", leadingPadding: -UIScreen.main.bounds.width / 2)
                .background(defaultShape.fill(ApplicationLinearGradient.redGradient))
                .overlay {
                    HStack {
                        Image(systemName: "plus")
                            .foregroundStyle(.white.opacity(0.5))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                }
                .onTapGesture {
                    withAnimation {
                        self.showCameraScreen = true
                    }
                }
            
            SecondaryHeading(title: "Nutrition", secondaryText: "( per gram of body weight )")
                .padding(.top, 20)
            
            HStack {
                InformationCard(image: "FireLogo", title: "Burned", text: "195 kCal")
                    .background(defaultShape.fill(ApplicationLinearGradient.orangeGradient).opacity(0.85))
                
                InformationCard(image: "Food", title: "Consumed", text: "1900 kCal")
                    .background(defaultShape.fill(ApplicationLinearGradient.greenGradient).opacity(0.85))
                
            }
            .frame(maxWidth: .infinity)
            
            
            // MARK: Protein, Carbs and Fats here.
            MacrosViewCard()
            
            
            
            SecondaryHeading(title: "Calories Intake", secondaryText: "( As per \(ApplicationHelper.formatDateToHumanReadable(date: .now)) )")
                .padding(.top, 20)
            
            
            VStack(spacing: 0) {
                
                ForEach(self.foodItemList.indices, id: \.self) { index in
                    NavigationLink(destination: FoodDetailScreen(food: self.foodItemList[index])) {
                        FoodCard(food: self.foodItemList[index])
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

#Preview {
    DietScreen(showCameraScreen: .constant(false))
}
