//
//  LoginScreen.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 19/03/25.
//

import SwiftUI

struct LoginScreen: View {
    
    enum RegistrationTypes: String, CaseIterable {
        case SignIn, SignUp
    }
    
    struct LoginStateObject {
        var username: String = ""
        var password: String = ""
    }
    
    
    
    @Binding var showLoginScreen: Bool
    @Binding var showIsland: Bool
    
    
    @State var loginStateObject: LoginStateObject = .init()
    
    @State var isSubmitButtonClicked: Bool = false
    @State var isStartButtonClicked: Bool = false
    
    @State var currentSelectedRegistrationType: RegistrationTypes = .SignIn
    
    @State var showOnBoardingScreen: Bool = true
    
    var isSubmitButtonDisabled: Bool {
        self.loginStateObject.username.isEmpty || self.loginStateObject.password.isEmpty
    }
    
    func performLogin() -> Void {
        self.isSubmitButtonClicked = true
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.isSubmitButtonClicked = false
            withAnimation(.smooth(duration: 1.5)) {
                self.showLoginScreen = true
                self.showIsland = true
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    withAnimation(.smooth(duration: 1.5)) {
                        self.showIsland = false
                    }
                }
            }
        }
    }
    
    
    var onboardingScreenDetils: Array<String> = [
        "",
        "",
        "",
    ]
    
    
    var body: some View {
        ZStack {
          
            
                        
            
            ScreenBuilder {
                VStack {
                    // MARK: Upar wala header hai bhai
                    HStack(spacing: 1) {
                        
                        Text("SweatIt")
                            .font(.custom(ApplicationFonts.oswaldRegular, size: 30))
                            .foregroundStyle(.white)
                            .padding(.leading, 10)
                        
                        
                        Image("Workout")
                            .resizable()
                            .frame(width: 40, height: 35)
                            .offset(x: 5, y: 3)
                        
                        
                        
                        HStack {
                            ForEach(RegistrationTypes.allCases, id: \.self) { type in
                                Text(type.rawValue.capitalized)
                                    .font(.system(size: 15, weight: .regular, design: .rounded))
                                    .foregroundStyle(self.currentSelectedRegistrationType == type ? .black : .white)
                                    .padding(10)
                                    .background(self.currentSelectedRegistrationType == type ? .white : .clear)
                                    .clipShape(defaultShape)
                                    .onTapGesture {
                                        withAnimation {
                                            self.currentSelectedRegistrationType = type
                                        }
                                    }
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        
                        
                        
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .frame(height: 130, alignment: .bottom)
                    .padding(.bottom, ApplicationPadding.mainScreenHorizontalPadding / 2)
                    .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding / 2.5)
                    .overlay {
                        defaultShape
                            .stroke(.white.opacity(0.18))
                    }
                    .background(.darkBG.opacity(0.54))
                    .clipShape(defaultShape)
                    .offset(y: -1)
                    
                    
                    
                    
                    // MARK: Segmented view
                    
                    
                    
                    
                    // MARK: Condintional rendering based on if the user wants to log in or sign up
                    
                    
                    // MARK: Login screen
                    if self.currentSelectedRegistrationType == .SignIn {
                        VStack {
                            
                            
                            // MARK: Username and password files
                            
                            CustomTextField(searchText: self.$loginStateObject.username, placeholder: "Username")
                                .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
                                .padding(.top, 10)
                            
                            CustomSecureTextField(searchText: self.$loginStateObject.password, placeholder: "Password")
                                .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
                            
                            
                        }
                        .transition(.blurReplace)
                        
                        
                        
                        // MARK: Sign up screen
                    } else {
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
                    Spacer()
                    
                    
                    
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .ignoresSafeArea(edges: .top)
            }
            
            // MARK: Submit button
            if self.currentSelectedRegistrationType == .SignIn {
                HStack {
                    if self.isSubmitButtonClicked {
                        ProgressView()
                            .tint(.white)
                            .transition(.blurReplace)
                    } else {
                        Text("Submit")
                            .font(.system(size: 15, weight: .medium, design: .rounded))
                            .foregroundStyle(.white)
                            .transition(.blurReplace)
                    }
                    
                }
                .frame(maxWidth: .infinity)
                .frame(height: 45)
                .background(ApplicationLinearGradient.redGradient)
                .clipShape(defaultShape)
                .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
                .onTapGesture {
                    withAnimation {
                        self.performLogin()
                    }
                }
                .offset(y: UIScreen.main.bounds.height / 2 - (75))
                .transition(.blurReplace.combined(with: .offset(y: 100)))
            }
            
            
            if self.currentSelectedRegistrationType == .SignUp {
                HStack {
                    Text("Start Journey")
                        .font(.system(size: 15, weight: .medium, design: .rounded))
                        .foregroundStyle(.white)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 45)
                .background(ApplicationLinearGradient.blueGradientInverted)
                .clipShape(defaultShape)
                .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
                .offset(y: UIScreen.main.bounds.height / 2 - (75))
                .onTapGesture {
                    withAnimation(.smooth) {
                        self.isStartButtonClicked = true
                    }
                }
                .transition(.blurReplace.combined(with: .offset(y: 100)))
            }
        }
        .navigationDestination(isPresented: self.$isStartButtonClicked, destination: {
            InitialQuestionnaireScreen(showLoginScreen: self.$showLoginScreen)
        })
    }
}


#Preview {
    LoginScreen(showLoginScreen: .constant(false), showIsland: .constant(false))
}


