//
//  IntroScreen.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 19/03/25.
//

import SwiftUI

struct IntroductionQuestionnaireScreen: View {
    @Binding var currentSelectedPage: InitialQuestionnaireScreen.QuestionPageScreens
    
//    @State var signupStateStore: ApplicationConstants.SignupStateObject = .init()
    @State var isUsernameAvailable: Bool = false
    
    
    func validateUsername() -> Void {
        if InitialQuestionnaireScreen.userQuestionnaireStore.username == "hello" {
            self.isUsernameAvailable = true
        } else {
            self.isUsernameAvailable = false
        }
    }
    
    var body: some View {
        VStack {
            Text("From now on, you will be asked to complete a questionnaire to help us understand your preferences better.")
                .font(.system(size: 13, weight: .regular, design: .rounded))
                .foregroundStyle(.white.opacity(0.5))
                .takeMaxWidthLeading()
            
            CustomTextField(searchText: InitialQuestionnaireScreen.$userQuestionnaireStore.username, placeholder: "Username")
                .onChange(of: InitialQuestionnaireScreen.userQuestionnaireStore.username) {
                    self.validateUsername()
                }
                .autocapitalization(.none)
                .overlay {
                    HStack {
                        if !InitialQuestionnaireScreen.userQuestionnaireStore.username.isEmpty && !isUsernameAvailable{
                            ProgressView()
                                .tint(.white.opacity(0.5))
                        }
                        
                        if self.isUsernameAvailable {
                            Text("✅")
                        }
                        
                        
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
                    .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
                }
                .padding(.top, 15)

            CustomSecureTextField(searchText: InitialQuestionnaireScreen.$userQuestionnaireStore.password, placeholder: "Password")
            CustomSecureTextField(searchText: InitialQuestionnaireScreen.$userQuestionnaireStore.confirmPassword, placeholder: "Confirm Password")
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(.top, ApplicationPadding.mainScreenVerticalPadding)
        .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
    }
}


