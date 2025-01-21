//
//  AccentPageHeader.swift
//  SweatIt
//
//  Created by Uddeshya Singh on 20/01/25.
//

import SwiftUI

struct AccentPageHeader: View {
    
    var pageHeaderTitle: String
    var wantOffset: Bool = true
    var action: () -> Void
    
    var body: some View {
        HStack {
            ZStack {
                Image("BackPage")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .offset(x: -165)
                    .onTapGesture {
                        action()
                    }
                
                Text(pageHeaderTitle)
                    .font(.system(size: 35, weight: .light, design: .rounded))
                    .foregroundStyle(.white)
                
            }
            .offset(y: 25)
        }
        .frame(maxWidth: .infinity, maxHeight: 136)
        .border(.white.opacity(0.08), width: 1)
        .background(AppBackgroundBlur(radius: 50, opaque: true))
        .background(Color("DarkBG").opacity(0.55))
        .cornerRadius(20)
        .offset(y: wantOffset ? -426 : 0)
        .zIndex(100)
        
    }
}

