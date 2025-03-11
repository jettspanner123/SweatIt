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
            VStack(spacing: 5) {
                Text(self.challenge.challengeName)
                    .font(.custom(ApplicationFonts.oswaldRegular, size: 15))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(self.challenge.challengeDescription)
                    .font(.system(size: 12, weight: .regular, design: .rounded))
                    .foregroundStyle(.white.opacity(0.5))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)
                
                Spacer()
                
                HStack {
                    
                    Text(self.challenge.challengeDifficulty.rawValue)
                        .font(.system(size: 12, weight: .regular, design: .rounded))
                        .foregroundStyle(.white)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 3)
                        .background(self.challenge.challengeDifficulty == .hard ? ApplicationLinearGradient.redGradient : self.challenge.challengeDifficulty == .medium ? ApplicationLinearGradient.goldenGradient : ApplicationLinearGradient.greenGradient)
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                    
                    
                    Text(ApplicationHelper.getTimeFromDate(self.challenge.duration))
                        .font(.system(size: 12, weight: .regular, design: .rounded))
                        .foregroundStyle(.white)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 3)
                        .background(ApplicationLinearGradient.thanosGradient)
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding()

            // MARK: Image view
            HStack {
                Image(self.challenge.challengeImage)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.white.opacity(0.08))
        }
        .frame(maxWidth: .infinity)
        .background(.darkBG.opacity(0.54))
        .overlay {
            defaultShape
                .stroke(.white.opacity(0.18))
        }
        .clipShape(defaultShape)
        .overlay {
            HStack {
                Image(systemName: "ellipsis")
                    .scaleEffect(0.75)
                    .foregroundStyle(.white.opacity(0.75))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            .padding(25)
        }
        
    }
}
