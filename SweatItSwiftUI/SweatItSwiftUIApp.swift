//
//  SweatItSwiftUIApp.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 09/03/25.
//

import SwiftUI
import SwiftData
import Firebase

class ApplicationStates: ObservableObject {
    @Published var userData: SignUpUserDataStore = .init(username: "", password: "", email: "", age: 0, gender: .none, height: .zero, weight: .zero, bodyType: .none, activeDaysAWeek: 0, activeHoursADay: 1, region: "", foodBudged: .zero, phoneNumber: "")
    @Published var confirmPassword: String = ""

    @Published var isError: Bool = false
    @Published var isPasswordAndConfirmPasswordMatching: Bool = false
    
    public func showError() -> Void {
        withAnimation {
            self.isError = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            withAnimation {
                self.isError = false
            }
        }
    }
}

@main
struct SweatItSwiftUIApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    @StateObject var appStates = ApplicationStates()
    
    var body: some Scene {
        WindowGroup {
//            ContentView()
            LoginScreen(showLoginScreen: .constant(true), showIsland: .constant(false))
//            OnboardingScreen()
        }
        .environmentObject(self.appStates)
    }
}
