//
//  ContentView.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 09/03/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    
    @State var currentPage_t: PageNavigationBar.PageNavigationOptions = .workout
    var body: some View {
        NavigationStack {
            ScreenBuilder {
                PageHeader(pageHeaderTitle: self.currentPage_t == .home ? "Home" : self.currentPage_t == .workout ? "Workout" : self.currentPage_t == .coach ? "Coach" : self.currentPage_t == .diet ? "Diet" : "Profile")
                
                
                if self.currentPage_t == .home {
                    HomeScreen()
                        .transition(.blurReplace)
                } else if self.currentPage_t == .workout {
                    WorkoutScreen()
                        .transition(.blurReplace)
                }
                
                PageNavigationBar(currentPage_t: self.$currentPage_t)
            }
            .coordinateSpace(name: "MainScreenCoordinateSpace")
        }
        
    }
}

#Preview {
    ContentView()
}
