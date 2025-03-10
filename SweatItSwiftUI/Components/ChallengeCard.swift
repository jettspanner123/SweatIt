//
//  ChallengeCard.swift
//  SweatIt
//
//  Created by Uddeshya Singh on 20/01/25.
//

import SwiftUI

struct ChallengeViewCard: View {
    
    var challenge: Challenge_t
    
    var body: some View {
        HStack {
            
            // MARK: Content view
            HStack {
                Text(self.challenge.challengeName)
                    .font(.system(size: 15, weight: .medium, design: .rounded))
                    .foregroundStyle(.white)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding(20)
            
            // MARK: Exercise prview
            HStack {
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.white)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 200)
        .background(ApplicationLinearGradient.lavaGradient)
        .clipShape(defaultShape)
    }
}
