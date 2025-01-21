//
//  CoachPage.swift
//  SweatIt
//
//  Created by Uddeshya Singh on 20/01/25.
//

import SwiftUI

struct CoachPage: View {
    
    @Binding var currentPage: Int
    
    var body: some View {
        ZStack {
            PageHeader(pageHeaderTitle: "Coach")
            ScrollView(showsIndicators: false) {
                VStack {
                    TertiaryHeading(titleHeading: "Fitness Metrics", secondaryHeading: "as per week", bottomSpace: true)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 17) {
                            CaloriesBurnedGraph(caloriesOnWeek: [(37, 0.45, 0), (50, 0.65, 1), (39, 0.55, 2), (65, 1, 3), (48, 0.65, 4), (22, 0.35, 5), (22, 0.35, 6)])
                            WaterIntakeGraph(leters: 1.9)
                            WorkoutTimingGraph(workoutTiming:  [(37, 0.45, 0), (50, 0.65, 1), (39, 0.55, 2), (65, 1, 3), (48, 0.65, 4), (22, 0.35, 5), (22, 0.35, 6)], avgWorkoutTIme: 32, workoutUnit: "Mins")
                            CaloriesIngestedGraph(proien: 75, carbs: 25, fats: 10, caloriesIngested: 2307)
                        }
                        .padding(.horizontal, 25)
                    }
                    
                    TertiaryHeading(titleHeading: "Passive Activities", secondaryHeading: "NEAT", bottomSpace: false)
                    
                    Text("These are the kind of activities that bring your heart rate up but are not classified as exercises")
                        .multilineTextAlignment(.leading)
                        .font(.system(size: 20, weight: .light, design: .rounded))
                        .foregroundStyle(.white.opacity(0.44))
                        .padding(.horizontal, 25)
                        .padding(.bottom, 20)
                        .offset(y: 12)
                    
                    
                    StepsPerDayGraph(stepsThroughoutWeek: [(0.5, 12754, 1), (0.35, 11187, 2), (0.7, 13025, 3), (0.8, 13245, 4), (0.6, 15003, 5)], avgSteps: 1325, goalSteps: 15000)
                    
                    
                    
                }
                .padding(.top, 63)
                .padding(.bottom, 150)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            PageNavigationBar(currentPage_t: $currentPage, currentPage: "Coach")
                .zIndex(100)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            LinearGradient(gradient: Gradient(colors: [Color("DarkBG"), .black]), startPoint: UnitPoint(x: 0.5, y: 0.1), endPoint: UnitPoint(x: 0.5, y:1.6))
        )
        
    }
}


struct StepsPerDayGraph: View {
    var stepsThroughoutWeek: Array<(Double, Int, Int)>
    var avgSteps: Int
    var goalSteps: Int
    
    var body: some View {
        ZStack {
           
            HStack(alignment: .bottom) {
                Text("\(avgSteps) /")
                    .font(.custom("Oswald-Regular", size: 30))
                    .foregroundStyle(.white.opacity(0.65))
                
                Text("\(goalSteps)")
                    .font(.custom("Oswald-Regular", size: 15))
                    .foregroundStyle(.white.opacity(0.65))
                    .offset(y: -5)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .offset(y: -100)
            
            VStack {
                Text("Steps per day")
                    .font(.custom("RobotoCondensed-Medium", size: 30))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .offset(y: -20)
                
                HStack(alignment: .bottom) {
                    ForEach(self.stepsThroughoutWeek, id: \.self.2) { item in
                        VStack {
                            Text("\(item.1)")
                                .font(.custom("RobotoCondensed-Light", size: 15))
                                .foregroundStyle(.white)
                                .padding(.horizontal, 6)
                                .padding(.vertical, 12)
                                .background(Color("AppBlueDark").opacity(0.4))
                                .cornerRadius(7)
                            
                            HStack {
                                
                            }
                            .frame(maxWidth: 60, maxHeight: CGFloat(item.1) / 100)
                            .background(Color("AppBlueDark").opacity(item.0 + 0.25))
                            .cornerRadius(10)
                            
                            
                            GetCurrentDay(currentDay: item.2)
                        }
                    }
                }
                .offset(y: 20)
            }
        }
        .frame(width: UIScreen.main.bounds.width * 0.8, height: 350)
        .padding(25)
        .background(
            LinearGradient(gradient: Gradient(colors: [Color("AppBlueDark"), Color("AppBlueLight")]), startPoint: UnitPoint(x: 0.5, y: 0.1), endPoint: UnitPoint(x: 0.5, y:1.6))
        )
        .cornerRadius(17)
        
    }
    
    
}

struct GetCurrentDay: View {
    
    var currentDay: Int
    var whatDayItIs: String {
        if currentDay == 1 {
            return "Mon"
        } else if currentDay == 2 {
            return "Tue"
        }else if currentDay == 3 {
            return "Wed"
        }else if currentDay == 4 {
            return "Thu"
        }else if currentDay == 5 {
            return "Fri"
        }
        
        return "Nil"
    }
    
    var body: some View {
        Text(whatDayItIs)
            .font(.system(size: 20, weight: .regular, design: .rounded))
            .foregroundStyle(.white.opacity(0.5))
    }
    
}


struct CaloriesBurnedGraph: View {
    
    var caloriesOnWeek: Array<(Int, Double, Int)>
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Cal. Burned")
                    .font(.system(size: 20, weight: .regular, design: .rounded))
                    .foregroundStyle(.white)
                
                Spacer()
                
                HStack {
                    Image("FireLogo")
                }
                .frame(width: 30, height: 30)
                .background(.white.opacity(0.17))
                .cornerRadius(100)
            }
            .offset(y: -10)
            
            HStack(alignment: .bottom) {
                ForEach(self.caloriesOnWeek, id: \.self.2) { item in
                    HStack(alignment: .bottom) {
                    }
                    .frame(width: 14, height: CGFloat(item.0))
                    .background(.white.opacity(item.1))
                    .cornerRadius(9)
                }
            }
            .offset(y: 10)
            
            
            Text("195 kCal")
                .font(.custom("Oswald-Regular", size: 30))
                .foregroundStyle(.white.opacity(0.7))
                .frame(maxWidth: .infinity, alignment: .leading)
                .offset(y: 10)
        }
        .padding(15)
        .frame(width: 173, height: 190)
        .background(
            LinearGradient(gradient: Gradient(colors: [Color("AppOrangeLight"), Color("AppOrangeDark")]), startPoint: UnitPoint(x: 0.5, y: 0), endPoint: UnitPoint(x: 0.5, y:1))
        )
        .cornerRadius(16)
    }
}

struct WaterIntakeGraph: View {
    
    var leters: Double
    var body: some View {
        VStack {
            HStack {
                Text("Water Input")
                    .font(.system(size: 20, weight: .regular, design: .rounded))
                    .foregroundStyle(.white)
                
                Spacer()
                
                HStack {
                    Image("Water")
                }
                .frame(width: 30, height: 30)
                .background(.white.opacity(0.17))
                .cornerRadius(100)
            }
            .offset(y: -5)
            
            
            Image("vec22") //svg (scaleble vector garphics)
                .resizable()
                .frame(width: 119, height: 43)
                .offset(y: 10)
            
            Text("\(String(format: "%.1f", self.leters)) Liters")
                .font(.custom("Oswald-Regular", size: 30))
                .foregroundStyle(.white.opacity(0.7))
                .frame(maxWidth: .infinity, alignment: .leading)
                .offset(y: 5)
            
            
            
            
        }
        .padding(15)
        .frame(width: 173, height: 190)
        .background(
            LinearGradient(gradient: Gradient(colors: [Color("AppBlueDark"), Color("AppBlueLight")]), startPoint: UnitPoint(x: 0.5, y: 0), endPoint: UnitPoint(x: 0.5, y:1))
        )
        .cornerRadius(16)
    }
}

struct WorkoutTimingGraph: View {
    
    var workoutTiming: Array<(Int, Double, Int)>
    var avgWorkoutTIme: Int
    var workoutUnit: String
    
    var body: some View {
        VStack {
            HStack {
                Text("Train Time")
                    .font(.system(size: 20, weight: .regular, design: .rounded))
                    .foregroundStyle(.white)
                
                Spacer()
                
                HStack {
                    Image("Workout")
                        .resizable()
                        .frame(width: 20, height: 20)
                }
                .frame(width: 30, height: 30)
                .background(.white.opacity(0.17))
                .cornerRadius(100)
            }
            .offset(y: 5)
            
            HStack(alignment: .bottom) {
                ForEach(self.workoutTiming, id: \.self.2) { item in
                    HStack(alignment: .bottom) {
                    }
                    .frame(width: 14, height: CGFloat(item.0))
                    .background(Color("AppBloodRedDark").opacity(item.1))
                    .cornerRadius(9)
                }
            }
            .offset(y: 10)
            
            HStack {
                Text("\(self.avgWorkoutTIme)")
                    .font(.custom("Oswald-Regular", size: 30))
                    .foregroundStyle(Color("AppBloodRedDark").opacity(0.7))
                    .offset(y: -5)
                
                Text("\(self.workoutUnit)")
                    .font(.custom("Oswald-Regular", size: 30))
                    .foregroundStyle(Color("AppBloodRedDark").opacity(0.7))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .offset(y: -5)
                
            }
        }
        .padding(15)
        .frame(width: 173, height: 190)
        .background(
            LinearGradient(gradient: Gradient(colors: [Color("AppGreyLight"), .white]), startPoint: UnitPoint(x: 0.5, y: 0), endPoint: UnitPoint(x: 0.5, y:1))
        )
        .cornerRadius(16)
    }
}

struct CaloriesIngestedGraph: View {
    
    var proien: Int
    var carbs: Int
    var fats: Int
    var caloriesIngested: Int
    
    var body: some View {
        VStack {
            HStack {
                Text("Cal. Eaten")
                    .font(.system(size: 20, weight: .regular, design: .rounded))
                    .foregroundStyle(.white)
                
                Spacer()
                
                HStack {
                    Image("Food")
                        .resizable()
                        .frame(width: 20, height: 20)
                }
                .frame(width: 30, height: 30)
                .background(.white.opacity(0.17))
                .cornerRadius(100)
            }
            .offset(y: 15)
            
            VStack(spacing: 8) {
                //            ye protien wala
                HStack {
                    Text("P")
                        .font(.custom("Oswald-Regular", size: 15))
                        .foregroundStyle(.white)
                    HStack {
                        
                    }
                    .frame(width: self.proien > 85 ? CGFloat(85) : CGFloat(self.proien), height: 12)
                    .background(.white.opacity(0.75))
                    .cornerRadius(15)
                    
                    Text("\(self.proien) g")
                        .font(.custom("Oswald-Regular", size: 15))
                        .foregroundStyle(.white)
                }
                .padding(.horizontal, 5)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                
                // ye carbs wala
                HStack {
                    Text("C")
                        .font(.custom("Oswald-Regular", size: 15))
                        .foregroundStyle(.white)
                    HStack {
                        
                    }
                    .frame(width: self.carbs > 85 ? CGFloat(85) : CGFloat(carbs), height: 12)
                    .background(.white.opacity(0.75))
                    .cornerRadius(15)
                    
                    Text("\(self.carbs) g")
                        .font(.custom("Oswald-Regular", size: 15))
                        .foregroundStyle(.white)
                }
                .padding(.horizontal, 5)
                .frame(maxWidth: .infinity, alignment: .leading)
                .offset(y: -10)
                
                // ye fats wala
                HStack {
                    Text("F")
                        .font(.custom("Oswald-Regular", size: 15))
                        .foregroundStyle(.white)
                    HStack {
                        
                    }
                    .frame(width: self.fats > 85 ? CGFloat(85) : CGFloat(self.fats), height: 12)
                    .background(.white.opacity(0.75))
                    .cornerRadius(15)
                    
                    Text("\(self.fats) g")
                        .font(.custom("Oswald-Regular", size: 15))
                        .foregroundStyle(.white)
                }
                .padding(.horizontal, 5)
                .frame(maxWidth: .infinity, alignment: .leading)
                .offset(y: -20)
            }
            .offset(y: 15)
            
            Text("\(self.caloriesIngested) kCal")
                .font(.custom("Oswald-Regular", size: 30))
                .foregroundStyle(.white.opacity(0.7))
                .frame(maxWidth: .infinity, alignment: .leading)
                .offset(y: -15)
            
        }
        .padding(15)
        .frame(width: 173, height: 190)
        .background(
            LinearGradient(gradient: Gradient(colors: [Color("AppGreenLight"), Color("AppGreenDark")]), startPoint: .top, endPoint: .bottom)
        )
        .cornerRadius(16)
    }
}


struct TertiaryHeading: View {
    
    var titleHeading: String
    var secondaryHeading: String
    var bottomSpace: Bool
    
    var body: some View {
        HStack(alignment: .bottom) {
            Text(titleHeading)
                .font(.system(size: 35, weight: .light, design: .rounded))
                .foregroundStyle(.white)
            
            Text("( \(secondaryHeading) )")
                .font(.system(size: 20, weight: .light, design: .rounded))
                .foregroundStyle(.white.opacity(0.16))
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 23)
        .padding(.top, 37)
        .padding(.bottom, self.bottomSpace ? 21 : 0)
    }
}

