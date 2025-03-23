//
//  FitnessLevelQuestionnaireScreen.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 23/03/25.
//

import SwiftUI

struct FitnessLevelQuestionnaireScreen: View {
    
    @State var currentSelectedFitnessLevel: Extras.UserLevel = .none
    
    @State var pullups: Int = 10
    @State var pushups: Int = 30
    @State var squats: Int = 50
    
    
    func changeFitnessScores() -> Void {
        switch self.currentSelectedFitnessLevel {
        case .beginner:
            withAnimation {
                self.pushups = 30
                self.pullups = 10
                self.squats = 30
            }
            
        case .intermediate:
            withAnimation {
                self.pushups = 50
                self.pullups = 15
                self.squats = 50
            }
            
        case .advanced:
            withAnimation {
                self.pushups = 75
                self.pullups = 25
                self.squats = 90
            }
            
        case .none:
            withAnimation {
                self.pushups = 0
                self.pullups = 0
                self.squats = 0
            }
        }
        
    }
    
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                
                
                
                VStack {
                    
                    
                    // MARK: Page heading
                    Text("Please select the option that best reflects your current fitness level, which includes some exercises.")
                        .font(.system(size: 12, weight: .regular, design: .rounded))
                        .foregroundStyle(.white.opacity(0.5))
                        .takeMaxWidthLeading()
                        .padding(.horizontal, 3)
                    
                    
                    
                    
                    // MARK: Level markers
                    
                    SectionHeader(text: "Fitness Scores")
                        .padding(.top, 25)
                    HStack {
                        
                        
                        // MARK: Pushup card
                        VStack {
                            Text("Pushups")
                                .font(.system(size: 12, weight: .medium, design: .rounded))
                                .foregroundStyle(.white.opacity(0.5))
                                .frame(maxWidth: .infinity)
                            
                            Spacer()
                            
                            Text("~\(self.pushups)")
                                .font(.system(size: 35, weight: .bold, design: .rounded))
                                .foregroundStyle(.white)
                                .contentTransition(.numericText(value: Double(self.pushups)))
                                .animation(.snappy, value: self.pushups)
                        }
                        .padding(.vertical)
                        .applicationDropDownButton()
                        
                        
                        
                        // MARK: Pullpus card
                        VStack {
                            Text("Pullups")
                                .font(.system(size: 12, weight: .medium, design: .rounded))
                                .foregroundStyle(.white.opacity(0.5))
                                .frame(maxWidth: .infinity)
                            
                            Spacer()
                            
                            Text("~\(self.pullups)")
                                .font(.system(size: 35, weight: .bold, design: .rounded))
                                .foregroundStyle(.white)
                                .contentTransition(.numericText(value: Double(self.pullups)))
                                .animation(.snappy, value: self.pullups)
                        }
                        .padding(.vertical)
                        .applicationDropDownButton()
                        
                        
                        // MARK: Squats card
                        VStack {
                            Text("Squats")
                                .font(.system(size: 12, weight: .medium, design: .rounded))
                                .foregroundStyle(.white.opacity(0.5))
                                .frame(maxWidth: .infinity)
                            
                            Spacer()
                            
                            Text("~\(self.squats)")
                                .font(.system(size: 35, weight: .bold, design: .rounded))
                                .foregroundStyle(.white)
                                .contentTransition(.numericText(value: Double(self.squats)))
                                .animation(.snappy, value: self.squats)
                        }
                        .padding(.vertical)
                        .applicationDropDownButton()
                        


                        
                        
                        
                    }
                    .frame(maxWidth: .infinity)
                    
                    
                    
                    
                    
                    
                    // MARK: Level options
                    
                    
                    SectionHeader(text: "Choose Fitness Level")
                        .padding(.top, 25)
                    
                    ForEach(Extras.UserLevel.allCases, id: \.self) { level in
                        if level != .none {
                            Text(level.rawValue)
                                .font(.system(size: 15, weight: .regular, design: .rounded))
                                .foregroundStyle(self.currentSelectedFitnessLevel == level ? .white : .white.opacity(0.5))
                                .frame(maxWidth: .infinity)
                                .frame(height: 40)
                                .background(self.currentSelectedFitnessLevel == level ? ApplicationLinearGradient.blueGradientInverted : ApplicationLinearGradient.darkBGSameGradientWithOpacityHalf)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(.white.opacity(0.18))
                                }
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                .onTapGesture {
                                    withAnimation {
                                        self.currentSelectedFitnessLevel = level
                                    }
                                }
                        }
                        
                    }
                }
                .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
                .padding(.vertical, ApplicationPadding.mainScreenVerticalPadding)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .onChange(of: self.currentSelectedFitnessLevel) {
            self.changeFitnessScores()
        }
        .sensoryFeedback(.impact, trigger: self.currentSelectedFitnessLevel)
    }
}

