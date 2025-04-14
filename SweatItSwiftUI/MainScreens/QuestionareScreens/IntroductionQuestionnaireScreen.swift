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
        ScrollView {
            VStack {
                Text("From now on, you will be asked a series of questions to help us understand your fitness goals better.")
                    .font(.system(size: 13, weight: .regular, design: .rounded))
                    .foregroundStyle(.white.opacity(0.5))
                    .takeMaxWidthLeading()
                
                
                SectionHeader(text: "App Profile Details")
                    .padding(.top, 25)
                
                CustomTextField(searchText: self.$appStates.userData.fullName, placeholder: "Full Name")
                CustomTextField(searchText: self.$appStates.userData.username, placeholder: "Username")
                    .autocapitalization(.none)
                    .overlay(alignment: .trailing) {
                        if !self.appStates.userData.username.isEmpty && self.appStates.userData.username.count >= 8{
                            Text(self.isUsernameAvailable ? "✅" : "❌")
                                .padding(.horizontal, 20)
                        }
                    }
                    
                
                CustomSecureTextField(searchText: self.$appStates.userData.password, placeholder: "Password")
                    .autocapitalization(.none)
                
                CustomSecureTextField(searchText: self.$appStates.confirmPassword, placeholder: "Confirm Password")
                    .autocapitalization(.none)
                
                SectionHeader(text: "Personal Details")
                    .padding(.top, 25)
                CustomTextField(searchText: self.$appStates.userData.phoneNumber, placeholder: "Phone Number")
                    .autocapitalization(.none)
                CustomTextField(searchText: self.$appStates.userData.email, placeholder: "Email Id")
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
            .onChange(of: self.appStates.userData.username) {
                self.isUsernameAvailable = User.current.isUsernameAvailable(by: self.appStates.userData.username)
                self.appStates.isUsernameAvailable = self.isUsernameAvailable
                print(self.appStates.userData.username, User.current.allUsers, self.isUsernameAvailable)
            }
        }
    }
}


