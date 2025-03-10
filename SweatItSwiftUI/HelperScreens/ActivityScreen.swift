//
//  ActivityScreen.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 09/03/25.
//

import SwiftUI

struct ActivityScreen: View {
    
    @State var showAllExerciseStats: Bool = false
    
    
    var body: some View {
        ScreenBuilder {
            AccentPageHeader(pageHeaderTitle: "Activities")
                .transition(.offset(y: -140))
            
            ScrollContentView {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2)) {
                    
                    // MARK: Calories Burned card
                    InformationCard(image: "FireLogo", title: "Burned", text: "195 kCal")
                        .background(defaultShape.fill(ApplicationLinearGradient.orangeGradient))
                    
                    // MARK: Calories Burned card
                    InformationCard(image: "Water", title: "Water", text: "500 ml")
                        .background(defaultShape.fill(ApplicationLinearGradient.blueGradient))
                    
                    // MARK: Calories Burned card
                    InformationCard(image: "Dumbbell", title: "Workout", text: "> 1 Hr", textColor: .appBloodRedDark.opacity(0.75))
                        .background(defaultShape.fill(ApplicationLinearGradient.whiteGradient))
                    
                    // MARK: Calories Burned card
                    InformationCard(image: "FireLogo", title: "Consumed", text: "1900 kCal")
                        .background(defaultShape.fill(ApplicationLinearGradient.greenGradient))
                    
                }
                
                
                // MARK: Step counter
                
                VStack {
                    Text("Step Counter")
                        .font(.system(size: 20, weight: .regular, design: .rounded))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 300, alignment: .topLeading)
                .padding(20)
                .background(.darkBG.opacity(0.54))
                .overlay {
                    defaultShape
                        .stroke(.white.opacity(0.18))
                }
                .clipShape(defaultShape)
                .padding(.top, 10)
                
                
                // MARK: Exercises stats
                HeadingWithLink(titleHeading: "Exercise Statistics", action: {
                    self.showAllExerciseStats = true
                })
                .padding(.top, 25)
                
                
                
                
                // MARK: Exercises expandable card
                ExerciseExpandableCard(exerciseText: "Pushups")
                    .background(defaultShape.fill(ApplicationLinearGradient.lavaGradient))
                ExerciseExpandableCard(exerciseText: "Squats")
                    .background(defaultShape.fill(ApplicationLinearGradient.blueGradient))
            }
            .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
        }
        .navigationDestination(isPresented: self.$showAllExerciseStats) {
            ExerciseStatisticsScreen()
        }
        
    }
}

#Preview {
    ActivityScreen()
}
