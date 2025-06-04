//
//  FoodRecommendationViewCardPlaceholder.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 04/06/25.
//

import SwiftUI

struct FoodRecommendationViewCardPlaceholder: View {
    var body: some View {
        HStack(spacing: 15) {
            
            // MARK: ICON
            HStack {
            }
            .frame(width: 70)
            .frame(maxHeight: .infinity)
            .background(.white.opacity(0.08), in: RoundedRectangle(cornerRadius: 8))
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(.white.opacity(0.1), lineWidth: 1)
            }
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .fill(.white.opacity(0.08))
                    .phaseAnimator([0.5, 0.25]) { content, phase in
                        content
                            .opacity(phase)
                    }
            }
            
            VStack {
                Text("Somehting I dont know")
                    .font(.system(size: 15))
                    .opacity(0)
                    .overlay {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(.white.opacity(0.08))
                    }
                    .takeMaxWidthLeading()
                
                
                HStack {
                    
                    Text(String(format: "%.f kCal", 140))
                        .font(.system(size: 13, weight: .regular, design: .rounded))
                        .foregroundStyle(.white)
                        .opacity(0)
                    
                    Text("🥬")
                        .font(.system(size: 10))
                        .opacity(0)

                }
                .frame(width: 60, alignment: .leading)
                .overlay {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(.white.opacity(0.08))
                }
                .padding(.bottom, 5)
                .offset(y: 5)
                .takeMaxWidthLeading()
                
                
                // MARK: FOod macros
                HStack {
                    HStack(spacing: 5) {
                        Text(String(format: "%.fg", 15))
                            .font(.custom(ApplicationFonts.oswaldRegular, size: 13))
                            .foregroundStyle(.white)
                        
                        Text("🍖")
                            .font(.system(size: 20))
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 3)
                    .background(.darkBG.opacity(0.54))
                    .overlay {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(.white.opacity(0.18))
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .opacity(0)
                    .overlay {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(.white.opacity(0.08))
                    }
                    
                    HStack(spacing: 5) {
                        Text(String(format: "%.fg", 50))
                            .font(.custom(ApplicationFonts.oswaldRegular, size: 13))
                            .foregroundStyle(.white)
                        
                        Text("🍞")
                            .font(.system(size: 20))
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 3)
                    .background(.darkBG.opacity(0.54))
                    .overlay {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(.white.opacity(0.18))
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .opacity(0)
                    .overlay {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(.white.opacity(0.08))
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 5)
                
                
                
                // MARK: Twin accept/decline button
                HStack {
                    HStack {
                       Text("Recommend")
                            .font(.system(size: 12, weight: .medium, design: .rounded))
                            .foregroundStyle(.white)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 35)
                    .background(ApplicationLinearGradient.greenGradient, in: RoundedRectangle(cornerRadius: 8))
                    .opacity(0)
                    .overlay {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(.white.opacity(0.08))
                    }
                    
                    HStack {
                       Text("Discourage")
                            .font(.system(size: 12, weight: .medium, design: .rounded))
                            .foregroundStyle(.white)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 35)
                    .background(ApplicationLinearGradient.redGradient, in: RoundedRectangle(cornerRadius: 8))
                    .opacity(0)
                    .overlay {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(.white.opacity(0.08))
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 5)
                
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding(.vertical, 5)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
        .padding(.vertical, 10)
        .background(.darkBG.opacity(0.54), in: defaultShape)
        .overlay {
            defaultShape
                .stroke(.white.opacity(0.08), lineWidth: 1)
        }
        .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
        .overlay {
            RoundedRectangle(cornerRadius: 17)
                .fill(.white.opacity(0.5))
                .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
                .phaseAnimator([0.25, 0.08]) { content, phase in
                    content
                        .opacity(phase)
                } 
        }
    }
}
