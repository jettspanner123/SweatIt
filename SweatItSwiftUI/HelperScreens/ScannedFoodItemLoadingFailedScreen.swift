//
//  ScannedFoodItemLoadingFailedScreen.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 23/04/25.
//

import SwiftUI

struct ScannedFoodItemLoadingFailedScreen: View {
    @EnvironmentObject var appStates: ApplicationStates
    
    
    var body: some View {
        VStack {
            Image(systemName: "exclamationmark.icloud.fill")
                .resizable()
                .frame(width: 140, height: 100)
                .foregroundStyle(.white)
            
            Text("It's not you, it's us.".uppercased())
                .font(.custom(ApplicationFonts.oswaldRegular, size: 25))
                .foregroundStyle(.white)
            
            HStack {
                
            }
            .frame(width: UIScreen.main.bounds.width * 0.5, height: 2)
            .background(.white.opacity(0.5))
            .offset(y: -15)
            
            Text("There was an error while fetching data of the scanned food item. Please make sure to take the photo in a well lit environment and try again.")
                .font(.system(size: 13, weight: .regular, design: .rounded))
                .foregroundStyle(.white)
                .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding * 3)
                .multilineTextAlignment(.center)
            
            SimpleButton(content: {
               Text("I, Understand")
                    .font(.system(size: 14, weight: .medium, design: .rounded))
                    .foregroundStyle(.ratingRed)
            }, backgroundLinearGradient: .init(gradient: .init(colors: [.white.opacity(0.9), .white.opacity(0.9)]), startPoint: .top, endPoint: .bottom), some: {
                self.appStates.showScannedFoodDetailScreen = false
            })
            .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding * 4)
            .padding(.top, 40)
                
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(ApplicationLinearGradient.redGradient)
    }
}


