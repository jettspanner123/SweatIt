//
//  PageNavigationBar.swift
//  SweatIt
//
//  Created by Uddeshya Singh on 19/01/25.
//

import SwiftUI

struct PageNavigationBar: View {
    
    @Binding var currentPage_t: Int
    var currentPage: String
    var wantOffset: Bool = true
    
    var homeScreenAction: () -> Void
    var workoutScreenAction: () -> Void
    var coachScreenAction: () -> Void
    var dietScreenAction: () -> Void
    var profileScreenAction: () -> Void


    var body: some View {
        HStack {
            
            // THe home icon
            VStack(spacing: 7) {
                Image("Home")
                    .resizable()
                    .frame(width: 58.5, height: 45)
                
                Text("Home")
                    .font(.system(size: 12, weight: .regular, design: .rounded))
                    .foregroundStyle(.white)
            }
            .opacity(self.currentPage == "Home" ? 1 : 0.5)
            .offset(y: -5)
            .onTapGesture {
                currentPage_t = 0
                self.homeScreenAction()
            }
            
            // The workout icon
            VStack(spacing: 7) {
                Image("Workout")
                    .resizable()
                    .frame(width: 63.25, height: 45)
                
                Text("Workout")
                    .font(.system(size: 12, weight: .regular, design: .rounded))
                    .foregroundStyle(.white)
            }
            .opacity(self.currentPage == "Workout" ? 1 : 0.5)
            .offset(y: -5)
            .onTapGesture {
                currentPage_t = 1
                self.workoutScreenAction()
            }
            
            // The coach icon
            VStack(spacing: 7) {
                Image("Training")
                    .resizable()
                    .frame(width: 58.5, height: 45)
                
                Text("Coach")
                    .font(.system(size: 12, weight: .regular, design: .rounded))
                    .foregroundStyle(.white)
            }
            .opacity(self.currentPage == "Coach" ? 1 : 0.5)
            .offset(y: -5)
            .onTapGesture {
                currentPage_t = 2
                self.coachScreenAction()
            }
            
            
            
            // The Diet icon
            VStack(spacing: 7) {
                Image("DietPageIcon")
                    .resizable()
                    .frame(width: 65.56, height: 45)
                
                Text("Diet")
                    .font(.system(size: 12, weight: .regular, design: .rounded))
                    .foregroundStyle(.white)
            }
            .opacity(self.currentPage == "Diet" ? 1 : 0.5)
            .offset(y: -5)
            .onTapGesture {
                currentPage_t = 3
                self.dietScreenAction()
            }
            
            
            // The user icon
            VStack(spacing: 7) {
                Image("User")
                    .resizable()
                    .frame(width: 58.5, height: 45)
                
                Text("Profile")
                    .font(.system(size: 12, weight: .regular, design: .rounded))
                    .foregroundStyle(.white)
            }
            .opacity(self.currentPage == "Profile" ? 1 : 0.5)
            .offset(y: -5)
            .onTapGesture {
                currentPage_t = 4
                self.profileScreenAction()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 118)
        .background(AppBackgroundBlur(radius: 100, opaque: true))
        .background(Color("DarkBG").opacity(0.76))
        .cornerRadius(30)
        .offset(y: wantOffset ? 407 : 0)
    }
}
