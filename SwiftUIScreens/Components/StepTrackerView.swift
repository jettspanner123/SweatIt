//
//  StepTrackerView.swift
//  SweatIt
//
//  Created by Uddeshya Singh on 20/01/25.
//

import SwiftUI

struct StepTrackerView: View {
    let steps: Int
    let caloriesBurned: Int
    let goalSteps: Int = 15000 // Assuming 10k steps as goal based on progress ring
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Step Tracker")
                .font(.system(size: 25, weight: .regular, design: .rounded))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            ZStack {
                // Background circle
                Circle()
                    .stroke(Color(.systemGray), lineWidth: 20)
                    .opacity(0.3)
                
                // Progress circle
                Circle()
                    .trim(from: 0, to: CGFloat(steps) / CGFloat(goalSteps))
                    .stroke(LinearGradient(gradient: Gradient(colors: [Color("AppGreenLight"), Color("AppGreenDark")]), startPoint: .leading, endPoint: .trailing), style: StrokeStyle(lineWidth: 30, lineCap: .round))
                    .rotationEffect(.degrees(-65))
                    .scaleEffect(x: -1, y: -1, anchor: .center)
                
                VStack(spacing: 10) {
                    // Walking figure icon
                    Image("Walking")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.white)
                    
                    // Steps count
                    Text("\(steps)")
                        .font(.custom("Oswald-Regular", size: 35))
                        .foregroundStyle(
                            LinearGradient(gradient: Gradient(colors: [Color("AppGreenLight"), Color("AppGreenDark")]), startPoint: .top, endPoint: .bottom)
                        )
                }
            }
            .frame(width: 250, height: 250)
            .padding(.top, 20)
            .padding(.bottom, 20)
            
            VStack(spacing: 8) {
                Text("Calories Burned")
                    .font(.system(size: 20, weight: .regular, design: .rounded))
                    .foregroundColor(.white.opacity(0.4))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack(spacing: 4) {
                    Text("\(caloriesBurned)")
                        .font(.custom("Oswald-Regular", size: 35))
                        .foregroundStyle(
                            LinearGradient(gradient: Gradient(colors: [Color("AppRedLight"), Color("AppRedDark")]), startPoint: .top, endPoint: .bottom)
                        )
                    
                    
                    Text("kCal")
                        .font(.custom("Oswald-Regular", size: 35))
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding(20)
        .frame(maxWidth: UIScreen.main.bounds.width * 0.9)
        .background(Color("DarkBG").opacity(0.54))
        .cornerRadius(20)
        .overlay {
            RoundedRectangle(cornerRadius: 20)
                .stroke(.white.opacity(0.1))
        }
        
    }
}

