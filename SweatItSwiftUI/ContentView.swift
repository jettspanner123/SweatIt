//
//  ContentView.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 09/03/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    
    @State var currentPage_t: PageNavigationBar.PageNavigationOptions = .diet
    @State var showSplashScreen: Bool = true
    @State var showTransitionScree: Bool = true
    
    @State var showCameraScreen: Bool = false
    
    @State var currentUser: User_t = User.current.currentUser
    
    var body: some View {
        NavigationStack {
            ScreenBuilder {
                
                
//                // MARK: Splash screen effect hai bhai yaha pe
//                if self.showSplashScreen {
//                    SplashScreen()
//                        .zIndex(10000)
//                        .transition(.scale(170))
//                        .onAppear {
//                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                                withAnimation(.timingCurve(0.83, 0, 0.17, 1, duration: 2)) {
//                                    self.showSplashScreen = false
//                                }
//                            }
//                            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
//                                withAnimation {
//                                    self.showTransitionScree = false
//                                }
//                            }
//                        }
//                }
//                
//                if self.showTransitionScree {
//                    VStack {
//                        
//                    }
//                    .frame(maxWidth: .infinity, maxHeight: .infinity)
//                    .background(.white)
//                    .zIndex(9999)
//                }
                
                if self.showCameraScreen {
                    FoodScannerScreen(showCameraScreen: self.$showCameraScreen)
                        .transition(.offset(y: UIScreen.main.bounds.height))
                        .zIndex(9999)
                }
                
                PageHeader(pageHeaderTitle: self.currentPage_t == .home ? "Home" : self.currentPage_t == .workout ? "Workout" : self.currentPage_t == .coach ? "Coach" : self.currentPage_t == .diet ? "Diet" : "Profile")
                
                
                if self.currentPage_t == .home {
                    HomeScreen()
                        .transition(.blurReplace)
                } else if self.currentPage_t == .workout {
                    WorkoutScreen()
                        .transition(.blurReplace)
                } else if self.currentPage_t == .coach {
                    
                } else if self.currentPage_t == .diet {
                    DietScreen(showCameraScreen: self.$showCameraScreen)
                        .transition(.blurReplace)
                } else {
                    ProfileScreen(user: $currentUser)
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
