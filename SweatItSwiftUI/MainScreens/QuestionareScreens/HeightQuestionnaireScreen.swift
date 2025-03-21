//
//  HeightQuestionnaireScreen.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 20/03/25.
//

import SwiftUI
import SwiftUITrackableScrollView

struct HeightQuestionnaireScreen: View {
    
    @Binding var currentSelectedSystem: Extras.MeasurenmentSystem
    
    enum HeightWeightSelectionOption: String, CaseIterable {
        case height = "Height", weight = "Weight"
    }
    
    struct HeightAdjustmentConfiguration {
        var steps: Int
        var count: Int
        var spacing: Int
    }
    
    var heightAdjustmentScrollViewConfiguration: HeightAdjustmentConfiguration = .init(steps: 10, count: 10, spacing: 10)
    
    @State var userHeight: Double = 0
    @State var userWeight: Double = 0
    @State var heightScrollOffset: Int = 0
    
    @State var vibrationState: Int = 0
    
    
    @State var currentSelectedState: HeightWeightSelectionOption = .height
    
    var heightOption: Array<Int> = [20, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 20]
    
    var body: some View {
        VStack {
            
            Text("Please select either the height bar or the weight bar first before entering your height or weight.")
                .font(.system(size: 15, weight: .regular, design: .rounded))
                .foregroundStyle(.white.opacity(0.5))
            
            
            
            
            
            
            
            // MARK: Filter option
            SectionHeader(text: "Choose Option")
                .padding(.top, 25)
            
            
            
            
            
            
            // MARK: Segmented controller
            HStack {
                
                
                
                
                
                
                // MARK: Height button
                HStack(spacing: 15) {
                    Image(systemName: "ruler.fill")
                        .foregroundStyle(self.currentSelectedState == .height ? .white : .white.opacity(0.5))
                    
                    
                    Spacer()
                    
                    if self.currentSelectedState == .height {
                        
                        Text(String(format: "%.f cm", self.userHeight))
                            .font(.system(size: 10, weight: .medium, design: .rounded))
                            .foregroundStyle(.white)
                            .transition(.offset(x: 50).combined(with: .blurReplace))
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
                .onTapGesture {
                    withAnimation {
                        self.currentSelectedState = .height
                    }
                }
                
                
                
                
                
                
                
                
                
                // MARK: Weight button
                HStack {
                    Image(systemName: "scalemass.fill")
                        .foregroundStyle(self.currentSelectedState == .weight ? .white : .white.opacity(0.5))
                    
                   
                    Spacer()
                    
                    if self.currentSelectedState == .weight {
                        
                        Text(String(format: "%.f kg", self.userWeight))
                            .font(.system(size: 10, weight: .medium, design: .rounded))
                            .foregroundStyle(.white)
                            .transition(.offset(x: 50).combined(with: .blurReplace))
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
                .onTapGesture {
                    withAnimation {
                        self.currentSelectedState = .weight
                    }
                }
                
            }
            .frame(maxWidth: .infinity)
            
            
            
            
            // MARK: Scroll karne pe value change hoinga
            VStack {
                
                
                // MARK: Height scroll view
                if self.currentSelectedState == .height {
                    GeometryReader {
                        let readerSize: CGSize = $0.size
                        let totalSteps: Int = self.heightAdjustmentScrollViewConfiguration.count * self.heightAdjustmentScrollViewConfiguration.steps
                        let verticalPadding = readerSize.height / 2
                        
                        ScrollView(.vertical, showsIndicators: false) {
                            VStack(spacing: CGFloat(self.heightAdjustmentScrollViewConfiguration.spacing)) {
                                ForEach(0...totalSteps, id: \.self) { index in
                                    Divider()
                                        .frame(width: index % self.heightAdjustmentScrollViewConfiguration.steps == 0 ? 60 : 30, height: 1)
                                        .background(index % self.heightAdjustmentScrollViewConfiguration.steps == 0 ? .white.opacity(0.75) : .white.opacity(0.5), in: .rect(cornerRadius: 8))
                                        .frame(maxWidth: .infinity, alignment: .trailing)
                                        .overlay {
                                            if index % self.heightAdjustmentScrollViewConfiguration.steps == 0 {
                                                HStack {
                                                    Text("\(index / self.heightAdjustmentScrollViewConfiguration.steps)")
                                                        .font(.system(size: 12, weight: .bold, design: .rounded))
                                                        .foregroundColor(.white)
                                                }
                                                .frame(maxWidth: .infinity, alignment: .trailing)
                                                .padding(.horizontal, 70)
                                            }
                                        }
                                    
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .safeAreaPadding(.vertical, verticalPadding)
                            .scrollTargetLayout()
                        }
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
                        .overlay(alignment: .trailing) {
                            let lbs = CGFloat(self.heightAdjustmentScrollViewConfiguration.steps) * CGFloat(self.heightScrollOffset)
                            
                            HStack(alignment: .bottom) {
                                Text(verbatim: "\(lbs)")
                                    .font(.system(size: 35, weight: .bold, design: .rounded))
                                    .foregroundStyle(.white)
                                    .contentTransition(.numericText(value: lbs))
                                    .animation(.snappy, value: lbs)
                                
                                Text("lbs")
                                    .font(.system(size: 25, weight: .bold, design: .rounded))
                                    .foregroundStyle(.white.opacity(0.5))
                                    .offset(y: -3)
                            }
                            .frame(maxWidth: .infinity)
                            .overlay(alignment: .bottom) {
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(.white)
                                    .frame(width: lbs > 100 ? 155 : 150, height: 2)
                                    .offset(x: 10)
                                    .animation(.snappy, value: lbs)
                            }
                            .offset(y: -(20))
                        }
                    }
                }
                
                
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.bottom, ApplicationPadding.mainScreenVerticalPadding / 1.8)
            .padding(.top, 10)
        
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(.top, ApplicationPadding.mainScreenVerticalPadding)
        .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
        .sensoryFeedback(.impact, trigger: self.vibrationState)
    }
}
