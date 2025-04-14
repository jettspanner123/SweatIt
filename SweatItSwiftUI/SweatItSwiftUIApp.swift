//
//  SweatItSwiftUIApp.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 09/03/25.
//

import SwiftUI
import SwiftData
import Firebase
import TipKit

class ApplicationStates: ObservableObject {
    
    enum WorkoutState: String {
        case none = "None", started = "Started", ended = "Ended"
    }
    @Published var userData: SignUpUserDataStore = .init(fullName: "", username: "", password: "", email: "", age: 0, gender: .male, height: .zero, weight: .zero, bodyType: .none, activeDaysAWeek: 0, activeHoursADay: 1, region: "", foodBudged: .zero, phoneNumber: "", dob: .now) {
        didSet {
        }
    }
    @Published var confirmPassword: String = ""
    @Published var isUsernameAvailable: Bool = true

    @Published var isError: Bool = false
    @Published var isPasswordAndConfirmPasswordMatching: Bool = false
    @Published var showUsernameNotAvailable: Bool = false
    @Published var showPhoneNumberWrong: Bool = false
    @Published var showEmailIdNotValid: Bool = false
    @Published var showFullNameNotValid: Bool = false
    
    
    @Published var workoutStatus: WorkoutState = .none
    
    
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
        
        try? Tips.resetDatastore()
        try? Tips.configure()
    }
    
    @StateObject var appStates = ApplicationStates()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
//            OnboardingScreen()
//            WorkoutEngine(workout: Workout.current.armsWorkout)
//            RatingsScreen()
        }
        .environmentObject(self.appStates)
    }
}
