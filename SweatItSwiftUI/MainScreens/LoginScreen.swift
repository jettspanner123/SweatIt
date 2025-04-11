//
//  LoginScreen.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 19/03/25.
//

import SwiftUI

struct LoginScreen: View {
    
    enum RegistrationTypes: String, CaseIterable {
        case SignIn = "Sign In", SignUp = "Sign Up"
    }
    
    @Binding var showLoginScreen: Bool
    @Binding var showIsland: Bool
    
    
    @State var loginStateObject: LogInUserDataStore = .init(username: "", password: "", confirmPassword: "", emailIfForgot: "")
    @State var hasUserFogotTheirPassword: Bool = false
    
    @State var isSubmitButtonClicked: Bool = false
    @State var isStartButtonClicked: Bool = false
    
    @State var currentSelectedRegistrationType: RegistrationTypes = .SignUp
    
    
    
    func performLogin() async throws -> Void {
        self.isSubmitButtonClicked = true
        
        do {
            if let user_t = try await ApplicationEndpoints.get.authenticateUser(by: self.loginStateObject.username, and: self.loginStateObject.password) {
                self.performLoginAnimationHelper()
            }
        } catch {
            print(ErrorType.cannotParseUser.rawValue)
            return
        }
    }
    
    func performLoginAnimationHelper() -> Void {
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
    
    var body: some View {
        ScreenBuilder {
            if self.currentSelectedRegistrationType == .SignIn {
                self.loginScreen
                    .transition(.offset(y: -UIScreen.main.bounds.height))
            } else {
                self.signupScreen
                    .transition(.offset(y: UIScreen.main.bounds.height))
            }
            
        }
        .sensoryFeedback(.increase, trigger: self.hasUserFogotTheirPassword)
        .sensoryFeedback(.increase, trigger: self.currentSelectedRegistrationType)
        .fullScreenCover(isPresented: self.$isStartButtonClicked) {
            InitialQuestionnaireScreen(showLoginScreen: self.$showLoginScreen)
        }
    }
    
    
    
    
    // MARK: Signup view
    var signupScreen: some View {
        VStack {
            
            
            
            // MARK: Sign up view heading
            HStack {
                Image(systemName: "person.fill.badge.plus")
                    .resizable()
                    .frame(width: 35, height: 35)
                    .foregroundStyle(.white)
                    .offset(y: 5)
                
                
                Text("SignUp")
                    .font(.custom(ApplicationFonts.oswaldRegular, size: 35))
                    .foregroundStyle(.white)
                    .takeMaxWidthLeading()
            }
            .padding(.horizontal)
            
            
            
            // MARK: Coach card
            HStack(alignment: .top) {
                VStack {
                    Text("AI Coach")
                        .font(.system(size: 15, weight: .bold, design: .rounded))
                        .foregroundStyle(.white)
                        .takeMaxWidthLeading()
                    
                    Text("Dr. Sweat It")
                        .font(.system(size: 12, weight: .regular, design: .rounded))
                        .foregroundStyle(.white.opacity(0.5))
                        .takeMaxWidthLeading()
                    
                    Spacer()
                    
                    HStack {
                        Text("Physiologist")
                            .font(.system(size: 10, weight: .medium, design: .rounded))
                            .foregroundStyle(.white.opacity(0.5))
                            .padding(5)
                            .background(.darkBG.opacity(0.54), in: RoundedRectangle(cornerRadius: 8))
                            .overlay {
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(.white.opacity(0.18))
                            }
                        
                        Text("Dietitian")
                            .font(.system(size: 10, weight: .medium, design: .rounded))
                            .foregroundStyle(.white.opacity(0.5))
                            .padding(5)
                            .background(.darkBG.opacity(0.54), in: RoundedRectangle(cornerRadius: 8))
                            .overlay {
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(.white.opacity(0.18))
                            }
                        
                        Text("Statistician")
                            .font(.system(size: 10, weight: .medium, design: .rounded))
                            .foregroundStyle(.white.opacity(0.5))
                            .padding(5)
                            .background(.darkBG.opacity(0.54), in: RoundedRectangle(cornerRadius: 8))
                            .overlay {
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(.white.opacity(0.18))
                            }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                }
                
                VStack {
                    Image(ApplicationImages.coachImageWithBackground)
                        .resizable()
                        .frame(width: 75, height: 80)
                }
                .frame(width: 70, height: 70)
                .background(.clear, in: defaultShape)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(height: 110)
            .background(.darkBG.opacity(0.54))
            .overlay {
                defaultShape
                    .stroke(.white.opacity(0.18))
            }
            .clipShape(defaultShape)
            
            
            
            SectionHeader(text: "About Questionnaire")
                .padding(.top, 25)
            
            HStack {
                VStack(spacing: 0) {
                    ForEach(1...4, id: \.self) { index in
                        HStack {
                            HStack {
                                
                            }
                            .frame(width: 10, height: 10)
                            .background(.white, in: Circle())
                        }
                        .frame(maxHeight: .infinity, alignment: .top)
                        .frame(width: 2)
                        .background(.white.opacity(0.5), in: index == 1 || index == 4 ? RoundedRectangle(cornerRadius: 8) : RoundedRectangle(cornerRadius: 0))
                        
                    }
                }
                .frame(maxHeight: .infinity)
                .frame(width: 50)
                
                VStack {
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(ApplicationPadding.mainScreenHorizontalPadding)
            
            Spacer()
            
            
            
            
            
            // MARK: Sumbit button
            SimpleButton(content: {
                Text("Let's Get Started")
                    .font(.system(size: 13, weight: .medium, design: .rounded))
                    .foregroundStyle(.white)
                    .onTapGesture {
                        withAnimation {
                            self.isStartButtonClicked = true
                        }
                    }
            }, backgroundLinearGradient: ApplicationLinearGradient.blueGradientInverted, some: {
                
            })

            HStack {
                Text("Already have an account?")
                    .font(.system(size: 15, weight: .regular))
                    .foregroundStyle(.white.opacity(0.5))
                
                Text("Sign In")
                    .font(.system(size: 15, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)
                    .underline()
                    .padding(.vertical)
                    .onTapGesture {
                        withAnimation(.smooth(duration: 1)) {
                            self.currentSelectedRegistrationType = .SignIn
                        }
                    }
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .safeAreaPadding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
        .safeAreaPadding(.top, 25)
    }
    
    
    
    
    
    // MARK: Login view
    var loginScreen: some View {
        VStack {
            
            HStack(spacing: 0) {
                
                Image(ApplicationImages.tabBarDumbbell)
                
                Text("LogIn")
                    .font(.custom(ApplicationFonts.oswaldRegular, size: 35))
                    .foregroundStyle(.white)
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            if self.hasUserFogotTheirPassword {
                
                Text("This will get you a temperary password over you email, you have to change the temperory password.")
                    .font(.system(size: 12, weight: .medium, design: .rounded))
                    .foregroundStyle(.white.opacity(0.5))
                
                // MARK: Email text field
                CustomTextField(searchText: self.$loginStateObject.emailIfForgot, placeholder: "Email Id")
                    .padding(.top, 10)
                    .transition(.blurReplace)
                
                
                
                
                
                
                // MARK: Get otp button
                SimpleButton(content: {
                    if PostMethodStore.current.isDatabaseLoading {
                        ProgressView()
                            .tint(.white)
                    } else {
                        Text("Get Password")
                            .font(.system(size: 13, weight: .medium, design: .rounded))
                            .foregroundStyle(.white)
                    }
                }, backgroundLinearGradient: ApplicationLinearGradient.redGradient, some: {
                    
                })
                .padding(.top)
                .transition(.blurReplace)
                
                
                
                // MARK: Cancel button
                
                HStack {
                    Text("Cancel")
                        .font(.system(size: 13, weight: .medium, design: .rounded))
                        .foregroundStyle(.white.opacity(0.5))
                        .frame(maxWidth: .infinity)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 45)
                .background(.white.opacity(0.08))
                .clipShape(defaultShape)
                .onTapGesture {
                    withAnimation {
                        self.hasUserFogotTheirPassword = false
                    }
                }
                .transition(.blurReplace)
            } else {
                // MARK: Username field
                CustomTextField(searchText: self.$loginStateObject.username, placeholder: "Username")
                    .transition(.blurReplace)
                
                
                
                // MARK: Password field
                CustomSecureTextField(searchText: self.$loginStateObject.password, placeholder: "Password")
                    .transition(.blurReplace)
                
                
                // MARK: Error section
                if GetMethodStore.current.isError {
                    
                    Text(ErrorType.invalidArguments.rawValue)
                        .font(.system(size: 12, weight: .regular, design: .rounded))
                        .foregroundStyle(.appRedLight)
                        .padding(.vertical)
                        .padding(.horizontal, 5)
                        .transition(.blurReplace)
                        .transition(.blurReplace)
                }
                
                HStack {
                    
                    
                    if GetMethodStore.current.isError {
                        Text(GetMethodStore.current.errorMessage.rawValue)
                            .font(.system(size: 13, weight: .regular, design: .rounded))
                            .foregroundStyle(.appRedLight)
                            .padding(.vertical)
                            .padding(.horizontal, 5)
                        
                        
                    }
                    
                    Spacer()
                    Text("Forgot Password?")
                        .font(.system(size: 13, weight: .regular, design: .rounded))
                        .foregroundStyle(.white)
                        .padding(.vertical, 5)
                        .underline()
                        .onTapGesture {
                            withAnimation {
                                self.hasUserFogotTheirPassword = true
                            }
                        }
                }
                .frame(maxWidth: .infinity)
                .transition(.blurReplace)
                
                
                // MARK: Submit button
                SimpleButton(content: {
                    if self.isSubmitButtonClicked {
                        ProgressView()
                            .tint(.white)
                    } else {
                        Text("Submit")
                            .font(.system(size: 15, weight: .medium, design: .rounded))
                            .foregroundStyle(.white)
                    }
                }, backgroundLinearGradient: ApplicationLinearGradient.redGradient) {
                    withAnimation {
                        self.isSubmitButtonClicked = true
                    }
                }
                .padding(.top, 5)
                .transition(.blurReplace)
                
                
            }
            
            HStack {
                Text("Don't have an account?")
                    .font(.system(size: 15, weight: .regular))
                    .foregroundStyle(.white.opacity(0.5))
                
                Text("Sign Up")
                    .font(.system(size: 15, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)
                    .underline()
                    .padding(.vertical)
                    .onTapGesture {
                        withAnimation(.smooth(duration: 1)) {
                            self.currentSelectedRegistrationType = .SignUp
                        }
                    }
            }
            
            // MARK: Or something else
            
            HStack {
                CustomDivider()
                
                Text("Or")
                    .font(.system(size: 15, weight: .medium, design: .rounded))
                    .foregroundStyle(.white.opacity(0.5))
                
                CustomDivider()
            }
            .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
            
            
            // MARK: Other login options
            HStack {
                
                
                
                // MARK: Google
                HStack {
                    Image(ApplicationImages.googleIcon)
                        .resizable()
                        .frame(width: 25, height: 25)
                    
                    Text("Google")
                        .font(.system(size: 13, weight: .regular, design: .rounded))
                        .foregroundStyle(.white.opacity(0.75))
                }
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(ApplicationLinearGradient.darkBGSameGradientWithOpacityHalf)
                .overlay {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(.white.opacity(0.18))
                }
                .clipShape(RoundedRectangle(cornerRadius: 8))
                
                
                // MARK: Apple
                HStack {
                    Image(ApplicationImages.appleIcon)
                        .resizable()
                        .frame(width: 25, height: 25)
                    
                    
                    Text("Apple")
                        .font(.system(size: 13, weight: .regular, design: .rounded))
                        .foregroundStyle(.white.opacity(0.75))
                }
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(ApplicationLinearGradient.darkBGSameGradientWithOpacityHalf)
                .overlay {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(.white.opacity(0.18))
                }
                .clipShape(RoundedRectangle(cornerRadius: 8))
                
                
                // MARK: Github
                HStack {
                    Image(ApplicationImages.githubIcon)
                        .resizable()
                        .frame(width: 25, height: 25)
                    
                    Text("GitHub")
                        .font(.system(size: 13, weight: .regular, design: .rounded))
                        .foregroundStyle(.white.opacity(0.75))
                }
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(ApplicationLinearGradient.darkBGSameGradientWithOpacityHalf)
                .overlay {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(.white.opacity(0.18))
                }
                .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            .frame(maxWidth: .infinity)
            
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .safeAreaPadding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
        .safeAreaPadding(.top, 25)
        
        
    }
}





#Preview {
    LoginScreen(showLoginScreen: .constant(false), showIsland: .constant(false))
}




