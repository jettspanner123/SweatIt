//
//  ContentView.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 09/03/25.
//

import SwiftUI
import SwiftData

class AnimatedNamespaceCoordinator: ObservableObject {
    public var current = AnimatedNamespaceCoordinator()
    @Namespace var animatedNamespace
}




struct ContentView: View {
    
    
    @State var currentPage_t: PageNavigationBar.PageNavigationOptions = .diet
    
    @State var showCameraScreen: Bool = false
    @State var showNotificationCenter: Bool = false
    
    @AppStorage("isUserLoggedIn") var isUserLoggedIn: Bool = true
    @State var currentUser: User_t = User.current.currentUser
    
    @State var showIsland: Bool = false
    
    @State var showAddAgendaPage: Bool = false
    
    
    @State var AgendaToday: Array<Agenda_t> = Agenda.current.exampleAgendaList
    
    
    
    
    var body: some View {
        NavigationStack {
            ScreenBuilder {
                if !self.isUserLoggedIn {
                    LoginScreen(showLoginScreen: self.$isUserLoggedIn, showIsland: self.$showIsland)
                        .zIndex(99999)
                        .transition(ScaleBlurOffsetTransition())
                }
                
                CustomDynamicIsland(showIsland: self.$showIsland, color: .green)
                    .zIndex(.infinity)
                
                if self.showAddAgendaPage {
                    AddAgendaScreen(showAddAgendaScreen: self.$showAddAgendaPage, agendaList: self.$AgendaToday)
                        .transition(.offset(y: UIScreen.main.bounds.height))
                        .zIndex(9999)
                }
                
                if self.showNotificationCenter {
                    NotificationCenterScreen(showNotificationCenter: self.$showNotificationCenter)
                        .transition(.offset(y: UIScreen.main.bounds.height))
                        .zIndex(9999)
                }
                
                if self.showCameraScreen {
                    FoodScannerScreen(showCameraScreen: self.$showCameraScreen)
                        .transition(.offset(y: UIScreen.main.bounds.height))
                        .zIndex(.infinity)
                }
                
                PageHeader(pageHeaderTitle: self.currentPage_t == .home ? "Home" : self.currentPage_t == .workout ? "Workout" : self.currentPage_t == .coach ? "Coach" : self.currentPage_t == .diet ? "Diet" : "Profile", notificationAction: {
                    withAnimation(.smooth) {
                        self.showNotificationCenter = true
                    }
                }, logoutAction: {
                    withAnimation(.smooth(duration: 1.5)) {
                        self.isUserLoggedIn = false
                    }
                })
                .offset(y: self.showNotificationCenter || self.showCameraScreen || self.showAddAgendaPage ? -50 : 0)
                .blur(radius: self.showNotificationCenter || self.showCameraScreen || self.showAddAgendaPage ? 10 : 0)
                
                if self.currentPage_t == .home {
                    HomeScreen(showAddAgendaPage: self.$showAddAgendaPage, AgendaToday: self.$AgendaToday)
                        .offset(y: self.showNotificationCenter || self.showAddAgendaPage ? -50 : 0)
                        .blur(radius: self.showNotificationCenter || self.showAddAgendaPage ? 10 : 0)
                        .transition(.blurReplace)
                } else if self.currentPage_t == .workout {
                    WorkoutScreen()
                        .transition(.blurReplace)
                } else if self.currentPage_t == .coach {
                    CoachScreen()
                        .transition(.blurReplace)
                } else if self.currentPage_t == .diet {
                    DietScreen(showCameraScreen: self.$showCameraScreen)
                        .offset(y: self.showCameraScreen ? -50 : 0)
                        .blur(radius: self.showCameraScreen ? 10 : 0)
                        .transition(.blurReplace)
                } else {
                    ProfileScreen(user: $currentUser)
                        .transition(.blurReplace)
                }
                
                PageNavigationBar(currentPage_t: self.$currentPage_t)
                    .blur(radius: self.showNotificationCenter || self.showAddAgendaPage ? 10 : 0)
            }
            .coordinateSpace(name: "MainScreenCoordinateSpace")
        }
        .onAppear {
            withAnimation {
                self.isUserLoggedIn = false
            }
        }
        .sensoryFeedback(.impact, trigger: self.currentPage_t)
        
    }
}


struct ContentViewPreviewProvider: PreviewProvider {
    static let appStates: ApplicationStates = .init()
    
    static var previews: some View {
        ContentView()
            .environmentObject(self.appStates)
    }
    
}
