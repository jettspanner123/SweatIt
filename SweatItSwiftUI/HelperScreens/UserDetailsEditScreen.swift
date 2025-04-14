//
//  UserDetailsEditScreen.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 12/04/25.
//

import SwiftUI

struct UserDetailsEditScreen: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State var currentUser = User.current.currentUser
    
    @State var isGenderDropDownOpen: Bool = false
    
    @State var userStructChanged: Bool = false
    @State var backButtonPressed: Bool = false
    
    
    var body: some View {
        ScreenBuilder {
            
            
            
            
            // MARK: Dialog box
            if self.backButtonPressed {
                DialogBox {
                    Text("Unsaved Changes! 🥺")
                        .bottomDialogBoxHeading()
                    
                    Text("Are you sure you want to leave?")
                        .bottomDialogBoxSubHeading()
                    
                    Text("The changes that you just made, are not saved yet. If you leave now, they will be lost.")
                        .bottomDialogBoxBodyText()
                    
                    HStack {
                        SimpleButton(content: {
                           Text("Stay")
                                .font(.system(size: 13, weight: .medium, design: .rounded))
                                .foregroundStyle(.white)
                        }, backgroundLinearGradient: ApplicationLinearGradient.redGradient, some: {
                            withAnimation {
                                self.backButtonPressed = false
                            }
                        })
                        
                        SimpleButton(content: {
                           Text("Leave")
                                .font(.system(size: 13, weight: .medium, design: .rounded))
                                .foregroundStyle(.white)
                        }, backgroundLinearGradient: ApplicationLinearGradient.thanosGradient, some: {
                            withAnimation {
                                self.backButtonPressed = false
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                self.dismiss()
                            }
                        })
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.top)
                }
            }
            
            
            
            // MARK: Backdrop
            if self.backButtonPressed {
                CustomBackDrop()
            }
            
            
            
            
            AccentPageHeader_NoAction(pageHeaderTitle: "Edit Details") {
                if self.userStructChanged {
                    withAnimation {
                        self.backButtonPressed = true
                    }
                } else {
                    self.dismiss()
                }
            }
            
            
            
            // MARK: Bottom blur and button
            if self.userStructChanged {
                
                BottomBlur()
                    .toBottom()
                    .transition(.offset(y: 500))
                
                ZStack {
//                    
//                    SimpleButton(content: {
//                       
//                    }, backgroundLinearGradient: ApplicationLinearGradient.redGradient, some: {
//                        withAnimation {
//                            
//                        }
//                    })
//                    .isBottomButton()
                    
                    LoadingButton(isLoading: PostMethodStore.current.isDatabaseLoading, backgroundGradient: ApplicationLinearGradient.redGradient) {
                        User.current.currentUser = self.currentUser
                        withAnimation {
                            self.userStructChanged = false
                        }
                    }
                    .isBottomButton()
                }
                .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .zIndex(9999)
                .transition(.offset(y: UIScreen.main.bounds.height))
            }
            
            
            
            ScrollContentView {
                
                
                // MARK: Username
                SectionHeader(text: "Username")
                    .padding(.top, 5)
                
                CustomTextField(searchText: self.$currentUser.username, placeholder: "Cannot be empty")
                    .isEditable()
                
                
                // MARK: Full name
                SectionHeader(text: "Full Name")
                    .padding(.top, 15)
                
                CustomTextField(searchText: self.$currentUser.fullName, placeholder: "Cannot be empty")
                    .isEditable()
                
                
                // MARK: EMail id
                 SectionHeader(text: "Email Id")
                    .padding(.top, 5)
                
                CustomTextField(searchText: self.$currentUser.emailId, placeholder: "Cannot be empty")
                    .isEditable()
                
                
                
                // MARK: Gender
                SectionHeader(text: "Gender")
                    .padding(.top, 15)
                
                CustomDropdown(imageName: "person.fill", showValue: self.currentUser.gender.rawValue) {
                    VStack {
                        ForEach(Extras.Gender.allCases, id: \.self) { gender in
                            if gender == .none {
                                
                            } else {
                                Text(gender.rawValue)
                                    .font(.system(size: 15, weight: .regular, design: .rounded))
                                    .foregroundStyle(.white)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 35)
                                    .background(self.currentUser.gender == gender ? ApplicationLinearGradient.blueGradientInverted : ApplicationLinearGradient.whiteSameGradientWithOpacityPoint8)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                    .onTapGesture {
                                        withAnimation {
                                            self.currentUser.gender = gender
                                        }
                                    }
                            }
                            
                        }
                    }
                    .padding(.bottom)
                    .transition(.offset(y: UIScreen.main.bounds.height / 3).combined(with: .blurReplace))
                }
                
                
                
                
                
                
                
                
                // MARK: Height
                SectionHeader(text: "Height")
                    .overlay(alignment: .trailing) {
                        Text(String(format: "%.f cm", self.currentUser.currentHeight))
                            .font(.system(size: 12, weight: .regular, design: .rounded))
                            .foregroundStyle(.white.opacity(0.5))
                            .contentTransition(.numericText(value: self.currentUser.currentHeight))
                            .animation(.snappy, value: self.currentUser.currentHeight)
                    }
                    .padding(.top, 15)
                
                VStack {
                    Slider(value: self.$currentUser.currentHeight, in: 147...270)
                        .padding(.horizontal, 5)
                    
                    CustomPrecisionStepper(value: self.$currentUser.currentHeight)
                }
                .padding(15)
                .background(.darkBG.opacity(0.54))
                .overlay {
                    defaultShape
                        .stroke(.white.opacity(0.18))
                }
                .clipShape(defaultShape)
                
                
                
                
                
                
                
                
                // MARK: Weight
                SectionHeader(text: "Weight")
                    .overlay(alignment: .trailing) {
                        Text(String(format: "%.f kg", self.currentUser.currentWeight))
                            .font(.system(size: 12, weight: .regular, design: .rounded))
                            .foregroundStyle(.white.opacity(0.5))
                            .contentTransition(.numericText(value: self.currentUser.currentWeight))
                            .animation(.snappy, value: self.currentUser.currentWeight)
                    }
                    .padding(.top, 15)
                
                VStack {
                    Slider(value: self.$currentUser.currentWeight, in: 40...700)
                        .padding(.horizontal, 5)
                    
                    CustomPrecisionStepper(value: self.$currentUser.currentWeight)
                }
                .padding(15)
                .background(.darkBG.opacity(0.54))
                .overlay {
                    defaultShape
                        .stroke(.white.opacity(0.18))
                }
                .clipShape(defaultShape)
                
                
                
                
                
                // MARK: Body Type
                
                SectionHeader(text: "Body Type")
                    .padding(.top, 15)
                
                CustomDropdown(imageName: "figure.mind.and.body", showValue: self.currentUser.bodyType.rawValue) {
                    VStack {
                        ForEach(Extras.BodyType.allCases, id: \.self) { bodyType in
                            if bodyType != .none {
                                
                                Text(bodyType.rawValue)
                                    .dropDownItem()
                                    .background(self.currentUser.bodyType == bodyType ? ApplicationLinearGradient.blueGradientInverted : ApplicationLinearGradient.darkBGSameGradientWithOpacityHalf, in: RoundedRectangle(cornerRadius: 8))
                                    .onTapGesture {
                                        withAnimation {
                                            self.currentUser.bodyType = bodyType
                                        }
                                    }
                            }
                            
                        }
                    }
                    .padding(.bottom)
                    .transition(.offset(y: UIScreen.main.bounds.height / 3).combined(with: .blurReplace))
                }
                
                
                // MARK: Level
                SectionHeader(text: "Level")
                    .padding(.top, 15)
                CustomDropdown(imageName: "level", showValue: self.currentUser.level.rawValue) {
                    VStack {
                        ForEach(Extras.UserLevel.allCases, id: \.self) { level in
                            if level != .none {
                                
                                Text(level.rawValue)
                                    .dropDownItem()
                                    .background(self.currentUser.level == level ? ApplicationLinearGradient.blueGradientInverted : ApplicationLinearGradient.darkBGSameGradientWithOpacityHalf, in: RoundedRectangle(cornerRadius: 8))
                                    .onTapGesture {
                                        withAnimation {
                                            self.currentUser.level = level
                                        }
                                    }
                            }
                            
                        }
                    }
                    .padding(.bottom)
                    .transition(.offset(y: UIScreen.main.bounds.height / 3).combined(with: .blurReplace))
                }
                
                
                // MARK: Goal
                SectionHeader(text: "Goal")
                    .padding(.top, 15)
                CustomDropdown(imageName: "flag.fill", showValue: self.currentUser.goal.rawValue) {
                    VStack {
                        ForEach(Extras.Goal.allCases, id: \.self) { goal in
                            if goal != .none && goal != .developer {
                                
                                Text(goal.rawValue)
                                    .dropDownItem()
                                    .background(self.currentUser.goal == goal ? ApplicationLinearGradient.blueGradientInverted : ApplicationLinearGradient.darkBGSameGradientWithOpacityHalf, in: RoundedRectangle(cornerRadius: 8))
                                    .onTapGesture {
                                        withAnimation {
                                            self.currentUser.goal = goal
                                        }
                                    }
                            }
                            
                        }
                    }
                    .padding(.bottom)
                    .transition(.offset(y: UIScreen.main.bounds.height / 3).combined(with: .blurReplace))
                }
                
            }
            .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
            
            
            
        }
        .sensoryFeedback(.impact, trigger: self.currentUser)
        .sensoryFeedback(.impact, trigger: self.currentUser)
        .onChange(of: self.currentUser) {
            withAnimation {
                self.userStructChanged = true
            }
        }
    }
}
