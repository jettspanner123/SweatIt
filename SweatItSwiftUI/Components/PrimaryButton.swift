//
//  PrimaryButton.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 09/03/25.
//

import SwiftUI

struct PrimaryNavigationButton: View {
    var text: String = ""
    var leadingPadding: Double = 15
    var trailingPadding: Double = 15
    var action: () -> Void = {}
    
    var body: some View {
        HStack {
            Spacer()
            Text(self.text)
                .font(.custom(ApplicationFonts.oswaldRegular, size: 15))
                .foregroundStyle(.white.opacity(0.75))
            
            Spacer()
            HStack {
                
                Image(systemName: "chevron.right")
                    .scaleEffect(0.75)
                    .foregroundStyle(.white)
            }
            .frame(width: 30, height: 30)
            .background(.darkBG.opacity(0.25))
            .clipShape(Circle())
            .padding(.vertical, 15)
        }
        .frame(maxWidth: .infinity)
        .padding(.leading, self.leadingPadding)
        .padding(.trailing, self.trailingPadding)
        
    }
}

