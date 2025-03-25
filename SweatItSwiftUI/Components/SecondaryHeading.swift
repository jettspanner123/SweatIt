//
//  SecondaryHeading.swift
//  SweatIt
//
//  Created by Uddeshya Singh on 19/01/25.
//

import SwiftUI

struct SecondaryHeading: View {
    
    var title: String
    var secondaryText: String = ""
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 5) {
            Text(title)
                .foregroundStyle(.white)
                .font(.system(size: 23, weight: .light, design: .rounded))
                .kerning(-1)
           
            Text(self.secondaryText)
                .font(.system(size: 10, weight: .regular, design: .rounded))
                .foregroundStyle(.white.opacity(0.35))
                .kerning(-1)
                .offset(y: -4)
            
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 10)
    }
}
