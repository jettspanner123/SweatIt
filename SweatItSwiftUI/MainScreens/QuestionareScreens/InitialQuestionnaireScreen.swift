//
//  InitialScreen.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 19/03/25.
//

import SwiftUI

struct InitialQuestionnaireScreen: View {
    
    @EnvironmentObject var appStates: ApplicationStates
    
    @Binding var showLoginScreen: Bool
    
    enum QuestionPageScreens: String, CaseIterable {
        case intro = "Introduction", genderAge = "Gender & Age", heightWeight = "Height & Weight", bodyType = "Body Type", activityLevel = "Activity Level", foodType = "Food Type", fitnessLevel = "Fitness Level", goal = "Goal"
    }
    
    @StateObject var annualIncomes = ApplicationConstants()
    
    @State var currentSelectedPage: QuestionPageScreens = .intro
    @State var isMenuOpen: Bool = false
    @State var isNextButtonLoading: Bool = false
    @State var isPrevButtonLoading: Bool = false
    
    @State public var currentSelectedSystem: Extras.MeasurenmentSystem = .metric
    
    @State var addAnnualIncomeCreateButtonClicked: Bool = false
    @State var showAddAnnualIncomeTopSheet: Bool = false
    @State var showAddAnnualIncomeTopSheetError: Bool = false
    @State var showAddAnnualINcomeTopSheetErrorDescription: String = "Please fill all the fields"
    
    @State var customRangeLowerBound: String = ""
    @State var customRangeUpperBound: String = ""
    
    @State var pageChangeTransition: Bool = false
    @State var saveChanges: Bool = false
    
    @State var showRegionSelectScreen: Bool = false
    @State var showAlergiesSelectScreen: Bool = false
    @State var selectedRegion: String = ""
    @State var selectedFoodAlergies: Array<Extras.FoodAllergy> = []
    
    
    @Environment(\.dismiss) var dissmis
    
    var pageChangeOptions: Array<QuestionPageScreens> = Array(QuestionPageScreens.allCases)
    
    
    var isEveryUserDetailsFilled: Bool {
        let userDetails = self.appStates.userData
        return !userDetails.username.isEmpty && !userDetails.password.isEmpty && userDetails.gender != .none && userDetails.height != .zero && userDetails.weight != .zero && userDetails.age != .zero && userDetails.bodyType != .none && userDetails.fitnessLevel != .none && !userDetails.region.isEmpty && userDetails.goalType != .none && userDetails.foodType != .none && !userDetails.activeDays.isEmpty && userDetails.activeHoursADay != .zero
    }
    
    
    func createNewUserAnnualIncome() -> Void {
        
        
        withAnimation {
            self.addAnnualIncomeCreateButtonClicked = true
        }
        
        if self.customRangeLowerBound.isEmpty || self.customRangeUpperBound.isEmpty {
            self.showAddAnnualINcomeTopSheetErrorDescription = "Please fill all the fields"
            withAnimation {
                self.showAddAnnualIncomeTopSheetError = true
                self.addAnnualIncomeCreateButtonClicked = false
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    self.showAddAnnualIncomeTopSheetError = false
                }
            }
            return
        }
        
        
        guard let lowerBound = Int(self.customRangeLowerBound), let upperBound = Int(self.customRangeUpperBound) else {
            self.showAddAnnualINcomeTopSheetErrorDescription = "Please enter valid annual income"
            withAnimation {
                self.showAddAnnualIncomeTopSheetError = true
                self.addAnnualIncomeCreateButtonClicked = false
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    self.showAddAnnualIncomeTopSheetError = false
                }
            }
            return
            
            
        }
        
        
        if lowerBound >= upperBound {
            self.showAddAnnualINcomeTopSheetErrorDescription = "Lower bound should be more than upper bound."
            withAnimation {
                self.showAddAnnualIncomeTopSheetError = true
                self.addAnnualIncomeCreateButtonClicked = false
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    self.showAddAnnualIncomeTopSheetError = false
                }
            }
            return
        }
        
        
        self.annualIncomes.annualIncoms.append(ClosedRange<Int>(uncheckedBounds: (lowerBound, upperBound)))
        ApplicationHelper.dismissKeyboard()
        withAnimation {
            self.showAddAnnualIncomeTopSheet = false
        }
        
    }
    
    
    func nextButtonAction() -> Void {
        withAnimation(.smooth(duration: 0.75)) {
            self.isNextButtonLoading = true
            
            switch self.currentSelectedPage {
            case .intro:
                if !self.appStates.isUsernameAvailable || self.appStates.userData.username.count < 8 {
                    self.appStates.showUsernameNotAvailable = true
                    return
                }
                

                if self.appStates.userData.password.isEmpty && self.appStates.confirmPassword.isEmpty {
                    self.currentSelectedPage = .genderAge
                    return
                } else {
                    if self.appStates.userData.password == self.appStates.confirmPassword {
                        self.currentSelectedPage = .genderAge
                    } else {
                        self.appStates.isPasswordAndConfirmPasswordMatching = true
                    }
                }
                
                if self.appStates.userData.phoneNumber.count < 10 {
                    self.appStates.showPhoneNumberWrong = true
                    return
                }
                
                
                
            case .genderAge:
                self.currentSelectedPage = .heightWeight
            case .heightWeight:
                self.currentSelectedPage = .bodyType
            case .bodyType:
                self.currentSelectedPage = .activityLevel
            case .activityLevel:
                self.currentSelectedPage = .foodType
            case .foodType:
                self.currentSelectedPage = .fitnessLevel
            case .fitnessLevel:
                self.currentSelectedPage = .goal
            case .goal:
                self.currentSelectedPage = .goal
            }
            
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            withAnimation {
                self.isNextButtonLoading = false
            }
        }
    }
    
    func previousButtonAction() -> Void {
        withAnimation(.smooth(duration: 0.75)) {
            self.isPrevButtonLoading = true
            switch self.currentSelectedPage {
                
            case .goal:
                self.currentSelectedPage = .fitnessLevel
            case .fitnessLevel:
                self.currentSelectedPage = .foodType
            case .foodType:
                self.currentSelectedPage = .activityLevel
            case .activityLevel:
                self.currentSelectedPage = .bodyType
            case .bodyType:
                self.currentSelectedPage = .heightWeight
            case .heightWeight:
                self.currentSelectedPage = .genderAge
            case .genderAge:
                self.currentSelectedPage = .intro
            case .intro:
                self.currentSelectedPage = .intro
                
            }
            
            
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            withAnimation {
                self.isPrevButtonLoading = false
            }
        }
    }
    
    func prepareSignUp() async throws -> Void {
        let userData = self.appStates.userData
        let tempUser_t: User_t = .init(fullName: userData.fullName, username: userData.username, emailId: userData.email, password: userData.password, currentWeight: userData.weight, currentHeight: userData.height, gender: userData.gender, bodyType: userData.bodyType, level: userData.fitnessLevel, goal: userData.goalType, dailyPoints: 0, fitnessLevel: 1)
        let extraInformation_t: ExtraInfo_t = .init(ofUserId: tempUser_t.id, age: userData.age, activeDaysAWeek: userData.activeDaysAWeek, activehoursADay: userData.activeHoursADay, activeDays: userData.activeDays, region: userData.region, foodType: userData.foodType, foodBudget: userData.foodBudged, alergies: userData.alergies, fitnessLevel: userData.fitnessLevel, goalType: userData.goalType, phontNumber: userData.phoneNumber, dateOfBirth: userData.dob)
        
        try await ApplicationEndpoints.post.createNewUser(with: tempUser_t, andInfo: extraInformation_t)
        
        
        withAnimation(.smooth(duration: 0.5)) {
            self.saveChanges = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.dissmis()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation(.smooth(duration: 1.5)) {
                self.showLoginScreen = true
            }
        }
    }
    
    
    var body: some View {
        NavigationStack {
            ScreenBuilder {
                
                if self.appStates.isPasswordAndConfirmPasswordMatching {
                    DialogBox {
                        Text("Password Do Not Match! 🥲")
                            .font(.custom(ApplicationFonts.oswaldRegular, size: 25))
                            .foregroundStyle(.white)
                            .takeMaxWidthLeading()
                        
                        Text("How did you even mess that up?")
                            .font(.system(size: 15, weight: .regular, design: .rounded))
                            .foregroundStyle(.white)
                            .takeMaxWidthLeading()
                            .padding(.top, 1)
                        
                        
                        Text("The password and confirm password fields must match in order to proceed. Please try again.")
                            .font(.system(size: 15, weight: .regular, design: .rounded))
                            .foregroundStyle(.white.opacity(0.5))
                            .takeMaxWidthLeading()
                        
                        SimpleButton(content: {
                            Text("I Understand")
                                .font(.system(size: 13, weight: .medium, design: .rounded))
                                .foregroundStyle(.white)
                        }, backgroundLinearGradient: ApplicationLinearGradient.thanosGradient, some: {
                            withAnimation {
                                self.appStates.isPasswordAndConfirmPasswordMatching = false
                            }
                        })
                        .padding(.top)
                        
                    }
                }
                
                if self.appStates.showUsernameNotAvailable {
                    DialogBox {
                        Text("Username Not Available! ❌")
                            .bottomDialogBoxHeading()
                        
                        Text("The Indicator Is Right Up There Bro! 🥲")
                            .bottomDialogBoxSubHeading()
                        
                        Text("The username that you are trying to aquire is already taken. Please try again!")
                            .bottomDialogBoxBodyText()
                        
                        SimpleButton(content: {
                           Text("I Understand")
                                .font(.system(size: 13, weight: .medium, design: .rounded))
                                .foregroundStyle(.white)
                        }, backgroundLinearGradient: ApplicationLinearGradient.thanosGradient, some: {
                            withAnimation {
                                self.appStates.showUsernameNotAvailable = false
                            }
                        })
                        .padding(.top)
                    }
                }
                
                if self.appStates.isPasswordAndConfirmPasswordMatching || self.appStates.showUsernameNotAvailable {
                    CustomBackDrop()
                }
                
                
                // MARK: Region page
                if self.showRegionSelectScreen {
                    SelectRegionScreen(selectedRegion: self.$selectedRegion, showSelectRegionScreen: self.$showRegionSelectScreen)
                        .zIndex(.infinity)
                        .transition(.offset(y: UIScreen.main.bounds.height))
                }
                
                
                
                
                // MARK: Alergies page
                if self.showAlergiesSelectScreen {
                    SelectAlergiesScreen(selectedAlergies: self.$selectedFoodAlergies, showAlergiesSelectScreen: self.$showAlergiesSelectScreen)
                        .zIndex(.infinity)
                        .transition(.offset(y: UIScreen.main.bounds.height))
                }
                
                // MARK: Finish button
                if self.currentSelectedPage == .goal {
                    
                    HStack {
                        if self.pageChangeTransition {
                            if !self.saveChanges {
                                VStack {
                                    
                                    Image(systemName: "exclamationmark.triangle.fill")
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                        .foregroundStyle(.white)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                    Text("Want to save the changes?")
                                        .font(.system(size: 18, weight: .medium, design: .rounded))
                                        .foregroundStyle(.white)
                                        .takeMaxWidthLeading()
                                        .padding(.top, 25)
                                    
                                    
                                    Text("The changes you made throughout the questionnaire will now be saved to the database. Please review your entries carefully, as this data is essential for the app's proper functionality. You can always update your settings within the app if needed.")
                                        .font(.system(size: 13, weight: .light, design: .rounded))
                                        .foregroundStyle(.white)
                                        .padding(.top, 1)
                                    
                                    
                                    if self.isEveryUserDetailsFilled {
                                        Text("Save")
                                            .font(.system(size: 15, weight: .medium, design: .rounded))
                                            .foregroundStyle(ApplicationLinearGradient.redGradient)
                                            .frame(maxWidth: .infinity)
                                            .frame(height: 40)
                                            .background(.white)
                                            .clipShape(RoundedRectangle(cornerRadius: 8))
                                            .padding(.top, 25)
                                            .onTapGesture {
                                                Task {
                                                    try await self.prepareSignUp()
                                                }
                                            }
                                    } else {
                                        HStack {
                                            Text("Please complete the questionnaire.")
                                                .font(.system(size: 15, weight: .medium, design: .rounded))
                                                .foregroundStyle(ApplicationLinearGradient.redGradient)
                                            
                                            Image(systemName: "exclamationmark.lock.fill")
                                                .foregroundStyle(.white)
                                        }
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 40)
                                        .background(.white)
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                        .padding(.top, 25)
                                        
                                    }
                                    
                                    
                                    Text("Make Changes")
                                        .font(.system(size: 15, weight: .medium, design: .rounded))
                                        .foregroundStyle(.white)
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 40)
                                        .background(.white.opacity(0.18))
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 8)
                                                .stroke(.white.opacity(0.25))
                                        }
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                        .onTapGesture {
                                            withAnimation(.smooth(duration: 0.5)) {
                                                self.pageChangeTransition = false
                                                
                                            }
                                            
                                        }
                                }
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
                                .padding(.vertical, ApplicationPadding.mainScreenVerticalPadding * 2)
                                .transition(.offset(y: -UIScreen.main.bounds.height).combined(with: .blurReplace))
                            }
                        } else {
                            Text("Finish")
                                .font(.system(size: 15, weight: .medium, design: .rounded))
                                .foregroundStyle(.white)
                                .transition(.blurReplace)
                                .frame(maxWidth: .infinity)
                        }
                    }
                    .frame(maxWidth: self.pageChangeTransition ? UIScreen.main.bounds.width : UIScreen.main.bounds.width - (30))
                    .frame(height: self.pageChangeTransition ? UIScreen.main.bounds.height : 42)
                    .background(ApplicationLinearGradient.redGradient)
                    .clipShape(defaultShape)
                    .offset(y: self.pageChangeTransition ? 0 : UIScreen.main.bounds.height - (45 * 3))
                    .zIndex(self.pageChangeTransition ? .infinity : 10)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation(.smooth(duration: 0.5)) {
                            self.pageChangeTransition = true
                        }
                    }
                    
                }
                
                if self.showAddAnnualIncomeTopSheet && self.currentSelectedPage == .foodType {
                    
                    
                    
                    
                    // MARK: Backdrop
                    DarkBackdrop {
                        
                    }
                    .zIndex(20)
                    .transition(.opacity)
                    .onTapGesture {
                        withAnimation {
                            self.showAddAnnualIncomeTopSheet = false
                        }
                        ApplicationHelper.dismissKeyboard()
                    }
                    
                    
                    
                    
                    // MARK: Actual content
                    VStack {
                        VStack {
                            
                            Spacer()
                                .frame(maxWidth: .infinity)
                                .frame(height: 75)
                            
                            SectionHeader(text: "Enter Range")
                            
                            
                            
                            
                            
                            
                            // MARK: Lower and upper bounds
                            HStack {
                                CustomTextField(searchText: self.$customRangeLowerBound, placeholder: "Lower Bound")
                                CustomTextField(searchText: self.$customRangeUpperBound, placeholder: "Upper Bound")
                            }
                            .frame(maxWidth: .infinity)
                            
                            
                            
                            
                            // MARK: Error
                            if self.showAddAnnualIncomeTopSheetError {
                                Text(self.showAddAnnualINcomeTopSheetErrorDescription)
                                    .font(.system(size: 13, weight: .regular, design: .rounded))
                                    .foregroundStyle(ApplicationLinearGradient.redGradient)
                                    .padding(.top)
                                    .transition(.blurReplace)
                            }
                            
                            
                            
                            
                            
                            // MARK: Create button
                            HStack {
                                
                                if self.addAnnualIncomeCreateButtonClicked {
                                    ProgressView()
                                        .tint(.white)
                                        .frame(maxWidth: .infinity)
                                } else {
                                    Text("Create Range")
                                        .font(.system(size: 15, weight: .medium, design: .rounded))
                                        .foregroundStyle(.white)
                                        .frame(maxWidth: .infinity)
                                }
                            }
                            .applicationDropDownButton(ApplicationLinearGradient.redGradient)
                            .onTapGesture {
                                self.createNewUserAnnualIncome()
                            }
                        }
                        .frame(maxWidth: .infinity, minHeight: 200, alignment: .bottom)
                        .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
                        .padding(.bottom, 25)
                        .background(.darkBG)
                        .clipShape(UnevenRoundedRectangle(cornerRadii: .init(bottomLeading: 17, bottomTrailing: 17)))
                        .offset(y: -75)
                        
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                    .zIndex(25)
                    .transition(.offset(y: -300).combined(with: .blurReplace))
                    
                }
                
                if !self.isMenuOpen{
                    HStack {
                        
                        
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 130)
                    .background(AppBackgroundBlur(radius: 10, opaque: false))
                    .padding(.top, -15)
                    .padding(.bottom, 15)
                    .ignoresSafeArea()
                    .zIndex(9)
                    
                    
                    HStack {
                        
                        
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 80)
                    .background(AppBackgroundBlur(radius: 10, opaque: false))
                    .padding(.bottom, -15)
                    .padding(.top, 15)
                    .ignoresSafeArea()
                    .zIndex(8)
                    .offset(y: UIScreen.main.bounds.height - 120)
                }
                
                
                // MARK: Hamburger menu button
                HStack {
                    Image(systemName: self.isMenuOpen ? "xmark" : "ellipsis")
                        .foregroundStyle(self.isMenuOpen ? .black : .white)
                        .contentTransition(.symbolEffect)
                }
                .frame(width: 40, height: 40)
                .background(self.isMenuOpen ? .white : .white.opacity(0.18))
                .clipShape(Circle())
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
                .padding(.top, 15)
                .onTapGesture {
                    withAnimation(.spring(duration: 1)) {
                        self.isMenuOpen.toggle()
                    }
                }
                .zIndex(15)
                .overlay {
                    if !self.isMenuOpen {
                        HStack {
                            Image(systemName: "xmark")
                                .foregroundStyle(.white)
                        }
                        .frame(width: 40, height: 40)
                        .background(.white.opacity(0.18))
                        .clipShape(Circle())
                        .padding(.top, 15)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
                        .transition(.blurReplace.combined(with: .offset(x: 50)))
                        .onTapGesture {
                            self.dissmis()
                        }
                    }
                    
                    if !self.isMenuOpen {
                        HStack {
                            Text(self.currentSelectedPage.rawValue)
                                .font(.system(size: 25, weight: .light, design: .rounded))
                                .foregroundStyle(.white)
                                .padding(.top)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .transition(.blurReplace.combined(with: .scale))
                    }
                    
                }
                
                
                
                // MARK: Actual menu
                if self.isMenuOpen {
                    
                    
                    
                    // MARK: Menu heading
                    HStack {
                        Text("Menu")
                            .font(.system(size: 25, weight: .light, design: .rounded))
                            .foregroundStyle(.white)
                    }
                    .padding(.top, 25)
                    .zIndex(.infinity)
                    .transition(.blurReplace.combined(with: .offset(y: -100)))
                    
                    
                    
                    // MARK: Each menu item text
                    
                    VStack {
                        
                        
                        ForEach(self.pageChangeOptions.indices, id: \.self) { pageIndex in
                            Text(self.pageChangeOptions[pageIndex].rawValue)
                                .font(.system(size: 15, weight: .regular, design: .rounded))
                                .foregroundStyle(self.currentSelectedPage == self.pageChangeOptions[pageIndex] ? .black : .white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 13)
                                .background(self.currentSelectedPage == self.pageChangeOptions[pageIndex] ? .white : .white.opacity(0.18))
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                .overlay {
                                    HStack {
                                        if !self.appStates.userData.password.isEmpty && !self.appStates.userData.username.isEmpty && !self.appStates.userData.phoneNumber.isEmpty && !self.appStates.userData.email.isEmpty && !self.appStates.confirmPassword.isEmpty {
                                            Image(systemName: "checkmark.seal.fill")
                                        }
                                    }
                                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
                                    .padding(.horizontal)
                                }
                                .onTapGesture {
                                    self.currentSelectedPage = self.pageChangeOptions[pageIndex]
                                    withAnimation(.spring(duration: 1).delay(0.15)) {
                                        self.isMenuOpen = false
                                    }
                                }
                        }
                        
                        SectionHeader(text: "Measurement System")
                            .padding(.top, 25)
                        HStack {
                            Text("Metric")
                                .font(.system(size: 15, weight: .regular, design: .rounded))
                                .foregroundStyle(self.currentSelectedSystem == .metric ? .black : .white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 13)
                                .background(self.currentSelectedSystem == .metric ? .white : .white.opacity(0.18))
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                .onTapGesture {
                                    withAnimation {
                                        self.currentSelectedSystem = .metric
                                    }
                                }
                            
                            Text("Imperial")
                                .font(.system(size: 15, weight: .regular, design: .rounded))
                                .foregroundStyle(self.currentSelectedSystem == .imperial ? .black : .white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 13)
                                .background(self.currentSelectedSystem == .imperial ? .white : .white.opacity(0.18))
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                .onTapGesture {
                                    withAnimation {
                                        self.currentSelectedSystem = .imperial
                                    }
                                }
                        }
                        
                        .frame(maxWidth: .infinity)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                    .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
                    .padding(.top, ApplicationPadding.mainScreenVerticalPadding)
                    .zIndex(.infinity)
                    .transition(.blurReplace.combined(with: .offset(y: UIScreen.main.bounds.height)))
                    
                }
                
                
                
                
                
                // MARK: Circles for the transition duh....
                Circle()
                    .fill(.appBlueLight)
                    .frame(width: self.isMenuOpen ? 400 : 0, height: self.isMenuOpen ? 400 : 0)
                    .position(x: self.isMenuOpen ? 100 : -100, y: self.isMenuOpen ? 200 : -200)
                    .animation(.spring(response: 0.9, dampingFraction: 1, blendDuration: 0.1).delay(0.1), value: self.isMenuOpen)
                    .zIndex(12)
                
                Circle()
                    .fill(.appBlueLight)
                    .frame(width: self.isMenuOpen ? 400 : 0, height: self.isMenuOpen ? 400 : 0)
                    .position(x: self.isMenuOpen ? 300 : 700, y: self.isMenuOpen ? 200 : -200)
                    .animation(.spring(response: 0.9, dampingFraction: 1, blendDuration: 0.1).delay(0.2), value: self.isMenuOpen)
                    .zIndex(12)
                
                Circle()
                    .fill(.appBlueLight)
                    .frame(width: self.isMenuOpen ? 500 : 0, height: self.isMenuOpen ? 500 : 0)
                    .position(x: UIScreen.main.bounds.width / 2, y: self.isMenuOpen ? -100 : -500)
                    .animation(.spring(response: 0.9, dampingFraction: 1, blendDuration: 0.1).delay(0.3), value: self.isMenuOpen)
                    .zIndex(12)
                
                Circle()
                    .fill(.appBlueLight)
                    .frame(width: self.isMenuOpen ? 500 : 0, height: self.isMenuOpen ? 500 : 0)
                    .position(x: self.isMenuOpen ? UIScreen.main.bounds.width / 2 : UIScreen.main.bounds.width + 200, y: UIScreen.main.bounds.height / 2)
                    .animation(.spring(response: 0.9, dampingFraction: 1, blendDuration: 0.1).delay(0.2), value: self.isMenuOpen)
                    .zIndex(12)
                
                Circle()
                    .fill(.appBlueLight)
                    .frame(width: self.isMenuOpen ? 500 : 0, height: self.isMenuOpen ? 500 : 0)
                    .position(x: UIScreen.main.bounds.width / 2 , y: self.isMenuOpen ? UIScreen.main.bounds.height - 200 : UIScreen.main.bounds.height + 200)
                    .animation(.spring(response: 0.9, dampingFraction: 1, blendDuration: 0.1).delay(0.3), value: self.isMenuOpen)
                    .zIndex(12)
                
                
                
                
                
                
                
                // MARK: Conditional rendering for the pages
                if self.currentSelectedPage == .intro {
                    IntroductionQuestionnaireScreen(currentSelectedPage: self.$currentSelectedPage)
                        .transition(.blurReplace)
                } else if self.currentSelectedPage == .genderAge {
                    GenderAgeQuestionnaireScreen(currentSelectedPage: self.$currentSelectedPage)
                        .transition(.blurReplace)
                } else if self.currentSelectedPage == .heightWeight {
                    HeightQuestionnaireScreen(currentSelectedSystem: self.$currentSelectedSystem)
                        .transition(.blurReplace)
                } else if self.currentSelectedPage == .bodyType {
                    BodyTypeQuestionnaireScreen()
                        .transition(.blurReplace)
                } else if self.currentSelectedPage == .activityLevel {
                    ActivityQuestionnaireScreen()
                        .transition(.blurReplace)
                } else if self.currentSelectedPage == .foodType {
                    FoodTypeQuestionnaireScreen(showAddAnnualIncomeTopSheet: self.$showAddAnnualIncomeTopSheet, showSelectRegionScreen: self.$showRegionSelectScreen, showSelectAlergiesScreen: self.$showAlergiesSelectScreen, selectedFoodAlergies: self.$selectedFoodAlergies, selectedRegion: self.$selectedRegion)
                        .transition(.blurReplace)
                } else if self.currentSelectedPage == .fitnessLevel {
                    FitnessLevelQuestionnaireScreen()
                        .transition(.blurReplace)
                } else {
                    GoalQuestionnaireScreen()
                        .transition(.blurReplace)
                }
                
                
                
                
                // MARK: Bottom twin button
                HStack {
                    
                    
                    
                    // MARK: Previous button
                    if self.currentSelectedPage != .intro {
                        HStack {
                            if self.isPrevButtonLoading {
                                ProgressView()
                                    .tint(.white)
                                    .transition(.blurReplace)
                            } else {
                                Text("Prev")
                                    .font(.system(size: 15, weight: .medium, design: .rounded))
                                    .foregroundStyle(.white)
                                    .transition(.blurReplace)
                            }
                            
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 45)
                        .background(ApplicationLinearGradient.thanosGradient)
                        .clipShape(defaultShape)
                        .overlay {
                            HStack {
                                
                                HStack {
                                    
                                    Image(systemName: "chevron.left")
                                        .scaleEffect(0.75)
                                        .foregroundStyle(.white)
                                }
                                .frame(width: 30, height: 30)
                                .background(.darkBG.opacity(0.25))
                                .clipShape(Circle())
                                .padding(.vertical, 15)
                                
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
                        }
                        .onTapGesture {
                            self.previousButtonAction()
                        }
                    }
                    
                    
                    
                    
                    
                    
                    // MARK: Next button
                    if self.currentSelectedPage != .goal {
                        HStack {
                            if self.isNextButtonLoading {
                                ProgressView()
                                    .tint(.white)
                                    .transition(.blurReplace)
                            } else {
                                Text("Next")
                                    .font(.system(size: 15, weight: .medium, design: .rounded))
                                    .foregroundStyle(.white)
                                    .transition(.blurReplace)
                                    .frame(maxWidth: .infinity)
                                    .overlay {
                                        HStack {
                                            
                                            HStack {
                                                
                                                Image(systemName: "chevron.right")
                                                    .scaleEffect(0.75)
                                                    .foregroundStyle(.white)
                                            }
                                            .frame(width: 30, height: 30)
                                            .background(.darkBG.opacity(0.25))
                                            .clipShape(Circle())
                                            .padding(.vertical, 15)
                                            
                                        }
                                        .frame(maxWidth: .infinity, alignment: .trailing)
                                        .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
                                    }
                            }
                            
                        }
                        .buttonConfiguration(ApplicationLinearGradient.redGradient)
                        .onTapGesture {
                            self.nextButtonAction()
                        }
                    }
                    
                }
                .zIndex(11)
                .offset(y: UIScreen.main.bounds.height - (45 * 3))
                .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
            }
            .sensoryFeedback(.impact, trigger: self.currentSelectedPage)
            .sensoryFeedback(.impact, trigger: self.currentSelectedSystem)
            .sensoryFeedback(.impact, trigger: self.isMenuOpen)
        }
    }
}

struct InitialQuestionnaireScreen_Preview: PreviewProvider {
    
    static let appStates: ApplicationStates = .init()
    
    static var previews: some View {
        InitialQuestionnaireScreen(showLoginScreen: .constant(false))
            .environmentObject(self.appStates)
    }
}
