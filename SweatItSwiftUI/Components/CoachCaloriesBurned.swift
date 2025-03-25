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
    
    var avgCaloriesBurned: Int { return self.weeklyData.reduce(0) { $0 + $1.caloriesBurnedForTheDay } / self.weeklyData.count }
    var avgWaterConsumed: Int { return self.weeklyData.reduce(0) { $0 + $1.waterIntakeForTheDay } / self.weeklyData.count}
    var avgCaloriesIngested: Int { return self.weeklyData.reduce(0) { $0 + $1.caloriesIngestedForTheDay } / self.weeklyData.count}
    var avgWorkoutTiming: Int { return self.weeklyData.reduce(0) { $0 + $1.workoutTimingForTheDay } / self.weeklyData.count}
    
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
                Text(String(self.avgCaloriesBurned) + " kCal")
                    .font(.custom(ApplicationFonts.oswaldRegular, size: 25))
                    .foregroundStyle(self.textColor.opacity(0.75))
                    .takeMaxWidthLeading()
                    .padding(.top, 10)
            } else if self.cardType == .waterIntake {
                Text(String(self.avgWaterConsumed) + " Liters")
                    .font(.custom(ApplicationFonts.oswaldRegular, size: 25))
                    .foregroundStyle(self.textColor.opacity(0.75))
                    .takeMaxWidthLeading()
                    .padding(.top, 10)
            } else if self.cardType == .workoutTime {
                Text(String(self.avgWorkoutTiming) + " Mins")
                    .font(.custom(ApplicationFonts.oswaldRegular, size: 25))
                    .foregroundStyle(self.textColor.opacity(0.75))
                    .takeMaxWidthLeading()
                    .padding(.top, 10)
            } else {
                Text(String(self.avgCaloriesIngested) + " kCal")
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
    }
}
