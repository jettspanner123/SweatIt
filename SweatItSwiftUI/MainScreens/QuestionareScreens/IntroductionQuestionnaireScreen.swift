//
//  IntroScreen.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 19/03/25.
//

import SwiftUI

struct IntroductionQuestionnaireScreen: View {
    @EnvironmentObject var appStates: ApplicationStates
    
    @Binding var currentSelectedPage: InitialQuestionnaireScreen.QuestionPageScreens
    @State var isUsernameAvailable: Bool = false
    
    var body: some View {
        VStack {
            Text("From now on, you will be asked a series of questions to help us understand your fitness goals better.")
                .font(.system(size: 13, weight: .regular, design: .rounded))
                .foregroundStyle(.white.opacity(0.5))
                .takeMaxWidthLeading()
            
            CustomTextField(searchText: self.$appStates.userData.username, placeholder: "Username")
                .autocapitalization(.none)
                .overlay {
//                    HStack {
//                        if !InitialQuestionnaireScreen.userQuestionnaireStore.username.isEmpty && !isUsernameAvailable {
//                            ProgressView()
//                                .tint(.white.opacity(0.5))
//                        }
//                        
//                        if self.isUsernameAvailable {
//                            Text("✅")
//                        }
//                        
//                        
//                    }
//                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
//                    .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
                }
                .padding(.top, 15)

            CustomSecureTextField(searchText: self.$appStates.userData.password, placeholder: "Password")
                .autocapitalization(.none)
           
            if self.appStates.isError {
                Text("Username and password fields cannot be empty.")
                    .font(.system(size: 12, weight: .regular, design: .rounded))
                    .foregroundStyle(ApplicationLinearGradient.redGradient)
                    .padding(.top, 5)
                    .transition(.blurReplace.combined(with: .offset(y: 10)))
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(.top, ApplicationPadding.mainScreenVerticalPadding)
        .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
    }
}


