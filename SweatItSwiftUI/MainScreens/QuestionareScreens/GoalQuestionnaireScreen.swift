//
//  GoalQuestionnaireScreen.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 23/03/25.
//

import SwiftUI

struct GoalQuestionnaireScreen: View {
    @EnvironmentObject var appStates: ApplicationStates
    
    @State var currentSelectedGoal: Extras.Goal = .looseFat
    
    
    func getGoalContext(_ goal: Extras.Goal) -> String {
        switch goal {
        case .looseFat:
            return "Losing fat reduces stored body fat, improving health, energy, and appearance."
        case .buildMuscle:
            return "Building muscle increases mass through training and nutrition, enhancing strength, metabolism, and physique."
        case .bodyRecomposition:
            return "Body recomposition involves losing fat and gaining muscle, creating a leaner, stronger physique."
        case .beFit:
            return "Being fit means balancing strength, endurance, flexibility, and health for better energy, longevity, and life quality."
        case .developer:
            return ""
        case .none:
            return ""
        }
    }
    var body: some View {
        VStack {
            
            
            
            
            // MARK: Content View
            
            ScrollView {
                VStack {
                    
                    
                    // MARK: Page heading
                    Text("Please select, what you want to achive in the comeing future. This is necessary to set your goals.")
                        .font(.system(size: 12, weight: .regular, design: .rounded))
                        .foregroundStyle(.white.opacity(0.5))
                        .takeMaxWidthLeading()
                        .padding(.horizontal, 3)
                        .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
                    
                    
                    
                    SectionHeader(text: "Goal Description")
                        .padding(.top, 25)
                        .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
                    
                    
                    ScrollViewReader { scrollProxy in
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(Array(Extras.Goal.allCases), id: \.self) { goal in
                                    if !(goal == .developer || goal == .none) {
                                        VStack(spacing: 5) {
                                            
                                            Text(goal.rawValue)
                                                .font(.system(size: 15, weight: .medium, design: .rounded))
                                                .foregroundStyle(self.currentSelectedGoal == goal ? .white : .white.opacity(0.5))
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                            
                                            Text(self.getGoalContext(goal))
                                                .font(.system(size: 12, weight: .light, design: .rounded))
                                                .foregroundStyle(self.currentSelectedGoal == goal ? .white : .white.opacity(0.5))
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                        }
                                        .frame(maxHeight: 120)
                                        .frame(width: UIScreen.main.bounds.width * 0.8, alignment: .topLeading)
                                        .padding()
                                        .background(self.currentSelectedGoal == goal ? ApplicationLinearGradient.blueGradientInverted : ApplicationLinearGradient.darkBGSameGradientWithOpacityHalf)
                                        .overlay {
                                            defaultShape
                                                .stroke(.white.opacity(0.18))
                                        }
                                        .clipShape(defaultShape)
                                        .id(goal)
                                    }
                                }
                            }
                            .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
                            .scrollTargetLayout()
                        }
                        .scrollTargetBehavior(.viewAligned)
                        .onChange(of: self.currentSelectedGoal) {
                            withAnimation(.snappy(duration: 5)) {
                                scrollProxy.scrollTo(self.currentSelectedGoal, anchor: .leading)
                            }
                        }
                    }
                    
                    
                    
                    
                    
                    // MARK: All goals
                    SectionHeader(text: "Choose Goal")
                        .padding(.top, 25)
                        .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
                    
                    
                    ForEach(Extras.Goal.allCases, id: \.self) { goal in
                        if !(goal == .developer || goal == .none) {
                            HStack {
                                Text(goal.rawValue)
                                    .font(.system(size: 15, weight: .regular, design: .rounded))
                                    .foregroundStyle(self.currentSelectedGoal == goal ? .white : .white.opacity(0.5))
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: 45)
                            .background(self.currentSelectedGoal == goal ? ApplicationLinearGradient.blueGradientInverted : ApplicationLinearGradient.darkBGSameGradientWithOpacityHalf)
                            .overlay {
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(.white.opacity(0.18))
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
                            .onTapGesture {
                                withAnimation(.snappy(duration: 1)) {
                                    self.currentSelectedGoal = goal
                                }
                            }
                        }
                        
                    }
                    
                }
                .padding(.vertical, ApplicationPadding.mainScreenVerticalPadding)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .sensoryFeedback(.impact, trigger: self.currentSelectedGoal)
        .onChange(of: self.currentSelectedGoal) {
            self.appStates.userData.goalType = self.currentSelectedGoal
        }
    }
}
