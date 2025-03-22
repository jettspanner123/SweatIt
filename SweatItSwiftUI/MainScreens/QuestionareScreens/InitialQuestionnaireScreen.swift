//
//  InitialScreen.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 19/03/25.
//

import SwiftUI

struct InitialQuestionnaireScreen: View {
    
    enum QuestionPageScreens: String, CaseIterable {
        case intro = "Introduction", genderAge = "Gender & Age", heightWeight = "Height & Weight", bodyType = "Body Type", activityLevel = "Activity Level", foodType = "Food Type", fitnessLevel = "Fitness Level", goal = "Goal"
    }
    
    @State var currentSelectedPage: QuestionPageScreens = .bodyType
    @State var isMenuOpen: Bool = false
    @State var isNextButtonLoading: Bool = false
    @State var isPrevButtonLoading: Bool = false
    
    @State public static var userQuestionnaireStore: ApplicationConstants.SignupStateObject = .init()
    @State public var currentSelectedSystem: Extras.MeasurenmentSystem = .metric
    
    @Environment(\.dismiss) var dissmis
    
    var pageChangeOptions: Array<QuestionPageScreens> = Array(QuestionPageScreens.allCases)
    
    var body: some View {
        ScreenBuilder {
            
            
            
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
            .zIndex(10)
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
                .zIndex(10)
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
                .zIndex(9)
                .transition(.blurReplace.combined(with: .offset(y: UIScreen.main.bounds.height)))
                
            }
            
            
            
            
            
            // MARK: Circles for the transition duh....
            Circle()
                .fill(.appBlueLight)
                .frame(width: self.isMenuOpen ? 400 : 0, height: self.isMenuOpen ? 400 : 0)
                .position(x: self.isMenuOpen ? 100 : -100, y: self.isMenuOpen ? 200 : -200)
                .animation(.spring(response: 0.9, dampingFraction: 1, blendDuration: 0.1).delay(0.1), value: self.isMenuOpen)
                .zIndex(8)
            
            Circle()
                .fill(.appBlueLight)
                .frame(width: self.isMenuOpen ? 400 : 0, height: self.isMenuOpen ? 400 : 0)
                .position(x: self.isMenuOpen ? 300 : 700, y: self.isMenuOpen ? 200 : -200)
                .animation(.spring(response: 0.9, dampingFraction: 1, blendDuration: 0.1).delay(0.2), value: self.isMenuOpen)
                .zIndex(8)
            
            Circle()
                .fill(.appBlueLight)
                .frame(width: self.isMenuOpen ? 500 : 0, height: self.isMenuOpen ? 500 : 0)
                .position(x: UIScreen.main.bounds.width / 2, y: self.isMenuOpen ? -100 : -500)
                .animation(.spring(response: 0.9, dampingFraction: 1, blendDuration: 0.1).delay(0.3), value: self.isMenuOpen)
                .zIndex(8)
            
            Circle()
                .fill(.appBlueLight)
                .frame(width: self.isMenuOpen ? 500 : 0, height: self.isMenuOpen ? 500 : 0)
                .position(x: self.isMenuOpen ? UIScreen.main.bounds.width / 2 : UIScreen.main.bounds.width + 200, y: UIScreen.main.bounds.height / 2)
                .animation(.spring(response: 0.9, dampingFraction: 1, blendDuration: 0.1).delay(0.2), value: self.isMenuOpen)
                .zIndex(8)
            
            Circle()
                .fill(.appBlueLight)
                .frame(width: self.isMenuOpen ? 500 : 0, height: self.isMenuOpen ? 500 : 0)
                .position(x: UIScreen.main.bounds.width / 2 , y: self.isMenuOpen ? UIScreen.main.bounds.height - 200 : UIScreen.main.bounds.height + 200)
                .animation(.spring(response: 0.9, dampingFraction: 1, blendDuration: 0.1).delay(0.3), value: self.isMenuOpen)
                .zIndex(8)
            
            
            
            
            
            
            
            // MARK: Conditional rendering for the pages
            if self.currentSelectedPage == .intro {
                IntroductionQuestionnaireScreen(currentSelectedPage: self.$currentSelectedPage)
//                    .transition(.offset(y: UIScreen.main.bounds.height).combined(with: .blurReplace))
                    .transition(.offset(y: UIScreen.main.bounds.height).combined(with: .blurReplace.combined(with: .scale)))
            } else if self.currentSelectedPage == .genderAge {
                GenderAgeQuestionnaireScreen(currentSelectedPage: self.$currentSelectedPage)
                    .transition(.offset(y: UIScreen.main.bounds.height).combined(with: .blurReplace.combined(with: .scale)))
            } else if self.currentSelectedPage == .heightWeight {
                HeightQuestionnaireScreen(currentSelectedSystem: self.$currentSelectedSystem)
                    .transition(.offset(y: UIScreen.main.bounds.height).combined(with: .blurReplace.combined(with: .scale)))
            } else if self.currentSelectedPage == .bodyType {
                BodyTypeQuestionnaireScreen()
                    .transition(.offset(y: UIScreen.main.bounds.height).combined(with: .blurReplace.combined(with: .scale)))
            } else if self.currentSelectedPage == .activityLevel {
                
            } else if self.currentSelectedPage == .foodType {
                
            } else if self.currentSelectedPage == .fitnessLevel {
                
            } else {
                
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
                        withAnimation(.smooth(duration: 0.75)) {
                            self.isNextButtonLoading = true
                            
                            switch self.currentSelectedPage {
                            case .intro:
                                self.currentSelectedPage = .genderAge
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
                }
                
                
            }
            .offset(y: UIScreen.main.bounds.height - (45 * 3))
            .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
        }
        .sensoryFeedback(.impact, trigger: self.currentSelectedPage)
        .sensoryFeedback(.impact, trigger: self.currentSelectedSystem)

        
    }
}

#Preview {
    InitialQuestionnaireScreen()
}
