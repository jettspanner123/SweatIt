//
//  AvgStepsThisWeekGraph.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 25/04/25.
//

import SwiftUI

struct AvgStepsThisWeekGraph: View {
    var body: some View {
        HStack {
            
            VStack {
                
                // MARK: Heading
                Text("Avg Step Count")
                    .font(.custom(ApplicationFonts.oswaldRegular, size: 20))
                    .foregroundStyle(.white)
                    .takeMaxWidthLeading()
                
                Text("(this month)")
                    .font(.system(size: 12, weight: .regular, design: .rounded))
                    .foregroundStyle(.white.opacity(0.5))
                    .takeMaxWidthLeading()
                
                
                Spacer()
                // MARK: Step count
                Text("\(13900)")
                    .font(.custom(ApplicationFonts.oswaldSemiBold, size: 40))
                    .foregroundStyle(.white.opacity(0.5))
                    .takeMaxWidthLeading()
                    .offset(x: -3, y: 5)
                
                
                Text("steps")
                    .font(.system(size: 12, weight: .regular, design: .rounded))
                    .foregroundStyle(.white.opacity(0.5))
                    .takeMaxWidthLeading()
                
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            
            
            HStack {
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            
        }
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .frame(height: 200, alignment: .topLeading)
        .padding()
        .background(ApplicationLinearGradient.blueGradient, in: defaultShape)
    }
}
