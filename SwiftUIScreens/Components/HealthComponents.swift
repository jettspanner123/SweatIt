//
//  HealthComponents.swift
//  SweatIt
//
//  Created by Uddeshya Singh on 19/01/25.
//

import SwiftUI


struct CaloriesBurned: View {
    
    @State var caloriesBurned: Int
    var body: some View {
        ZStack {
            HStack(spacing: 11) {
                
                HStack {
                    Image("FireLogo")
                }
                .frame(width: 30, height: 30)
                .background(.white.opacity(0.17))
                .cornerRadius(100)
                
                Text("Burned")
                    .foregroundStyle(.white)
                    .font(.system(size: 20, weight: .regular, design: .rounded))
            }
            .offset(x: -20, y: -30)
            
            
            Text("\(caloriesBurned) kCal")
                .foregroundStyle(.white.opacity(0.75))
                .font(.custom("Oswald-Regular", size: 30))
                .offset(x: -22, y: 15)
            
            Text("🔥")
                .font(.system(size: 100))
                .opacity(0.28)
                .offset(x: 80, y:5)
        }
        .frame(maxWidth: (UIScreen.main.bounds.width / 2) - 30, maxHeight: 115)
        .background(
            LinearGradient(gradient: Gradient(colors: [Color("AppOrangeLight"), Color("AppOrangeDark")]), startPoint: UnitPoint(x: 0.5, y: 0), endPoint: UnitPoint(x: 0.5, y: 1))
        )
        .cornerRadius(17)
        
        
        
        
    }
}

struct WorkoutTiming: View {
    
    @State var workoutTiming: Int
    var body: some View {
        ZStack {
            HStack(spacing: 11) {
                
                HStack {
                    Image("Workout")
                        .resizable()
                        .frame(width: 20, height: 20)
                }
                .frame(width: 30, height: 30)
                .background(.white.opacity(0.17))
                .cornerRadius(100)
                
                Text("Workout")
                    .foregroundStyle(.white)
                    .font(.system(size: 20, weight: .regular, design: .rounded))
            }
            .offset(x: -20, y: -30)
            
            
            Text(">\(workoutTiming) Hr")
                .foregroundStyle(Color("AppBloodRedDark"))
                .font(.custom("Oswald-Regular", size: 30))
                .offset(x: -40, y: 15)
            
            
            Text("💪")
                .font(.system(size: 100))
                .opacity(0.28)
                .offset(x: 80, y:5)
        }
        .frame(maxWidth: (UIScreen.main.bounds.width / 2) - 30, maxHeight: 115)
        .background(
            LinearGradient(gradient: Gradient(colors: [Color("AppGreyLight"), .white]), startPoint: UnitPoint(x: 0.5, y: 0), endPoint: UnitPoint(x: 0.5, y: 1))
        )
        .cornerRadius(17)
        
        
    }
}



struct Hydrated: View {
    
    @State var waterAmount: Int
    var body: some View {
        ZStack {
            HStack(spacing: 11) {
                
                HStack {
                    Image("Water")
                }
                .frame(width: 30, height: 30)
                .background(.white.opacity(0.17))
                .cornerRadius(100)
                
                Text("Water")
                    .foregroundStyle(.white)
                    .font(.system(size: 20, weight: .regular, design: .rounded))
            }
            .offset(x: -20, y: -30)
            
            
            Text("\(waterAmount) mL")
                .foregroundStyle(.white.opacity(0.75))
                .font(.custom("Oswald-Regular", size: 30))
                .offset(x: -22, y: 15)
            
            Text("💧")
                .font(.system(size: 100))
                .opacity(0.28)
                .offset(x: 80, y:5)
        }
        .frame(maxWidth: (UIScreen.main.bounds.width / 2) - 30, maxHeight: 115)
        .background(
            LinearGradient(gradient: Gradient(colors: [Color("AppWaterLight"), Color("AppWaterDark")]), startPoint: UnitPoint(x: 0.5, y: 0), endPoint: UnitPoint(x: 0.5, y: 1))
        )
        .cornerRadius(17)
        
        
    }
}

struct CaloriesConsumed: View {
    
    @State var caloriesConsumed: Int
    @State var totalCalories: Int
    
    var body: some View {
        ZStack {
            HStack(spacing: 11) {
                
                HStack {
                    Image("Food")
                }
                .frame(width: 30, height: 30)
                .background(.white.opacity(0.17))
                .cornerRadius(100)
                
                Text("Consumed")
                    .foregroundStyle(.white)
                    .font(.system(size: 20, weight: .regular, design: .rounded))
            }
            .offset(x: -4, y: -30)
            
            
            HStack {
                Text("\(caloriesConsumed)")
                    .foregroundStyle(.white.opacity(0.75))
                    .font(.custom("Oswald-Regular", size: 30))
                
                Text("/")
                    .foregroundStyle(.white.opacity(0.75))
                    .font(.custom("Oswald-Regular", size: 30))
                
                Text("\(totalCalories)")
                    .foregroundStyle(.white.opacity(0.75))
                    .font(.custom("Oswald-Regular", size: 15))
                    .offset(y: 5)
            }
            .offset(y: 15)
            
            
            
            
            Text("🥦")
                .font(.system(size: 100))
                .scaleEffect(x: -1, y: 1, anchor: .center)
                .opacity(0.28)
                .offset(x: 80, y:20)
            
        }
        .frame(maxWidth: (UIScreen.main.bounds.width / 2) - 30, maxHeight: 115)
        .background(
            LinearGradient(gradient: Gradient(colors: [Color("AppGreenLight"), Color("AppGreenDark")]), startPoint: UnitPoint(x: 0.5, y: 0), endPoint: UnitPoint(x: 0.5, y: 1))
        )
        .cornerRadius(17)
        
        
    }
}

