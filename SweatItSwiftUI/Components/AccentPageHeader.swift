//
//  AccentPageHeader.swift
//  SweatIt
//
//  Created by Uddeshya Singh on 20/01/25.
//

import SwiftUI

struct AccentPageHeader: View {
    
    var pageHeaderTitle: String
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        HStack {
            ZStack {
                Image(systemName: "chevron.left")
                    .foregroundStyle(.white)
                    .padding(20)
                    .background(.darkBG.opacity(0.001))
                    .onTapGesture {
                        self.dismiss()
                    }
                    .offset(x: -160, y: 10)

                Text(pageHeaderTitle)
                    .font(.system(size: 25, weight: .light, design: .rounded))
                    .foregroundStyle(.white)
                    .offset(y: 10)
                
            }
            .offset(y: 25)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 137)
        .background(AppBackgroundBlur(radius: 50, opaque: true))
        .background(Color("DarkBG").opacity(0.55))
        .overlay {
            RoundedRectangle(cornerRadius: 20)
                .stroke(.white.opacity(0.18))
        }
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .offset(y: -70)
        .zIndex(100)
        
    }
}

struct AccentPageHeader_NoAction: View {
    
    var pageHeaderTitle: String
    var icon: String = "chevron.left"
    
    var action: () -> Void = {}
    
    var body: some View {
        HStack {
            ZStack {
                Image(systemName: self.icon)
                    .foregroundStyle(.white)
                    .padding(20)
                    .background(.darkBG.opacity(0.001))
                    .onTapGesture {
                        self.action()
                    }
                    .offset(x: -160, y: 10)

                Text(pageHeaderTitle)
                    .font(.system(size: 25, weight: .light, design: .rounded))
                    .foregroundStyle(.white)
                    .offset(y: 10)
                
            }
            .offset(y: 25)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 137)
        .background(AppBackgroundBlur(radius: 50, opaque: true))
        .background(Color("DarkBG").opacity(0.55))
        .overlay {
            RoundedRectangle(cornerRadius: 20)
                .stroke(.white.opacity(0.18))
        }
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .offset(y: -70)
        .zIndex(100)
        
    }
}
