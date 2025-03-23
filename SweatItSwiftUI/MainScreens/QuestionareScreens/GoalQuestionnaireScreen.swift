//
//  GoalQuestionnaireScreen.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 23/03/25.
//

import SwiftUI

struct GoalQuestionnaireScreen: View {
    
    @State var currentSelectedGoal: Extras.Goal = .looseFat
    var body: some View {
        VStack {
            
            
            ScrollView {
                VStack {
                    
                    
                    // MARK: Page heading
                    Text("Please select, what you want to achive in the comeing future. This is necessary to set your goals.")
                        .font(.system(size: 12, weight: .regular, design: .rounded))
                        .foregroundStyle(.white.opacity(0.5))
                        .takeMaxWidthLeading()
                        .padding(.horizontal, 3)
                    
                    
                    
                    SectionHeader(text: "Goal Description")
                        .padding(.top, 25)
                    
                    
                    
                    
                    
                    
                    // MARK: All goals
                    SectionHeader(text: "Choose Goal")
                        .padding(.top, 25)
                    
                    
                    ForEach(Extras.Goal.allCases, id: \.self) { goal in
                        if !(goal == .developer || goal == .none) {
                            HStack {
                                Text(goal.rawValue)
                                    .font(.system(size: 15, weight: .regular, design: .rounded))
                                    .foregroundStyle(self.currentSelectedGoal == goal ? .white : .white.opacity(0.5))
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: 40)
                            .background(self.currentSelectedGoal == goal ? ApplicationLinearGradient.blueGradientInverted : ApplicationLinearGradient.darkBGSameGradientWithOpacityHalf)
                            .overlay {
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(.white.opacity(0.18))
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .onTapGesture {
                                withAnimation {
                                    self.currentSelectedGoal = goal
                                }
                            }
                        }
                        
                    }
                }
                .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
                .padding(.vertical, ApplicationPadding.mainScreenVerticalPadding)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}

#Preview {
    GoalQuestionnaireScreen()
}
