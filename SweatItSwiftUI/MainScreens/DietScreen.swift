//
//  DietScreen.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 11/03/25.
//

import SwiftUI


struct DietScreen: View {
    
    @EnvironmentObject var appStates: ApplicationStates
    
    @State var foodItemList: Array<Food_t> = [Food.current.apple, Food.current.friedChicken, Food.current.sandwich, Food.current.smoothie]
    
    @State var dietCompletedPrecentage: CGFloat = 20.0
    
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
                
                InformationCard(image: "FireLogo", title: "Burned", text: "195 kCal", secondaryText: "", textColor: .white, wantInformationView: true) {
                    
                }
                .background(defaultShape.fill(ApplicationLinearGradient.orangeGradient).opacity(0.85))
                
                InformationCard(image: "Food", title: "Consumed", text: "1900 kCal", secondaryText: "", textColor: .white, wantInformationView: true) {
                    
                }
                .background(defaultShape.fill(ApplicationLinearGradient.greenGradient).opacity(0.85))
            }
            .frame(maxWidth: .infinity)
            
            
            // MARK: Protein, Carbs and Fats here.
            MacrosViewCard()
            
            
            
            SecondaryHeading(title: "Calories Intake", secondaryText: "( As per \(ApplicationHelper.formatDateToHumanReadable(date: .now)) )")
                .padding(.top, 20)
            
            
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

