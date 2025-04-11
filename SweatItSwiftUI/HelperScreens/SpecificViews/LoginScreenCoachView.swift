//
//  LoginScreenCoachView.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 10/04/25.
//

import SwiftUI

struct LoginScreenCoachView: View {
    var body: some View {
        VStack {
            VStack(spacing: -35) {
                Image("hero_image_group")
                    .scaleEffect(0.7)
                
                Text("Hello! 👋")
                    .font(.custom(ApplicationFonts.robotoCondensedRegular, size: 35))
                    .foregroundStyle(.white)
            }
            .offset(y: -30)
            
            Spacer()
            
            
            Text("I'm your personal coach.")
                .font(.custom(ApplicationFonts.robotoCondensedLight, size: 18))
                .foregroundStyle(.white)
                .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding * 2)
            
            CustomDivider()
                .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding * 8)
            
            Text("I'll be guiding you throughout our journey.")
                .font(.custom(ApplicationFonts.robotoCondensedLight, size: 18))
                .foregroundStyle(.white)
                .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding * 2)
                .padding(.top, 0.5)
                .multilineTextAlignment(.center)
            
            CustomDivider()
                .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding * 8)
            
            
            HStack {
                Text("Here are some ")
                    .font(.custom(ApplicationFonts.robotoCondensedLight, size: 18))
                    .foregroundStyle(.white) +
                Text("personalised questions")
                    .font(.custom(ApplicationFonts.robotoCondensedLight, size: 18))
                    .foregroundStyle(Color.appRedLight.gradient) +
                Text(" to tailor your ")
                    .font(.custom(ApplicationFonts.robotoCondensedLight, size: 18))
                    .foregroundStyle(.white) +
                Text("journey.")
                    .font(.custom(ApplicationFonts.robotoCondensedLight, size: 18))
                    .foregroundStyle(.appBlueLight.gradient)
                
            }
            .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding * 2)
            .padding(.top, 0.5)
            .multilineTextAlignment(.center)
            .padding(.bottom, 50)
            
            Spacer()
            Spacer()
            
            
            
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
        .transition(.blurReplace)
    }
}

#Preview {
    LoginScreenCoachView()
}
