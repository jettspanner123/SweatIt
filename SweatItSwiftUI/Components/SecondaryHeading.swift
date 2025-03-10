//
//  SecondaryHeading.swift
//  SweatIt
//
//  Created by Uddeshya Singh on 19/01/25.
//

import SwiftUI

struct SecondaryHeading: View {
    
    var title: String
    var body: some View {
        HStack {
            Text(title)
                .foregroundStyle(.white)
                .font(.system(size: 25, weight: .light, design: .rounded))
                .kerning(-1)
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 10)
    }
}
