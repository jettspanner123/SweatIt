//
//  PageHeader.swift
//  SweatIt
//
//  Created by Uddeshya Singh on 19/01/25.
//

import SwiftUI


struct PageHeader: View {
    var pageHeaderTitle: String
    
    var notificationAction: () -> Void = {}
    var body: some View {
        HStack {
            
            Text(pageHeaderTitle)
                .font(.custom("Oswald-Regular", size: 40))
                .foregroundStyle(.white)
                .offset(x: 24, y: 25)
            
            
            Spacer()
            
            if self.pageHeaderTitle == "Home" {
                HStack {
                    Image("Fire")
                        .resizable()
                        .frame(maxWidth: 30, maxHeight: 30)
                        .frame(width: 50, height: 50)
                    
                    Image("Bell")
                        .resizable()
                        .frame(maxWidth: 30, maxHeight: 30)
                        .frame(width: 50, height: 50)
                        .background(.white.opacity(0.001))
                        .onTapGesture {
                            self.notificationAction()
                        }
                }
                .offset(x: -24, y: 30)
                .transition(.offset(x: 150))
                
            }
            
            if self.pageHeaderTitle == "Profile" || self.pageHeaderTitle == "Diet" {
                Image("Settings")
                    .resizable()
                    .frame(width: 34, height: 35)
                    .offset(x: -24, y: 30)
                    .transition(.offset(x: 150))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 137)
        .background(AppBackgroundBlur(radius: 50, opaque: true))
        .background(.darkBG.opacity(0.60))
        .overlay {
            RoundedRectangle(cornerRadius: 20)
                .stroke(.white.opacity(0.18))
        }
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .offset(y: -70)
        .zIndex(100)
    }
}

