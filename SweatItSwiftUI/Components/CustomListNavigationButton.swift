//
//  CustomListNavigationButton.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 25/04/25.
//

import SwiftUI

struct CustomListNavigationButton: View {
    
    var image: String
    var name: String
    
    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: self.image)
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundStyle(.white.opacity(0.5))
            
            Text(self.name)
                .font(.system(size: 15, weight: .regular, design: .rounded))
                .foregroundStyle(.white.opacity(0.5))
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .scaleEffect(0.75)
                .foregroundStyle(.white.opacity(0.5))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 20)
        .padding(.vertical, 3)
    }
}
