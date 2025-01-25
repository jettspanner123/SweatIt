//
//  PageHeader.swift
//  SweatIt
//
//  Created by Uddeshya Singh on 19/01/25.
//

import SwiftUI


struct PageHeader: View {
    var pageHeaderTitle: String
    var wantOffset: Bool = true
    var body: some View {
        HStack {
            
            Text(pageHeaderTitle)
                .font(.custom("Oswald-Regular", size: 50))
                .foregroundStyle(.white)
                .offset(x: 24, y: 20)
            
            
            Spacer()
            
            if self.pageHeaderTitle == "Home" {
                HStack {
                    Image("Fire")
                        .resizable()
                        .frame(maxWidth: 35, maxHeight: 35)
                    
                    Image("Bell")
                        .resizable()
                        .frame(maxWidth: 35, maxHeight: 35)
                }
                .offset(x: -24, y: 25)
                
            }
            
            if self.pageHeaderTitle == "Profile" {
                Image("Settings")
                    .resizable()
                    .frame(width: 34, height: 35)
                    .offset(x: -24, y: 25)
                
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 137)
        .border(.white.opacity(0.08), width: 1)
        .background(AppBackgroundBlur(radius: 50, opaque: true))
        .background(Color("DarkBG").opacity(0.60))
        .cornerRadius(20)
        .offset(y: wantOffset ? -424 : 0)
        .zIndex(100)
    }
}

#Preview {
    PageHeader(pageHeaderTitle: "Profile", wantOffset: false)
}

