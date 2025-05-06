//
//  PageNavigationBar.swift
//  SweatIt
//
//  Created by Uddeshya Singh on 19/01/25.
//

import SwiftUI

struct PageNavigationBar: View {
    
    enum PageNavigationOptions {
        case home, workout, coach, diet, profile
    }
    
    
    @Binding var currentPage_t: PageNavigationOptions
    
    var homeScreenAction: () -> Void = {}
    var workoutScreenAction: () -> Void = {}
    var coachScreenAction: () -> Void = {}
    var dietScreenAction: () -> Void = {}
    var profileScreenAction: () -> Void = {}
    
    
    var body: some View {
        HStack {
            
            Spacer()
            
            // THe home icon
            VStack(spacing: 7) {
                Image("Home")
                    .resizable()
                    .frame(width: 48.5, height: 35)
                
                Text("Home")
                    .font(.system(size: 10, weight: .regular, design: .rounded))
                    .foregroundStyle(.white)
            }
            .opacity(self.currentPage_t == .home ? 1 : 0.5)
            .offset(y: -5)
            .onTapGesture {
                withAnimation(.smooth(duration: 0.2)) {
                    currentPage_t = .home
                }
                self.homeScreenAction()
            }
            
            
            Spacer()
            
            // The workout icon
            VStack(spacing: 7) {
                Image("Workout")
                    .resizable()
                    .frame(width: 53.25, height: 35)
                
                Text("Workout")
                    .font(.system(size: 10, weight: .regular, design: .rounded))
                    .foregroundStyle(.white)
            }
            .opacity(self.currentPage_t == .workout ? 1 : 0.5)
            .offset(y: -5)
            .onTapGesture {
                withAnimation(.smooth(duration: 0.2)) {
                    currentPage_t = .workout
                }
                self.workoutScreenAction()
            }
            
            Spacer()
            
            // The coach icon
            VStack(spacing: 7) {
                Image("Training")
                    .resizable()
                    .frame(width: 48.5, height: 35)
                
                Text("Coach")
                    .font(.system(size: 10, weight: .regular, design: .rounded))
                    .foregroundStyle(.white)
            }
            .opacity(self.currentPage_t == .coach ? 1 : 0.5)
            .offset(y: -5)
            .onTapGesture {
                withAnimation(.smooth(duration: 0.2)) {
                    currentPage_t = .coach
                }
                self.coachScreenAction()
            }
            
            
            Spacer()
            
            // The Diet icon
            VStack(spacing: 7) {
                Image("DietPageIcon")
                    .resizable()
                    .frame(width: 55.56, height: 35)
                
                Text("Diet")
                    .font(.system(size: 10, weight: .regular, design: .rounded))
                    .foregroundStyle(.white)
            }
            .opacity(self.currentPage_t == .diet ? 1 : 0.5)
            .offset(y: -5)
            .onTapGesture {
                withAnimation(.smooth(duration: 0.2)) {
                    currentPage_t = .diet
                }
                self.dietScreenAction()
            }
            
            Spacer()
            
            // The user icon
            VStack(spacing: 7) {
                Image("User")
                    .resizable()
                    .frame(width: 48.5, height: 35)
                
                Text("Profile")
                    .font(.system(size: 10, weight: .regular, design: .rounded))
                    .foregroundStyle(.white)
            }
            .opacity(self.currentPage_t == .profile ? 1 : 0.5)
            .offset(y: -5)
            .onTapGesture {
                withAnimation(.smooth(duration: 0.2)) {
                    currentPage_t = .profile
                }
                self.profileScreenAction()
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: 200, alignment: .top)
        .padding(.horizontal, 15)
        .padding(.top, 19)
        .background(AppBackgroundBlur(radius: 100, opaque: true))
        .background(Color("DarkBG").opacity(0.76))
        .overlay {
            RoundedRectangle(cornerRadius: 30)
                .stroke(.white.opacity(0.18))
        }
        .clipShape(RoundedRectangle(cornerRadius: 30))
        .visualEffect { view, phase in
            view
                .offset(y: phase.bounds(of: .named("MainScreenCoordinateSpace"))!.maxY - (70))
        }
    }
}
