//
//  ActivityQuestionnaireScreen.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 22/03/25.
//

import SwiftUI

struct ActivityQuestionnaireScreen: View {
    
    
    @State var selectedHour: Int = 0
    
    let dialText: Array<Int> = [1,2,3,4,5,6,7,8,9,10,11,12]
    
    
    var body: some View {
        VStack {
            Text("Please select how many times you are active through the week.")
                .font(.system(size: 15, weight: .regular, design: .rounded))
                .foregroundStyle(.white.opacity(0.5))
            
            GeometryReader {
                let readerSize = $0.size
                let verticalPadding = readerSize.height / 2
               
                ScrollView {
                    VStack {
                        ForEach(0...(ApplicationConstants.workoutTimeEachDatMaxLimit * 7), id: \.self) { index in
                            Text("\(index)")
                                .font(.system(size: self.selectedHour == index ? 50 : 15, weight: .bold, design: .rounded))
                                .foregroundStyle(self.selectedHour == index ? .white : .white.opacity(0.5))
                                .frame(height: 50)
                        }
                    }
                    .frame(width: readerSize.width)
                    .scrollTargetLayout()
                }
                .safeAreaPadding(.vertical, verticalPadding)
                .scrollTargetBehavior(.viewAligned)
                .overlay(alignment: .center) {
                    HStack(spacing: 100) {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(ApplicationLinearGradient.redGradient)
                            .frame(width: 100, height: 3)
                        
                        RoundedRectangle(cornerRadius: 8)
                            .fill(ApplicationLinearGradient.redGradient)
                            .frame(width: 100, height: 3)
                    }
                    .frame(maxWidth: .infinity)
                }
                .scrollPosition(id: .init(get: {
                    let position: Int? = self.selectedHour
                    return position
                }, set: { newValue in
                    if let newValue {
                        withAnimation(.bouncy) {
                            self.selectedHour = newValue
                        }
                    }
                }))
            }
            
        }
        .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
        .padding(.vertical, ApplicationPadding.mainScreenVerticalPadding)
        .sensoryFeedback(.impact, trigger: self.selectedHour)
    }
}

