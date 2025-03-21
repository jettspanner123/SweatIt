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
    
    @State var userHeight: Double = 0
    @State var userWeight: Double = 0
    @State var heightOffset: CGSize = .zero
    @State var weightOffset: CGSize = .zero
    @State var scrollOffset_t: CGFloat = .zero
    @State var scrollOffset: CGFloat = .zero
    @State var heightToShow: String = "0ft 0in"
    @State var heightToShowCm: String = "0 cm"
    
    
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
                
                
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.white.opacity(0.18))
            .padding(.bottom, ApplicationPadding.mainScreenVerticalPadding / 1.8)
            .padding(.top, 10)
        
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(.top, ApplicationPadding.mainScreenVerticalPadding)
        .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
        .sensoryFeedback(.impact, trigger: self.currentSelectedState)
    }
}
