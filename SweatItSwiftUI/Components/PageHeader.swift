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
    var logoutAction: () -> Void = {}
    var profileSettingsAction: () -> Void = {}
    var dietSettingsAction: () -> Void = {}
    @State var isRotating: Bool = false
    
    var body: some View {
        HStack {
            
            Text(pageHeaderTitle)
                .font(.custom("Oswald-Regular", size: 40))
                .foregroundStyle(.white)
                .offset(x: 24, y: 25)
            
            
            Spacer()
            
            if self.pageHeaderTitle == "Home" {
                HStack {
                    Image("Bell")
                        .resizable()
                        .frame(maxWidth: 30, maxHeight: 30)
                        .frame(width: 50, height: 50)
                        .background(.white.opacity(0.001))
                        .onTapGesture {
                            self.notificationAction()
                            ApplicationHelper.impactOccured(style: .light)
                        }
                }
                .offset(x: -24, y: 30)
                .transition(.offset(x: 150))
                
            }
            
            if self.pageHeaderTitle == "Profile" {
                HStack(spacing: 25) {
                    Image("Settings")
                        .resizable()
                        .frame(width: 34, height: 35)
                        .rotationEffect(.degrees(self.isRotating ? 9999 : 0))
                        .onTapGesture {
                            self.profileSettingsAction()
                            ApplicationHelper.impactOccured(style: .light)
                        }
                    
                    Image(systemName: "door.right.hand.open")
                        .scaleEffect(1.5)
                        .foregroundStyle(.white)
                        .onTapGesture {
                            self.logoutAction()
                            ApplicationHelper.impactOccured(style: .light)
                        }
                }
                .offset(x: -24, y: 30)
                .onAppear {
                    withAnimation(.linear(duration: 500).repeatForever()) {
                        self.isRotating = true
                    }
                }
                .transition(.offset(x: 300))
            }
            
            if self.pageHeaderTitle == "Diet" {
                HStack(spacing: 25) {
                    Image("Settings")
                        .resizable()
                        .frame(width: 34, height: 35)
                        .rotationEffect(.degrees(self.isRotating ? 9999 : 0))
                }
                .offset(x: -24, y: 30)
                .transition(.offset(x: 300))
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

