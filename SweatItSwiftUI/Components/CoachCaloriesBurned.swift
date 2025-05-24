//
//  CoachCaloriesBurned.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 25/03/25.
//

import SwiftUI


struct CoachCaloriesBurned: View {
    
    var cardType: CoachScreen.CardType
    
    var title: String
    var trailingImage: String
    var background: LinearGradient
    var textColor: Color = .white
    @State var weeklyData: Array<DailyEvents_t> = DailyEvents.current.weeklyEvents
    
    //    var avgCaloriesBurned: Int {
    //        var toRet: Int = .zero
    //        for calories in self.weeklyData {
    //            toRet += calories.caloriesBurnedForTheDay
    //        }
    //        return toRet
    //    }
    
    
    var totalProteinIntake: Double {
        var protein: Double = .zero
        
        for day in self.weeklyData {
            for meal in day.mealsHad {
                protein += meal.totalProtein
            }
        }
        return protein / Double(self.weeklyData.count)
    }
    
    var totalCarbIntake: Double {
        var carb: Double = .zero
        
        for day in self.weeklyData {
            for meal in day.mealsHad {
                carb += meal.totalCarbs
            }
        }
        return carb / Double(self.weeklyData.count)
    }
    
    var totalFatIntake: Double {
        var fats: Double = .zero
        
        for day in self.weeklyData {
            for meal in day.mealsHad {
                fats += meal.totalFats
            }
        }
        return fats / Double(self.weeklyData.count)
    }
    
    
    func getReducedValue(_ value: Double, maxValue: Double = 1000) -> Double {
        return min(max(value / maxValue, 0), 1)
    }
    
    func calculatePercentage(value: Double, total: Double) -> Double {
        guard total != 0 else { return 0 } // Avoid division by zero
        return value / total
    }
    
    @State var weeklyCaloriesBurned: Dictionary<Date, Double> = [:]
    @State var weeklyWaterIntake: Dictionary<Date, Int> = [:]
    @State var weeklyWorkoutTiming: Dictionary<Date, Double> = [:]
    @State var weeklyMacroNutrients: Dictionary<Date, (protein: Double, carbs: Double, fats: Double, caloriesForTheDay: Double)> = [:]
    
    var avgCaloriesBurned: Double {
        if self.weeklyCaloriesBurned.isEmpty {
            return .zero
        } else {
            return (self.weeklyCaloriesBurned.reduce(0) {$0 + $1.value }) / Double(self.weeklyCaloriesBurned.count)
        }
    }
    
    var avgWaterIntake: Double {
        if self.weeklyWaterIntake.isEmpty {
            return .zero
        } else {
            return Double((self.weeklyWaterIntake.reduce(0) {$0 + $1.value })) / Double(self.weeklyWaterIntake.count)
        }
    }
    
    var avgWorkoutTiming: Double {
        if self.weeklyWorkoutTiming.isEmpty {
            return .zero
        } else {
            return (self.weeklyWorkoutTiming.reduce(0) {$0 + $1.value }) / Double(self.weeklyWorkoutTiming.count)
        }
    }
    
    var avgCaloriesIngested: Double {
        if self.weeklyMacroNutrients.isEmpty {
            return .zero
        } else {
            return (self.weeklyMacroNutrients.reduce(0) {$0 + $1.value.caloriesForTheDay}) / Double(self.weeklyMacroNutrients.count)
        }
    }
    
    
    var body: some View {
        VStack(spacing: 0) {
            
            
            // MARK: Title and something
            HStack {
                Text(self.title)
                    .font(.system(size: 15, weight: .regular, design: .rounded))
                    .foregroundStyle(.white)
                
                Spacer()
                
                
                HStack {
                    Image(self.trailingImage)
                }
                .frame(width: 30, height: 30)
                .background(.white.opacity(0.15))
                .clipShape(Circle())
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
            
            
            if self.cardType == .caloriesBurned {
                
                GeometryReader {
                    
                    let readerSize = $0.size
                    
                    HStack(alignment: .bottom) {
                        ForEach(self.weeklyData, id: \.id) { daily in
                            HStack {
                                
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: self.getReducedValue(Double(daily.caloriesBurnedForTheDay)) * readerSize.height)
                            .background(self.textColor.opacity(self.getReducedValue(Double(daily.caloriesBurnedForTheDay)) - 0.1))
                            .clipShape(Capsule())
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                }
            } else if self.cardType == .waterIntake {
            } else if self.cardType == .workoutTime {
                GeometryReader {
                    
                    let readerSize = $0.size
                    
                    HStack(alignment: .bottom) {
                        ForEach(self.weeklyData, id: \.id) { daily in
                            HStack {
                                
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: self.getReducedValue(Double(daily.workoutTimingForTheDay), maxValue: 100) * readerSize.height)
                            .background(self.textColor.opacity(self.getReducedValue(Double(daily.workoutTimingForTheDay), maxValue: 100) - 0.1))
                            .clipShape(Capsule())
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                }
            } else {
                VStack {
                    
                    
                    
                    
                    // MARK: Protine
                    GeometryReader {
                        let _ = $0.size
                        
                        HStack {
                            Text("P")
                                .font(.custom(ApplicationFonts.oswaldRegular, size: 12))
                                .foregroundStyle(.white)
                            
                            GeometryReader {
                                
                                let loadingBar = $0.size
                                
                                HStack {
                                    HStack {
                                        
                                    }
                                    .frame(width: self.calculatePercentage(value: self.totalProteinIntake, total: loadingBar.width) * loadingBar.width, height: 12)
                                    .background(.white.opacity(0.75), in: Capsule())
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                
                            }
                            .frame(height: 12)
                            
                            Text(String(format: "%.f g", self.totalProteinIntake))
                                .font(.custom(ApplicationFonts.oswaldRegular, size: 12))
                                .foregroundStyle(.white)
                            
                        }
                        .frame(maxWidth: .infinity)
                    }
                    
                    
                    
                    
                    
                    
                    // MARK: Carbs
                    GeometryReader {
                        let _ = $0.size
                        
                        HStack {
                            Text("C")
                                .font(.custom(ApplicationFonts.oswaldRegular, size: 12))
                                .foregroundStyle(.white)
                            
                            GeometryReader {
                                
                                let loadingBar = $0.size
                                let width = self.calculatePercentage(value: self.totalCarbIntake, total: loadingBar.width) * loadingBar.width > loadingBar.width ? loadingBar.width : self.calculatePercentage(value: self.totalCarbIntake, total: loadingBar.width) * loadingBar.width
                                
                                HStack {
                                    HStack {
                                        
                                    }
                                    .frame(width: width, height: 12)
                                    .background(.white.opacity(0.75), in: Capsule())
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                
                            }
                            .frame(height: 12)
                            
                            Text(String(format: "%.f g", self.totalCarbIntake))
                                .font(.custom(ApplicationFonts.oswaldRegular, size: 12))
                                .foregroundStyle(.white)
                            
                        }
                        .frame(maxWidth: .infinity)
                    }
                    
                    
                    
                    
                    
                    // MARK: Fats
                    GeometryReader {
                        let _ = $0.size
                        
                        HStack {
                            Text("F")
                                .font(.custom(ApplicationFonts.oswaldRegular, size: 12))
                                .foregroundStyle(.white)
                            
                            GeometryReader {
                                
                                let loadingBar = $0.size
                                
                                HStack {
                                    HStack {
                                        
                                    }
                                    .frame(width: self.calculatePercentage(value: self.totalFatIntake, total: loadingBar.width) * loadingBar.width, height: 12)
                                    .background(.white.opacity(0.75), in: Capsule())
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                
                            }
                            .frame(height: 12)
                            
                            Text(String(format: "%.f g", self.totalFatIntake))
                                .font(.custom(ApplicationFonts.oswaldRegular, size: 12))
                                .foregroundStyle(.white)
                            
                        }
                        .frame(maxWidth: .infinity)
                    }
                    
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            
            
            if self.cardType == .caloriesBurned {
                Text(String(format: "%.f", self.avgCaloriesBurned) + " kCal")
                    .font(.custom(ApplicationFonts.oswaldRegular, size: 25))
                    .foregroundStyle(self.textColor.opacity(0.75))
                    .takeMaxWidthLeading()
                    .padding(.top, 10)
                    .contentTransition(.numericText(value: self.avgCaloriesBurned))
                    .animation(.snappy, value: self.avgCaloriesBurned)
            } else if self.cardType == .waterIntake {
                Text(String(format: "%.f", self.avgWaterIntake) + " Liters")
                    .font(.custom(ApplicationFonts.oswaldRegular, size: 25))
                    .foregroundStyle(self.textColor.opacity(0.75))
                    .takeMaxWidthLeading()
                    .padding(.top, 10)
            } else if self.cardType == .workoutTime {
                Text(ApplicationHelper.formatSeconds(seconds: Int(self.avgWorkoutTiming)))
                    .font(.custom(ApplicationFonts.oswaldRegular, size: 25))
                    .foregroundStyle(self.textColor.opacity(0.75))
                    .takeMaxWidthLeading()
                    .padding(.top, 10)
            } else {
                Text(String(format: "%.f", self.avgCaloriesIngested) + " kCal")
                    .font(.custom(ApplicationFonts.oswaldRegular, size: 25))
                    .foregroundStyle(self.textColor.opacity(0.75))
                    .takeMaxWidthLeading()
                    .padding(.top, 10)
            }
            
        }
        .frame(width: 130, height: 150, alignment: .top)
        .padding(8)
        .padding(.horizontal, 6)
        .background(self.background.opacity(0.9))
        .clipShape(defaultShape)
        .contextMenu {
            if self.cardType == .caloriesBurned {
                Text("Calories Burned 🔥")
                ForEach(self.weeklyCaloriesBurned.sorted(by: <), id: \.key) { key, value in
                    let dayIndex = Calendar.current.dateComponents([.weekday], from: key).weekday!
                    
                    let day = Calendar.current.weekdaySymbols[dayIndex]
                    Text("\(day): [\(String(format: "%.f kCal", value))]")
                }
            } else if self.cardType == .waterIntake {
                Text("Water Intake 💧")
                ForEach(self.weeklyWaterIntake.sorted(by: <), id: \.key) { key, value in
                    let dayIndex = Calendar.current.dateComponents([.weekday], from: key).weekday!
                    let day = Calendar.current.weekdaySymbols[dayIndex]
                    Text("\(day): [\(String(format: "%.f mL", value))]")
                }
            } else if self.cardType == .workoutTime {
                Text("Workout Timing 💪")
                ForEach(self.weeklyWorkoutTiming.sorted(by: <), id: \.key) { key, value in
                    let dayIndex = Calendar.current.dateComponents([.weekday], from: key).weekday!
                    let day = Calendar.current.weekdaySymbols[dayIndex]
                    Text("\(day): [\(String(format: "%.f mins", value))]")
                }
            } else {
                Text("Calories Ingested 🥦")
                ForEach(self.weeklyCaloriesBurned.sorted(by: <), id: \.key) { key, value in
                    let dayIndex = Calendar.current.dateComponents([.weekday], from: key).weekday!
                    let day = Calendar.current.weekdaySymbols[dayIndex]
                    Text("\(day): [\(String(format: "%.f kCal", value))]")
                }
            }
            
        }
        .onAppear {
            print("Coach Screen----------------------")
            Task {
                self.weeklyCaloriesBurned = try await ApplicationEndpoints.get.getWeeklyCalories(forUserId: User.current.currentUser.id)
                self.weeklyWaterIntake = try await ApplicationEndpoints.get.getWeeklyWaterIntake(forUserId: User.current.currentUser.id)
                self.weeklyWorkoutTiming = try await ApplicationEndpoints.get.getWeeklyWorkoutTimings(forUserId: User.current.currentUser.id)
                self.weeklyMacroNutrients = try await ApplicationEndpoints.get.getWeeklyMacroNutritions(forUserId: User.current.currentUser.id)
                print("Weekly Calories Burned: \(self.weeklyCaloriesBurned)")
                print("Weekly Water Intake: \(self.weeklyWaterIntake)")
                print("Weekly Workout Timing: \(self.weeklyWorkoutTiming)")
                print("Weekly Calories Ingested: \(self.weeklyMacroNutrients)")
            }
            
        }
    }
}
