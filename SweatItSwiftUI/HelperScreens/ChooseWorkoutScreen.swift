//
//  ChooseWorkoutScreen.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 26/03/25.
//

import SwiftUI

struct ChooseWorkoutScreen: View {
    
    
//    @State var currentSelectedMuscles: Array<Extras.Muscle> = [.bicep]
    @State var currentSelectedMuscles: Dictionary<Extras.Muscle, Double> = [
        .bicep: 1,
    ]
    
    @State var temPvalue: Double = 0

    var body: some View {
        ScreenBuilder {
            AccentPageHeader(pageHeaderTitle: "Custom Workout")
            
            
            ScrollContentView {
                Text("Choose what muscles you want to hit with the workout, and also choose how many exercises do you want in the workout.")
                    .font(.system(size: 12, weight: .regular, design: .rounded))
                    .foregroundStyle(.white.opacity(0.5))
                    .takeMaxWidthLeading()
                
                
                
                
                SectionHeader(text: "Choose Muscles")
                    .padding(.top, 25)
                
                ForEach(Extras.Muscle.allCases, id: \.self) { muscle in
                    Text(muscle.rawValue)
                        .font(.system(size: 15, weight: .regular, design: .rounded))
                        .foregroundStyle(self.currentSelectedMuscles.keys.contains(muscle) ? .white : .white.opacity(0.5))
                        .frame(maxWidth: .infinity)
                        .frame(height: 40)
                        .overlay {
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(.white.opacity(0.08))
                        }
                        .background(self.currentSelectedMuscles.keys.contains(muscle) ? ApplicationLinearGradient.blueGradientInverted : ApplicationLinearGradient.darkBGSameGradientWithOpacityHalf, in: RoundedRectangle(cornerRadius: 8))
                        .onTapGesture {
                            withAnimation {
                                if self.currentSelectedMuscles.keys.contains(muscle) {
                                    self.currentSelectedMuscles.removeValue(forKey: muscle)
                                } else {
                                    self.currentSelectedMuscles[muscle] = 1
                                }
                            }
//
                        }
                }
                
                SectionHeader(text: "Choose Exercise Count")
                    .padding(.top, 25)
                
                ForEach(Extras.Muscle.allCases, id: \.self) { muscle in
                    if self.currentSelectedMuscles.keys.contains(muscle) {
                        Stepper("\(muscle.rawValue)", value: self.$temPvalue)
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .overlay {
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(.white.opacity(0.18))
                            }
                            .background(.darkBG.opacity(0.54), in: RoundedRectangle(cornerRadius: 8))
                    }
                    
                }
                
                
                
            }
            .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
        }
    }
}

#Preview {
    ChooseWorkoutScreen()
}
