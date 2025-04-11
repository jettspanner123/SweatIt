//
//  GenderAgeQuestionnaireScreen.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 19/03/25.
//

import SwiftUI

struct GenderAgeQuestionnaireScreen: View {
    @EnvironmentObject var appStates: ApplicationStates
    @Binding var currentSelectedPage: InitialQuestionnaireScreen.QuestionPageScreens
    
    @State var currentSelectedGender: Extras.Gender = .male
    @State var gaynessSlider: Double = 0
    @State var isGenderSelectionDropdownShown: Bool = false
    @State var dob: Date = .now
    
    var body: some View {
        VStack {
           Text("Choose your gender based upon who you are and what is you identity as a person.")
                .font(.system(size: 13, weight: .regular, design: .rounded))
                .foregroundStyle(.white.opacity(0.5))
                .takeMaxWidthLeading()
                .multilineTextAlignment(.leading)
            
            SectionHeader(text: "Gender")
                .padding(.top, 25)
            
            
            
            
            // MARK: Gendder selection thing
            VStack(spacing: 15) {
                HStack {
                    Image(systemName: "person.fill")
                        .foregroundStyle(.white.opacity(0.5))
                        .frame(width: 20)
                    
                    Text(self.currentSelectedGender.rawValue)
                        .font(.system(size: 15, weight: .regular, design: .rounded))
                        .foregroundStyle(.white.opacity(0.5))
                    
                    Spacer()
                    
                    Image(systemName: "chevron.down")
                        .foregroundStyle(.white.opacity(0.5))
                        .scaleEffect(0.75)
                        .rotationEffect(.degrees(self.isGenderSelectionDropdownShown ? 180 : 0))
                }
                .padding(.vertical, self.isGenderSelectionDropdownShown ? 15 : 0)
                
                
                
                // MARK: Gender options
                if self.isGenderSelectionDropdownShown {
                    VStack {
                        ForEach(Extras.Gender.allCases, id: \.self) { gender in
                            if gender == .none {
                                
                            } else {
                                Text(gender.rawValue)
                                    .font(.system(size: 15, weight: .regular, design: .rounded))
                                    .foregroundStyle(.white)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 35)
                                    .background(self.currentSelectedGender == gender ? ApplicationLinearGradient.blueGradientInverted : ApplicationLinearGradient.whiteSameGradientWithOpacityPoint8)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                    .onTapGesture {
                                        withAnimation {
                                            self.currentSelectedGender = gender
                                            self.isGenderSelectionDropdownShown = false
                                        }
                                    }
                            }
                            
                        }
                    }
                    .padding(.bottom)
                    .transition(.offset(y: UIScreen.main.bounds.height / 3).combined(with: .blurReplace))
                    .animation(.smooth(duration: 1), value: self.isGenderSelectionDropdownShown)
                }
            }
            .applicationDropDownButton()
            .clipped()
            .onTapGesture {
                withAnimation {
                    self.isGenderSelectionDropdownShown.toggle()
                }
            }
            
             
            // MARK: If the user is gay
            if self.currentSelectedGender == .Others {
               
                VStack(spacing: 15) {
                    HStack {
                        Text("Tell us what level of gay you are.")
                            .font(.system(size: 15, weight: .regular, design: .rounded))
                            .foregroundStyle(.white.opacity(0.5))
                        
                        Spacer()
                        
                        if self.gaynessSlider > 55 || self.gaynessSlider < 45 {
                            Text(String(format: "%.f%%", self.gaynessSlider))
                                .font(.system(size: 15, weight: .bold, design: .rounded))
                                .foregroundStyle(.white)
                                .transition(.offset(x: 100).combined(with: .blurReplace))
                                .contentTransition(.numericText(value: self.gaynessSlider))
                                .animation(.snappy, value: self.gaynessSlider)
                        } else {
                            Text("Gay 🤡")
                                .font(.system(size: 15, weight: .bold, design: .rounded))
                                .foregroundStyle(.white)
                                .transition(.offset(x: 100).combined(with: .blurReplace))
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical, 15)
                   
                    Slider(value: self.$gaynessSlider, in: 0...100)
                        .tint(ApplicationLinearGradient.blueGradientInverted)
                    HStack {
                        Text("Male")
                            .font(.system(size: 15, weight: .regular, design: .rounded))
                            .foregroundStyle(.white)
                            .frame(width: 50)
                            .padding(8)
                            .background(.blue.gradient)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                        
                        HStack {
                            
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 2)
                        .background(.white.opacity(0.18))
                        
                        
                        Text("Female")
                            .font(.system(size: 15, weight: .regular, design: .rounded))
                            .foregroundStyle(.white)
                            .frame(width: 50)
                            .padding(8)
                            .background(.pink.gradient)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 15)
                    
                    
                    
                }
                .applicationDropDownButton()
                .transition(.offset(x: UIScreen.main.bounds.width).combined(with: .blurReplace))
            }
            
            
            // MARK: Age and dob selection thing
            HStack {
                Image(systemName: "calendar")
                    .foregroundStyle(.white.opacity(0.5))
                    .frame(width: 20)
                
                
                Text(ApplicationHelper.formatDateToHumanReadableWithoutTime(date: self.dob) + " (\(self.appStates.userData.age) yo)")
                    .font(.system(size: 15, weight: .regular, design: .rounded))
                    .foregroundStyle(.white.opacity(0.5))
                
                
                DatePicker("", selection: self.$dob, in: ...Date().addingTimeInterval(86400 * -ApplicationConstants.minimumUserAge * 365) ,displayedComponents: .date)
                    .datePickerStyle(.compact)
                    .tint(.appThanosLight)
            }
            .applicationDropDownButton()
            
        
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding(.vertical, ApplicationPadding.mainScreenVerticalPadding)
        .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
        .onChange(of: self.currentSelectedGender) {
            self.appStates.userData.gender = self.currentSelectedGender
        }
        .onChange(of: self.dob) {
            let age = Calendar.current.dateComponents([.year], from: self.dob, to: .now)
            self.appStates.userData.age = age.year!
        }
    }
}

