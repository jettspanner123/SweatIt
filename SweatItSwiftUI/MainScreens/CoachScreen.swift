//
//  CoachScreen.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 25/03/25.
//

import SwiftUI
import Charts

struct CoachScreen: View {
    
    
    enum CardType: String {
        case caloriesBurned, waterIntake, workoutTime, caloriesIngested
    }
    
    @State var currentSelectedMuscle: Extras.Muscle = .bicep
    @State var weeklyData: Array<DailyEvents_t> = DailyEvents.current.weeklyEvents
    
    
    
    var body: some View {
        ScrollContentView {
            
            
            // MARK: Horizontal scroll widgets
            SecondaryHeading(title: "Fitness Metrics", secondaryText: "( avg per week )")
                .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    CoachCaloriesBurned(cardType: .caloriesBurned, title: "Cal. Burned", trailingImage: "FireLogo", background: ApplicationLinearGradient.orangeGradient)
                    CoachCaloriesBurned(cardType: .waterIntake, title: "Water Intake", trailingImage: "Water", background: ApplicationLinearGradient.blueGradient)
                    CoachCaloriesBurned(cardType: .workoutTime, title: "Workout", trailingImage: "Workout", background: ApplicationLinearGradient.whiteGradient, textColor: .appBloodRedDark)
                    CoachCaloriesBurned(cardType: .caloriesIngested, title: "Cal. Ingested", trailingImage: "Food", background: ApplicationLinearGradient.greenGradient)
                }
                .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
                
            }
            
            
            
            
            // MARK: Walking activity
            SecondaryHeading(title: "Passive Activities", secondaryText: "( other then workouts )")
                .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
                .padding(.top, 25)
            
            AvgStepsPerWeek()
                .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
            
            
            
            
            
            // MARK: Total weekly volume
            SecondaryHeading(title: "Total Weekly Volume", secondaryText: "( total sets did for each muscles )")
                .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
                .padding(.top, 25)
            
            
            
            
            // MARK: All muscles
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(Extras.Muscle.allCases, id: \.self) { muscle in
                        HStack {
                            Text(muscle.rawValue)
                                .font(.system(size: 13, weight: .medium, design: .rounded))
                                .foregroundStyle(self.currentSelectedMuscle == muscle ? .white : .white.opacity(0.5))
                        }
                        .applicationDropDownButton(self.currentSelectedMuscle == muscle ? ApplicationLinearGradient.blueGradientInverted : ApplicationLinearGradient.darkBGSameGradientWithOpacityHalf)
                        .onTapWithScaleVibrate(scaleBy: 0.75) {
                            withAnimation {
                                self.currentSelectedMuscle = muscle
                            }
                        }
                    }
                }
                .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
            }
            
            
        }
        
    }
}

#Preview {
    CoachScreen()
}
