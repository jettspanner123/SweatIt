//
//  HeightQuestionnaireScreen.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 20/03/25.
//

import SwiftUI
import SwiftUITrackableScrollView

struct HeightQuestionnaireScreen: View {
    
    @EnvironmentObject var appStates: ApplicationStates
    
    @Binding var currentSelectedSystem: Extras.MeasurenmentSystem
    
    enum HeightWeightSelectionOption: String, CaseIterable {
        case height = "Height", weight = "Weight"
    }
    
    struct HeightAdjustmentConfiguration {
        var steps: Int
        var count: Int
        var spacing: Int
    }
    
    struct WeightAdjustmentConfiguration {
        var steps: Int
        var count: Int
        var spacing: Int
    }
    
    var heightAdjustmentScrollViewConfiguration: HeightAdjustmentConfiguration = .init(steps: 1, count: ApplicationConstants.heightScrollViewMaxLimit, spacing: 10)
    var weightAdjustmentScrollViewConfiguration: WeightAdjustmentConfiguration = .init(steps: 1, count: ApplicationConstants.weightScrollViewMaxLimit, spacing: 10)
    
    @State var userHeight: Double = 0
    @State var userWeight: Double = 0
    @State var heightScrollOffset: Int = 0
    @State var weightScrollOffset: Int = 0
    
    @State var vibrationState: Int = 0
    
    
    @State var currentSelectedState: HeightWeightSelectionOption = .height
    
    var heightOption: Array<Int> = [20, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 20]
    
    var body: some View {
        VStack {
            
            Text("Please select either the height bar or the weight bar first before entering your height or weight.")
                .font(.system(size: 12, weight: .regular, design: .rounded))
                .foregroundStyle(.white.opacity(0.5))
                .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
                .padding(.horizontal, -1)
            
            
            
            
            
            
            
            // MARK: Filter option
            SectionHeader(text: "Choose Option")
                .padding(.top, 25)
                .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
            
            
            
            
            
            // MARK: Segmented controller
            HStack {
                
                
                
                
                
                
                // MARK: Height button
                HStack(spacing: 15) {
                    Image(systemName: "ruler.fill")
                        .foregroundStyle(self.currentSelectedState == .height ? .white : .white.opacity(0.5))
                    
                    
                    Spacer()
                    
                    if self.currentSelectedState == .height {
                        
                        let heightInCm = CGFloat(self.heightScrollOffset) * CGFloat(self.heightAdjustmentScrollViewConfiguration.steps)
                        
                        if self.currentSelectedSystem == .imperial {
                            Text(String(format: "%.f cm", heightInCm))
                                .font(.system(size: 10, weight: .medium, design: .rounded))
                                .foregroundStyle(.white)
                                .contentTransition(.numericText(value: heightInCm))
                                .animation(.snappy, value: heightInCm)
                                .transition(.offset(x: 50).combined(with: .blurReplace))
                                .onChange(of: heightInCm) {
                                    self.userHeight = heightInCm
                                }
                        } else {
                            Text(ApplicationHelper.convertCmToFeetAndInches(cm: heightInCm))
                                .font(.system(size: 10, weight: .medium, design: .rounded))
                                .foregroundStyle(.white)
                                .contentTransition(.numericText(value: heightInCm))
                                .animation(.snappy, value: heightInCm)
                                .transition(.offset(x: 50).combined(with: .blurReplace))
                                .onChange(of: heightInCm) {
                                    self.userHeight = heightInCm
                                }
                        }
                        
                    }
                }
                .applicationDropDownButton(self.currentSelectedState == .height ? ApplicationLinearGradient.blueGradientInverted : ApplicationLinearGradient.darkBGSameGradientWithOpacityHalf, height: 40)
                .overlay {
                    HStack {
                        Text("Height")
                            .font(.system(size: 13, weight: .medium, design: .rounded))
                            .foregroundStyle(self.currentSelectedState == .height ? .white : .white.opacity(0.5))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 55)
                }
                .onTapWithScaleVibrate(scaleBy: 0.75) {
                    withAnimation {
                        self.currentSelectedState = .height
                    }
                    self.vibrationState = 0
                }
                
                
                
                
                
                
                
                
                // MARK: Weight button
                HStack {
                    Image(systemName: "scalemass.fill")
                        .foregroundStyle(self.currentSelectedState == .weight ? .white : .white.opacity(0.5))
                    
                    
                    Spacer()
                    
                    if self.currentSelectedState == .weight {
                        
                        let weightInPound = CGFloat(self.weightScrollOffset) * CGFloat(self.weightAdjustmentScrollViewConfiguration.steps)
                        if self.currentSelectedSystem == .metric {
                            Text(String(format: "%.f lbs", weightInPound))
                                .font(.system(size: 10, weight: .medium, design: .rounded))
                                .foregroundStyle(.white)
                                .transition(.offset(x: 50).combined(with: .blurReplace))
                                .contentTransition(.numericText(value: weightInPound))
                                .animation(.snappy, value: weightInPound)
                                .onChange(of: weightInPound) {
                                    self.userWeight = weightInPound
                                }
                        } else {
                            Text(String(format: "%.f kg", ApplicationHelper.toKg(lbs: weightInPound)))
                                .font(.system(size: 10, weight: .medium, design: .rounded))
                                .foregroundStyle(.white)
                                .transition(.offset(x: 50).combined(with: .blurReplace))
                                .contentTransition(.numericText(value: weightInPound))
                                .animation(.snappy, value: weightInPound)
                                .onChange(of: weightInPound) {
                                    self.userWeight = weightInPound
                                }
                        }
                    }
                }
                .applicationDropDownButton(self.currentSelectedState == .weight ? ApplicationLinearGradient.blueGradientInverted : ApplicationLinearGradient.darkBGSameGradientWithOpacityHalf, height: 40)
                .overlay {
                    HStack {
                        Text("Weight")
                            .font(.system(size: 13, weight: .medium, design: .rounded))
                            .foregroundStyle(self.currentSelectedState == .weight ? .white : .white.opacity(0.5))
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 50)
                }
                .onTapWithScaleVibrate(scaleBy: 0.75) {
                    withAnimation {
                        self.currentSelectedState = .weight
                    }
                    self.vibrationState = 0
                }
                
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
            
            
            // MARK: Scroll karne pe value change hoinga
            VStack {
                
                
                // MARK: Height scroll view
                if self.currentSelectedState == .height {
                    GeometryReader {
                        let readerSize = $0.size
                        let verticalPadding = readerSize.height / 2
                        
                        let heightInCm = CGFloat(self.heightScrollOffset) * CGFloat(self.heightAdjustmentScrollViewConfiguration.steps)
                        
                        // MARK: Actual scroll view here
                        ScrollView(.vertical, showsIndicators: false) {
                            VStack(alignment: .trailing, spacing: CGFloat(self.heightAdjustmentScrollViewConfiguration.spacing)) {
                                let totalSteps = self.heightAdjustmentScrollViewConfiguration.steps * self.heightAdjustmentScrollViewConfiguration.count
                                ForEach(0...totalSteps, id: \.self) { index in
                                    
                                    let isStep = index % 10 == 0
                                    Divider()
                                        .frame(width: isStep ? 60 : 30, height: 1)
                                        .background(isStep ? .white.opacity(0.75) : .white.opacity(0.5))
                                        .frame(maxWidth: .infinity, alignment: .trailing)
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .scrollTargetLayout()
                        }
                        .scrollIndicators(.hidden)
                        .scrollTargetBehavior(.viewAligned)
                        .scrollPosition(id: .init(get: {
                            let position: Int? = self.heightScrollOffset
                            return position
                        }, set: { newValue in
                            if let newValue {
                                self.heightScrollOffset = newValue
                                self.vibrationState = newValue
                            }
                        }))
                        .overlay {
                            HStack(spacing: 50) {
                                //                                let cm = CGFloat(self.heightScrollOffset) * CGFloat(self.heightAdjustmentScrollViewConfiguration.steps)
                                HStack(alignment: .bottom) {
                                    if self.currentSelectedSystem == .metric {
                                        Text(String(format: "%.f", heightInCm))
                                            .font(.system(size: 35, weight: .bold, design: .rounded))
                                            .foregroundStyle(.white)
                                        
                                    } else {
                                        Text(ApplicationHelper.convertCmToFeetAndInches(cm: heightInCm))
                                            .font(.system(size: 35, weight: .bold, design: .rounded))
                                            .foregroundStyle(.white)
                                            .frame(width: 150)
                                        
                                    }
                                    
                                    Text(self.currentSelectedSystem == .metric ? "cm" : "")
                                        .font(.system(size: 25, weight: .bold, design: .rounded))
                                        .foregroundStyle(.white.opacity(0.5))
                                        .offset(y: -3)
                                    
                                }
                                .offset(y: -10)
                                
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(ApplicationLinearGradient.redGradient)
                                    .frame(width: 63, height: 3)
                            }
                            .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                        .safeAreaPadding(.vertical, verticalPadding)
                    }
                    .transition(.offset(x: UIScreen.main.bounds.width / 2).combined(with: .blurReplace))
                } else {
                    
                    
                    // MARK: Weight scroll view
                    GeometryReader {
                        let readerSize = $0.size
                        let horizontalPadding = readerSize.width / 2
                        let verticalTextPading = readerSize.height / 2
                        
                        let weightInPound = CGFloat(self.weightScrollOffset) * CGFloat(self.weightAdjustmentScrollViewConfiguration.steps)
                        
                        // MARK: Weight trxt
                        HStack(alignment: .bottom) {
                            if self.currentSelectedSystem == .metric {
                                Text(String(format: "%.f", ApplicationHelper.toKg(lbs: weightInPound)))
                                    .font(.system(size: 35, weight: .bold, design: .rounded))
                                    .foregroundStyle(.white)
                            } else {
                                Text(String(format: "%.f", weightInPound))
                                    .font(.system(size: 35, weight: .bold, design: .rounded))
                                    .foregroundStyle(.white)
                            }
                            
                            Text(self.currentSelectedSystem == .metric ? "kg" : "lbs")
                                .font(.system(size: 25, weight: .bold, design: .rounded))
                                .foregroundStyle(.white.opacity(0.5))
                                .offset(y: -3)
                        }
                        .frame(maxWidth: .infinity)
                        .offset(y: verticalTextPading - (35 * 2) - (10))
                        
                        
                        
                        
                        // MARK: Actual scroll view here
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: CGFloat(self.weightAdjustmentScrollViewConfiguration.spacing)) {
                                let totalSteps = self.weightAdjustmentScrollViewConfiguration.steps * self.weightAdjustmentScrollViewConfiguration.count
                                
                                ForEach(0...totalSteps, id: \.self) { index in
                                    let isStep = index % 11 == 0
                                    
                                    Divider()
                                        .frame(width: 1, height: isStep ? 60 : 30)
                                        .background(isStep ? .white.opacity(0.75) : .white.opacity(0.5))
                                        .frame(maxHeight: 60, alignment: .bottom)
                                    
                                }
                            }
                            .frame(height: readerSize.height)
                            .scrollTargetLayout()
                        }
                        .scrollIndicators(.hidden)
                        .scrollTargetBehavior(.viewAligned)
                        .scrollPosition(id: .init(get: {
                            let position: Int? = self.weightScrollOffset
                            return position
                        }, set: { newValue in
                            if let newValue {
                                self.weightScrollOffset = newValue
                                self.vibrationState = newValue
                            }
                        }))
                        .overlay(alignment: .center) {
                            
                            RoundedRectangle(cornerRadius: 8)
                                .fill(ApplicationLinearGradient.redGradient)
                                .frame(width: 3, height: 63)
                        }
                        .safeAreaPadding(.horizontal, horizontalPadding)
                    }
                    .transition(.offset(y: UIScreen.main.bounds.height / 1.5).combined(with: .blurReplace))
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.bottom, ApplicationPadding.mainScreenVerticalPadding / 1.8)
            .padding(.top, 10)
            
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(.top, ApplicationPadding.mainScreenVerticalPadding)
        .onChange(of: self.userHeight) {
            self.appStates.userData.height = self.userHeight
        }
        .onChange(of: self.userWeight) {
            self.appStates.userData.weight = self.userWeight
        }
        .sensoryFeedback(.impact, trigger: self.vibrationState)
        .sensoryFeedback(.impact, trigger: self.currentSelectedState)
    }
}
