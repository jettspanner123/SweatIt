//
//  InitialScreen.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 19/03/25.
//

import SwiftUI

struct InitialQuestionnaireScreen: View {
    
    enum QuestionPageScreens: String, CaseIterable {
        case intro, genderAge, height, weight, bodyType, activityLevel, foodType, fitnessLevel, goal
    }
    
    @State var currentSelectedPage: QuestionPageScreens = .intro
    @State var isMenuOpen: Bool = false
    
    func randomDelay() -> Double {
        return Double.random(in: 0.1...0.5)
    }
    
    
    var body: some View {
        ScreenBuilder {
            
            
            
            // MARK: Hamburger menu button
            HStack {
                Image(systemName: "ellipsis")
                    .foregroundStyle(.white)
            }
            .frame(width: 50, height: 50)
            .background(.white.opacity(0.18))
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
            
            
            
            // MARK: Actual menu
            
            if self.isMenuOpen {
                VStack {
                    Text("Hello world my name is uddeshy isngh")
                        .foregroundStyle(.white)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .zIndex(9)
                .transition(.blurReplace.combined(with: .offset(x: -UIScreen.main.bounds.width / 2)))
                
            }
            
            
            
            
            
            // MARK: Circles for the transition duh....
            Circle()
                .fill(.appBlueLight)
                .frame(width: self.isMenuOpen ? 400 : 0, height: self.isMenuOpen ? 400 : 0)
                .position(x: 100, y: 200)
                .animation(.spring(response: 0.9, dampingFraction: 1, blendDuration: 0.1).delay(0.1), value: self.isMenuOpen)
            
            Circle()
                .fill(.appBlueLight)
                .frame(width: self.isMenuOpen ? 400 : 0, height: self.isMenuOpen ? 400 : 0)
                .position(x: 300, y: 200)
                .animation(.spring(response: 0.9, dampingFraction: 1, blendDuration: 0.1).delay(0.2), value: self.isMenuOpen)
            
            Circle()
                .fill(.appBlueLight)
                .frame(width: self.isMenuOpen ? 500 : 0, height: self.isMenuOpen ? 500 : 0)
                .position(x: UIScreen.main.bounds.width / 2, y: -100)
                .animation(.spring(response: 0.9, dampingFraction: 1, blendDuration: 0.1).delay(0.3), value: self.isMenuOpen)
            
            Circle()
                .fill(.appBlueLight)
                .frame(width: self.isMenuOpen ? 500 : 0, height: self.isMenuOpen ? 500 : 0)
                .position(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2)
                .animation(.spring(response: 0.9, dampingFraction: 1, blendDuration: 0.1).delay(0.2), value: self.isMenuOpen)
            
            Circle()
                .fill(.appBlueLight)
                .frame(width: self.isMenuOpen ? 500 : 0, height: self.isMenuOpen ? 500 : 0)
                .position(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height - 200)
                .animation(.spring(response: 0.9, dampingFraction: 1, blendDuration: 0.1).delay(0.3), value: self.isMenuOpen)
            
            if self.currentSelectedPage == .intro {
                IntroductionQuestionnaireScreen(currentSelectedPage: self.$currentSelectedPage)
            } else if self.currentSelectedPage == .genderAge {
                
            } else if self.currentSelectedPage == .height {
                
            } else if self.currentSelectedPage == .weight {
                
            } else if self.currentSelectedPage == .bodyType {
                
            } else if self.currentSelectedPage == .activityLevel {
                
            } else if self.currentSelectedPage == .foodType {
                
            } else if self.currentSelectedPage == .fitnessLevel {
                
            } else {
                
            }
            
        }
        
    }
}

#Preview {
    InitialQuestionnaireScreen()
}
