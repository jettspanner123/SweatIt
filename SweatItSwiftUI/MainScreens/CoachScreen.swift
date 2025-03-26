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
//            
//            
//            SecondaryHeading(title: "Newly Added", secondaryText: "( Things that are newly added to the app )")
//                .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
//            
//            ScrollView(.horizontal, showsIndicators: false) {
//                HStack {
//                    
//                    ForEach(0...3, id: \.self) { index in
//                        VStack {
//                        }
//                        .padding()
//                        .frame(width: UIScreen.main.bounds.width - 30, height: 125)
//                        .background(ApplicationLinearGradient.greenGradient, in: defaultShape)
//                        .scrollTransition { view, phase in
//                            view
//                                .opacity(phase.isIdentity ? 1 : 0)
//                                .blur(radius: phase.isIdentity ? 0 : 25)
//                        }
//                    }
//                   
//                    
//                    
//                }
//                .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
//                .scrollTargetLayout()
//            }
//            .scrollTargetBehavior(.viewAligned(limitBehavior: .never))
//            .scrollClipDisabled()
//            
            
            
            // MARK: HOrizontal scroll widgets
            SecondaryHeading(title: "Fitness Metrics", secondaryText: "( avg per week )")
                .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
//                .padding(.top, 25)
            
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
            
            
            
            
            
            // MARK: Hello wrold
            SecondaryHeading(title: "Total Weekly Volume", secondaryText: "( total sets did for each muscles )")
                .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
                .padding(.top, 25)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(Extras.Muscle.allCases, id: \.self) { muscle in
                        Text(muscle.rawValue)
                            .font(.system(size: 12, weight: .regular, design: .rounded))
                            .foregroundStyle(self.currentSelectedMuscle == muscle ? .white : .white.opacity(0.5))
                            .padding(.vertical, 10)
                            .padding(.horizontal)
                            .overlay {
                                Capsule()
                                    .stroke(.white.opacity(0.18))
                            }
                            .background(self.currentSelectedMuscle == muscle ? ApplicationLinearGradient.blueGradientInverted : ApplicationLinearGradient.darkBGSameGradientWithOpacityHalf, in: Capsule())
                            .onTapGesture {
                                withAnimation {
                                    self.currentSelectedMuscle = muscle
                                }
                            }
                    }
                }
                .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
            }
            
            VStack {
            }
            .frame(maxWidth: .infinity)
            
        }
    }
}

#Preview {
    CoachScreen()
}
