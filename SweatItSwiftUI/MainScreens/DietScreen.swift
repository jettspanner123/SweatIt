//
//  DietScreen.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 11/03/25.
//

import SwiftUI

struct DietScreen: View {
    var body: some View {
        ScrollContentView {
            
            
            // MARK: Twin buttons
            HStack {
                PrimaryNavigationButton(text: "Barcode Scan", leadingPadding: 30)
                    .background(defaultShape.fill(ApplicationLinearGradient.redGradient))
                    .overlay {
                        HStack {
                            Image("Barcode")
                                .scaleEffect(0.75)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 10)
                    }
                
                PrimaryNavigationButton(text: "Add Food    ")
                    .background(defaultShape.fill(ApplicationLinearGradient.thanosGradient))
                    .overlay {
                        HStack {
                            Image(systemName: "plus")
                                .scaleEffect(1.25)
                                .foregroundStyle(.white.opacity(0.5))
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 15)
                    }
            }
            .frame(maxWidth: .infinity)
            
            
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
            
            
        }
        .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
    }
}

