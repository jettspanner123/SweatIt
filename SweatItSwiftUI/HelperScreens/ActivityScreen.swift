//
//  ActivityScreen.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 09/03/25.
//

import SwiftUI

struct ActivityScreen: View {
    
    @State var showAllExerciseStats: Bool = false
    
    @State var weeklyData: Array<DailyEvents_t> = DailyEvents.current.weeklyEvents
    
    
    var body: some View {
        ScreenBuilder {
            AccentPageHeader(pageHeaderTitle: "Activities")
                .transition(.offset(y: -140))
            
            ScrollContentView {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2)) {
                    
                    // MARK: Calories Burned card
                    
                    InformationCard(image: "FireLogo", title: "Burned", text: "195 kCal", secondaryText: "", textColor: .white, wantInformationView: true, content: {
                        
                    })
                    .background(defaultShape.fill(ApplicationLinearGradient.orangeGradient))

                    // MARK: Calories Burned card
                    InformationCard(image: "Water", title: "Water", text: "500 ml", secondaryText: "", textColor: .white, wantInformationView: true) {
                        
                    }
                    .background(defaultShape.fill(ApplicationLinearGradient.blueGradient))
                    
                    // MARK: Calories Burned card
                    InformationCard(image: "Dumbbell", title: "Workout", text: "> 1 Hr", secondaryText: "", textColor: .appBloodRedDark, wantInformationView: true) {
                        
                    }
                    .background(defaultShape.fill(ApplicationLinearGradient.whiteGradient))

                    
                    // MARK: Calories Burned card
                    InformationCard(image: "FireLogo", title: "Consumed", text: "1900 kCal", secondaryText: "", textColor: .white, wantInformationView: true) {
                        
                    }
                    .background(defaultShape.fill(ApplicationLinearGradient.greenGradient))
                }
                
                
                // MARK: Step counter
                
                VStack {
                    Text("Step Counter")
                        .font(.system(size: 20, weight: .regular, design: .rounded))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    ZStack {
                        Circle()
                            .trim(from: 0.15, to: 0.85)
                            .stroke(LinearGradient(colors: [Color.appGreenDark, Color.appGreenLight], startPoint: .trailing, endPoint: .leading), style: StrokeStyle(lineWidth: 30, lineCap: .round, lineJoin: .round))
                            .rotationEffect(.degrees(90))
                            .opacity(0.25)
                            .padding(25)
                            .zIndex(1)
                        
                        Circle()
                            .trim(from: 0.15, to: 0.7)
                            .stroke(LinearGradient(colors: [Color.appGreenDark, Color.appGreenLight], startPoint: .trailing, endPoint: .leading), style: StrokeStyle(lineWidth: 30, lineCap: .round, lineJoin: .round))
                            .rotationEffect(.degrees(90))
                            .padding(25)
                            .zIndex(1)
                        
                        Image("Walking")
                            .scaleEffect(0.75)
                        
                        Text("\(self.weeklyData.last!.stepsTaken)")
                            .font(.custom(ApplicationFonts.oswaldRegular, size: 28))
                            .foregroundStyle(ApplicationLinearGradient.greenGradient)
                            .offset(y: 75)
                        
                    }
                    
                    Text("Calories Burned")
                        .font(.system(size: 15, weight: .medium, design: .rounded))
                        .foregroundStyle(.white.opacity(0.5))
                        .takeMaxWidthLeading()
                        .padding(.top)
                    
                    let caloriesBurned: Double = ApplicationHelper.estimatedCaloriesBurned(steps: self.weeklyData.last!.stepsTaken, weightInKg: Double(75))
                    
                    Text(String(format: "%.f", caloriesBurned))
                        .font(.custom(ApplicationFonts.oswaldRegular, size: 25))
                        .foregroundStyle(ApplicationLinearGradient.redGradient)
                        .takeMaxWidthLeading()

                    
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
