//
//  ContentView.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 09/03/25.
//

import SwiftUI
import SwiftData
import AVKit

class AnimatedNamespaceCoordinator: ObservableObject {
    public var current = AnimatedNamespaceCoordinator()
    @Namespace var animatedNamespace
}




struct ContentView: View {
    
    @EnvironmentObject var appStates: ApplicationStates
    
    @State var currentPage_t: PageNavigationBar.PageNavigationOptions = .home
    
    @State var showNotificationCenter: Bool = false
    
    @AppStorage("isUserLoggedIn") var isUserLoggedIn: Bool = false
    @State var currentUser: User_t = User.current.currentUser
    
    @State var showIsland: Bool = false
    
    @State var showAddAgendaPage: Bool = false
    
    @State var showScannedFoodDetailScreen: Bool = false
    
    @State var showSplashScreen: Bool = true
    
    
    
    
    @State var AgendaToday: Array<Agenda_t> = Agenda.current.exampleAgendaList
    func cleanResponse(jsonString: String) -> String {
        if jsonString.hasPrefix("```json") {
            let index = jsonString.index(jsonString.startIndex, offsetBy: 8) // 5 chars to skip "json:"
            let toIndex = jsonString.index(jsonString.endIndex, offsetBy: -5)
            return String(jsonString[index...toIndex]).trimmingCharacters(in: .whitespacesAndNewlines)
        }
        return jsonString
    }
    
    var body: some View {
        NavigationStack {
            ScreenBuilder {
                if self.isUserLoggedIn == false {
                    LoginScreen(isUserLoggedIn: self.$isUserLoggedIn ,showLoginScreen: self.$isUserLoggedIn, showIsland: self.$showIsland)
                        .zIndex(99999)
                        .transition(ScaleBlurOffsetTransition())
                }
                
                if self.appStates.isDataLoading && self.isUserLoggedIn {
                    DynamicLoadingScreen(showSplashScreen: self.$showSplashScreen)
                        .zIndex(.infinity)
                }
                
                
                if self.appStates.showScanFoodErrorDialogBox {
                    VStack {
                        VStack {
                            Text("No Food Item Found")
                                .font(.custom(ApplicationFonts.oswaldRegular, size: 25))
                                .foregroundStyle(.white)
                            
                            CustomDivider()
                            
                            Text("There was an error scanning food items, either there is no food items in the screen or the scanner is not working properly.")
                                .font(.system(size: 13, weight: .regular, design: .rounded))
                                .foregroundStyle(.white.opacity(0.75))
                                .multilineTextAlignment(.center)
                            
                            SimpleButton(content: {
                               Text("I Understand")
                                    .font(.system(size: 13, weight: .medium, design: .rounded))
                                    .foregroundStyle(.white)
                            }, backgroundLinearGradient: ApplicationLinearGradient.thanosGradient, some: {
                                self.appStates.scannedFoodDetail = ""
                                withAnimation {
                                    self.appStates.showScanFoodErrorDialogBox = false
                                }
                            })
                            .padding(.top)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.darkBG, in: defaultShape)
                    }
                    .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .zIndex(ApplicationBounds.dialogBoxZIndex)
                    .transition(.offset(y: UIScreen.main.bounds.height))
                }
                
                if self.appStates.showScanFoodErrorDialogBox {
                    CustomBackDrop()
                }
                
                if self.appStates.isFoodScannerLoading {
                    FullScreenLoadingView()
                        .transition(.blurReplace)
                }
                
                if self.appStates.isFoodScannerLoading {
                    CustomBackDrop()
                }
                
                if self.appStates.showFoodDetails {
                    FoodDetailScreen(food: self.appStates.currentSelectedFood!, showFoodDetailsScreen: self.$appStates.showFoodDetails)
                        .zIndex(ApplicationBounds.dialogBoxZIndex)
                        .transition(.offset(y: UIScreen.main.bounds.height))
                }
                
                if self.appStates.showFoodDetails {
                    CustomBackDrop()
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
                
                FoodScannerScreen()
                    .zIndex(.infinity)
                    .offset(y: self.appStates.showCameraScreen ? 0 : UIScreen.main.bounds.height)
                
                PageHeader(pageHeaderTitle: self.currentPage_t == .home ? "Home" : self.currentPage_t == .workout ? "Workout" : self.currentPage_t == .coach ? "Coach" : self.currentPage_t == .diet ? "Diet" : "Profile", notificationAction: {
                    withAnimation(.smooth) {
                        self.showNotificationCenter = true
                    }
                }, logoutAction: {
                    withAnimation(.smooth(duration: 1.5)) {
                        self.isUserLoggedIn = false
                    }
                })
                .offset(y: self.showNotificationCenter || self.appStates.showCameraScreen || self.showAddAgendaPage ? -50 : 0)
                .blur(radius: self.showNotificationCenter || self.appStates.showCameraScreen || self.showAddAgendaPage ? 10 : 0)
                
                if self.currentPage_t == .home {
                    HomeScreen(showAddAgendaPage: self.$showAddAgendaPage, AgendaToday: self.$AgendaToday)
                        .offset(y: self.showNotificationCenter || self.showAddAgendaPage || self.appStates.showCameraScreen ? -50 : 0)
                        .blur(radius: self.showNotificationCenter || self.showAddAgendaPage || self.appStates.showCameraScreen ? 10 : 0)
                        .transition(.blurReplace)
                } else if self.currentPage_t == .workout {
                    WorkoutScreen()
                        .transition(.blurReplace)
                } else if self.currentPage_t == .coach {
                    CoachScreen()
                        .transition(.blurReplace)
                } else if self.currentPage_t == .diet {
                    DietScreen()
                        .offset(y: self.appStates.showCameraScreen ? -50 : 0)
                        .blur(radius: self.appStates.showCameraScreen ? 10 : 0)
                        .transition(.blurReplace)
                } else {
                    ProfileScreen(user: $currentUser)
                        .transition(.blurReplace)
                }
                
                PageNavigationBar(currentPage_t: self.$currentPage_t)
                    .blur(radius: self.showNotificationCenter || self.showAddAgendaPage ? 10 : 0)
            }
            .coordinateSpace(name: "MainScreenCoordinateSpace")
            .navigationDestination(isPresented: self.$showScannedFoodDetailScreen) {
                ScannedFoodDetailScreen()
            }
        }
        .sensoryFeedback(.impact, trigger: self.currentPage_t)
        .onChange(of: self.appStates.scannedFoodDetail) {
            let scannedFoodDetails = self.cleanResponse(jsonString: self.appStates.scannedFoodDetail)
            if scannedFoodDetails == "null" {
                print("Found nothing")
                withAnimation {
                    self.appStates.showScanFoodErrorDialogBox = true
                }
                return
            } else if scannedFoodDetails.isEmpty {
                print("Emptied out 'self.appStates.scannedFoodDetail' variables because no food item was found")
                return
            } else {
                print("Found something")
                self.appStates.showScannedFoodDetailScreen = true
            }
        }
        .onChange(of: self.appStates.showScannedFoodDetailScreen) {
            self.showScannedFoodDetailScreen = self.appStates.showScannedFoodDetailScreen
        }
        .onChange(of: self.appStates.dailyEvents.mealsHad) {
            Task {
                try await ApplicationEndpoints.post.autoUpdateCurrentUserDailyEvents(for: self.appStates.dailyEvents)
            }
        }
        .onChange(of: self.appStates.dailyEvents.workoutsDone) {
            Task {
                try await ApplicationEndpoints.post.autoUpdateCurrentUserDailyEvents(for: self.appStates.dailyEvents)
            }
        }
        
    }
}


struct ContentViewPreviewProvider: PreviewProvider {
    static let appStates: ApplicationStates = .init()
    static let healthManager: HealthManager = .init()
    
    static var previews: some View {
        ContentView()
            .environmentObject(self.appStates)
            .environmentObject(self.healthManager)
    }
    
}

struct ScaleAndBlurTransition: Transition {
    func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .offset(y: phase.isIdentity ? 0 : -UIScreen.main.bounds.height - 40)
            .blur(radius: phase.isIdentity ? 0 : 15)
    }
    
}

struct FullScreenLoadingView: View {
    
    
    var body: some View {
        VStack {
            VStack {
                ProgressView()
                    .tint(.white)
                    .scaleEffect(1.5)
                    .offset(y: 8)
                
                
                Text("Analizing Food Data....")
                    .font(.system(size: 15, weight: .medium, design: .rounded))
                    .foregroundStyle(.white)
                    .padding(10)
                    .offset(y: 8)
            }
            .padding()
            .overlay {
                defaultShape
                    .stroke(.white.opacity(0.18))
            }
            .background(AppBackgroundBlur(radius: 100, opaque: true))
            .background(.darkBG.opacity(0.54))
            .clipShape(defaultShape)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding * 2)
        .zIndex(ApplicationBounds.dialogBoxZIndex)
        .ignoresSafeArea()
    }
}


