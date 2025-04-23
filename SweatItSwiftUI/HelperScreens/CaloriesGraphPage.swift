//
//  CaloriesGraphPage.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 23/04/25.
//

import SwiftUI
import Charts

struct CaloriesBurnedGraphPage: View {
    @EnvironmentObject var healthManager: HealthManager
    enum CaloriesBurnedGraphCategory: String, CaseIterable {
        case today, weekly, monthly
    }
    
    @State var selectedCategory: CaloriesBurnedGraphCategory = .today
    @State var stepsTakenForTheDay: Int = .zero
    
    @State var stepsTakenEachHour: Array<(Int, Int, Int)> = []
    @State var stringStepsTakenEachHour: Dictionary<String, String> = [:]

    
    
    var workouts: Array<Workout_t> = Workout.current.exampleWorkoutList
    
    var totalCaloriesBurned: Double {
        return self.workouts.reduce(0) { $0 + $1.caloriesBurned }
    }
    
    func convertStringDictionaryToDictionary() -> Void {
        var index: Int = .zero
        for (key, value) in self.stringStepsTakenEachHour {
            let keyInt: Int = Int(key)!
            let valueInt: Int = Int(value)!
            
            self.stepsTakenEachHour.append((keyInt, valueInt, index))
        }
        
        print(self.stepsTakenEachHour)
    }
    var body: some View {
        ScreenBuilder {
            AccentPageHeader(pageHeaderTitle: "Calories Stats")
            
            ScrollContentView {
                
                // MARK: Selection stack
                HStack {
                    ForEach(CaloriesBurnedGraphCategory.allCases, id: \.self) { category in
                        HStack {
                            Text(category.rawValue.capitalized)
                                .font(.system(size: 13, weight: .medium, design: .rounded))
                                .foregroundStyle(self.selectedCategory == category ? .white : .white.opacity(0.5))
                                .frame(maxWidth: .infinity)
                        }
                        .applicationDropDownButton(self.selectedCategory == category ? ApplicationLinearGradient.blueGradientInverted : ApplicationLinearGradient.darkBGSameGradientWithOpacityHalf, height: 40)
                        .onTapWithScaleVibrate {
                            withAnimation {
                                self.selectedCategory = category
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                
                
                
                SectionHeader(text: "Calories Statistics")
                    .padding(.top, 25)
                
                switch self.selectedCategory {
                case .today:
                    self.TodayCaloriesBurnedGraph
                        .transition(.blurReplace)
                case .weekly:
                    self.WeeklyCaloriesBurnedGraph
                        .transition(.blurReplace)
                case .monthly:
                    self.MonthlyCaloriesBurnedGraph
                        .transition(.blurReplace)
                }
                
                
                SectionHeader(text: "Others")
                    .padding(.top, 25)
                
                // MARK: about card
                VStack {
                    Text("About")
                        .font(.custom(ApplicationFonts.oswaldRegular, size: 20))
                        .foregroundStyle(.white)
                        .takeMaxWidthLeading()
                        .padding(.top, 10)
                    
                    
                    Text("Calories Burned is an estimate of the energy your body uses during physical activity. This includes both active calories — burned through movement and exercise — and resting calories, which are used to support basic bodily functions like breathing and digestion. Your calorie burn is influenced by factors such as your age, sex, weight, height, and activity level. More intense or longer workouts typically result in a higher number of calories burned. Tracking calories can help you understand your overall activity level and support your health and fitness goals. Remember, calorie estimates are just that — estimates — and may vary based on individual metabolism and other factors.")
                        .font(.system(size: 15, weight: .medium, design: .rounded))
                        .foregroundStyle(.white.opacity(0.5))
                        .takeMaxWidthLeading()
                        .padding(.bottom)
                }
                .applicationDropDownButton()
                
                
                
                // MARK: View depending upon category
            }
            .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
        }
        .onAppear {
            Task {
                self.stepsTakenForTheDay = await self.healthManager.getStepsToday()
            }
        }
    }
    
    var TodayCaloriesBurnedGraph: some View {
        VStack {
            
            
            
            
            // MARK: Bar chart
            HStack {
                Chart(self.workouts) { workout in
                    BarMark(x: .value("Time", ApplicationHelper.getTimeString(from: workout.timing)), y: .value("Calories Burned", workout.caloriesBurned))
                        .foregroundStyle(ApplicationLinearGradient.redGradient)
                }
                .padding(.vertical)
            }
            .applicationDropDownButton()
       
            SectionHeader(text: "Highlights")
                .padding(.top, 25)
            
            
            
            
            
            // MARK: line chart
            VStack {
                
                Text("Calores Over Time")
                    .font(.custom(ApplicationFonts.oswaldRegular, size: 20))
                    .foregroundStyle(.white)
                    .takeMaxWidthLeading()
                    .padding(.top, 10)
                
                
                Text("Over the last \(self.workouts.count) workouts, you burned an average of \(String(format: "%.f kCal", self.totalCaloriesBurned)) calories.")
                    .font(.system(size: 15, weight: .medium, design: .rounded))
                    .foregroundStyle(.white.opacity(0.5))
                    .takeMaxWidthLeading()
                
                Chart(self.workouts) { workout in
                    LineMark(x: .value("Exercise Count", ApplicationHelper.getTimeString(from: workout.timing)), y: .value("Calories Burned", workout.caloriesBurned))
                        .foregroundStyle(.appThanosLight)
                }
                .padding(.top)
                .padding(.bottom)
            }
            .applicationDropDownButton()
            
            
            
            
            
            // MARK: line chart
            VStack {
                
                Text("Calories Burned By Steps")
                    .font(.custom(ApplicationFonts.oswaldRegular, size: 20))
                    .foregroundStyle(.white)
                    .takeMaxWidthLeading()
                    .padding(.top, 10)
                
                let timeFromStartOfDay = Calendar.current.dateComponents([.hour], from: Calendar.current.startOfDay(for: Date()), to: Date()).hour!
                HStack {
                    
                    Text("The amount of calories that you've burned while walking in the span of last ")
                        .font(.system(size: 15, weight: .medium, design: .rounded))
                        .foregroundStyle(.white.opacity(0.5))
                    
                    +
                    
                    Text(String(timeFromStartOfDay) + " Hours")
                        .font(.system(size: 15, weight: .bold, design: .rounded))
                        .foregroundStyle(.white.opacity(0.75))
                }
                .takeMaxWidthLeading()
                
                Text(String(self.stepsTakenForTheDay) + " Steps")
                    .font(.custom(ApplicationFonts.oswaldRegular, size: 20))
                    .foregroundStyle(.white)
                    .takeMaxWidthLeading()
                
                
                Chart(self.stepsTakenEachHour, id: \.2) { item in
                    LineMark(x: .value("Hour", item.0), y: .value("Steps Taken", item.1))
                        .foregroundStyle(.appThanosLight)
                }
                .chartYAxis(.visible)
                .chartXAxis(.visible)
                .padding(.top)
                .padding(.bottom)
            }
            .applicationDropDownButton()
            
            
        }
        .frame(maxWidth: .infinity)
        .onAppear {
            Task {
                self.stringStepsTakenEachHour = await self.healthManager.getStepsFromEachHourOfDay()
                self.convertStringDictionaryToDictionary()
            }
            
        }
        
    }
    
    var WeeklyCaloriesBurnedGraph: some View {
        VStack {
            
        }
        .frame(maxWidth: .infinity)
    }
    
    var MonthlyCaloriesBurnedGraph: some View {
        VStack {
            
        }
        .frame(maxWidth: .infinity)
    }
}


struct CaloriesGraphPagePreviewProvider: PreviewProvider {
    static let appStates: ApplicationStates = .init()
    static let healthManager: HealthManager = .init()
    
    static var previews: some View {
        CaloriesBurnedGraphPage()
            .environmentObject(self.appStates)
            .environmentObject(self.healthManager)
    }
    
}
