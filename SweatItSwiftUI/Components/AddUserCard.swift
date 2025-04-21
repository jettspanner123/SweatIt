//
//  AddUserCard.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 17/04/25.
//

import SwiftUI

struct AddUserCard: View {
    var user: User_t
    
    var profileViewText: String {
        return self.user.fullName.split(separator: " ").map { String($0.first!) }.joined()
    }
    var body: some View {
        HStack {
            
            
            // MARK: Profile icon
            HStack {
                Text(self.profileViewText)
                    .font(.custom(ApplicationFonts.oswaldRegular, size: 20))
                    .foregroundStyle(.white)
            }
            .frame(width: 60, height: 60)
            .background(ApplicationLinearGradient.blueGradientInverted, in: Circle())
            .padding(.horizontal)
            
            
            
            // MARK: Details
            
            VStack {
                Text(self.user.fullName)
                    .font(.system(size: 13, weight: .medium, design: .rounded))
                    .foregroundStyle(.white.opacity(0.75))
                    .takeMaxWidthLeading()

                Text(self.user.username)
                    .font(.system(size: 11, weight: .regular, design: .rounded))
                    .foregroundStyle(.white.opacity(0.5))
                    .takeMaxWidthLeading()
                
                Spacer()
                
                Text("\(self.user.dailyPoints)🔥")
                    .font(.system(size: 11, weight: .regular, design: .rounded))
                    .foregroundStyle(.white.opacity(0.5))
                    .takeMaxWidthLeading()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding(.vertical, 15)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(height: 80)
        .overlay {
            defaultShape
                .stroke(.white.opacity(0.08))
        }
        .background(.darkBG.opacity(0.54), in: defaultShape)
        .overlay(alignment: .trailing) {
            HStack {
                HStack {
                    Image(systemName: "person.fill.badge.plus")
                        .foregroundStyle(.white)
                }
                .frame(width: 60, height: 35)
                .background(ApplicationLinearGradient.redGradient, in: Capsule())
                .onTapWithScaleVibrate {
                    print("Add friend")
                }
                
                Image(systemName: "chevron.right")
                    .foregroundStyle(.white.opacity(0.5))
                    .scaleEffect(0.75)
            }
            .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
        }
    }
}


