//
//  SweatItSwiftUIApp.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 09/03/25.
//

import SwiftUI
import SwiftData
import Firebase
import FirebaseFirestore
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
    
    
    @Published var workoutStatus: WorkoutState = .none {
        didSet {
            print("Application State Workout State Updated", workoutStatus.rawValue)
        }
    }
    
    @Published var currentSelectedFood: Food_t? = nil
    @Published var showFoodDetails: Bool = false
    
    @Published var currentSelectedFoodImage: Optional<UIImage> = nil
    @Published var showCameraScreen: Bool = false
    
    @Published var scannedFoodDetail: String = ""
    @Published var showScannerdFoodDetailScreen: Bool = false
    @Published var isFoodScannerLoading: Bool = false
    
    @Published var showScanFoodErrorDialogBox: Bool = false
    @Published var showScannedFoodDetailScreen: Bool = false
    
    @Published var textTransitionState: Int = 0
    
    @Published var dailyActivities: Array<Activity_t> = []
    
    @Published var dailyEvents: DailyEvents_t = .init() {
        didSet {
            for workout in self.dailyEvents.workoutsDone {
                if !self.dailyActivities.contains(where: { $0.id == workout.id }) {
                    self.dailyActivities.append(.init(id: workout.id, activityName: .workoutCompleted, activityDescription: workout))
                }
                
            }
            
            for meal in self.dailyEvents.mealsHad {
                if !self.dailyActivities.contains(where: { $0.id == meal.id }) {
                    self.dailyActivities.append(.init(id: meal.id, activityName: .mealEaten, activityDescription: meal))
                }
            }
            
            
            Task {
                try await ApplicationEndpoints.post.autoUpdateCurrentUserDailyEvents(for: self.dailyEvents)
            }
        }
    }
    @Published var dailyNeeds: DailyNeeds_t = .init()
    @Published var isDataLoading: Bool = true
    
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
    @StateObject var healthManager = HealthManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
//            OnboardingScreen()
//            WorkoutEngine(workout: Workout.current.armsWorkout)
//            RatingsScreen()
        }
        .environmentObject(self.appStates)
        .environmentObject(self.healthManager)
    }
}
