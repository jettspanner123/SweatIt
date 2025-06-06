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
import Cloudinary

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
    @Published var isAskingToSignOut: Bool = false
    @Published var showUsernameNotAvailable: Bool = false
    @Published var showPhoneNumberWrong: Bool = false
    @Published var showEmailIdNotValid: Bool = false
    @Published var showFullNameNotValid: Bool = false
    
    
    @Published var workoutStatus: WorkoutState = .none
    
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
            
            
        }
    }
    
    @Published var dailyNeeds: DailyNeeds_t = .init()
    @Published var isDataLoading: Bool = true
    
    @Published var loadingFoodImage: Bool = false
    @Published var imageLoadingError: Bool = false
    
    public func toggleImageErrorState() -> Void {
        withAnimation {
            self.imageLoadingError = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            withAnimation {
                self.imageLoadingError = false
            }
        }
    }
    
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
    
    @Published var weeklyCaloriesBurned: Dictionary<Date, Double> = [:]
    @Published var weeklyWaterIntake: Dictionary<Date, Int> = [:]
    @Published var weeklyWorkoutTiming: Dictionary<Date, Double> = [:]
    @Published var weeklyMacroNutrients: Dictionary<Date, (protein: Double, carbs: Double, fats: Double, caloriesForTheDay: Double)> = [:]
    @Published var weeklyDailyEvents: Dictionary<Date, DailyEvents_t> = [:]
    
    
    // MARK: Recommended FOod Item
    @Published var recommendedFoodItems: Array<FoodItem> = []
    @Published var foodRecommendationLoading: Bool = false
    @Published var foodRecommendationError: Bool = false
    
    // MARK: ALready recommended food items
    @Published var alreadyRecommendedFoodItems: Array<Food_t> = []
}

@main
struct SweatItSwiftUIApp: App {
    
    
    // MARK: Cloudinary Cloud name = dqa9dgdso
    // MARK: Cloudinary api key = 631378849124139
    // MARK: Cloudinary api secret key = hNXebQFT7y2oCYrmgHAIU8WpOjs
    
    init() {
        FirebaseApp.configure()
        
        let cloudinaryCloudName: String = "dqa9dgdso"
        let cloudinaryApiKey: String = "631378849124139"
        let cloudinaryApiSecret: String = "hNXebQFT7y2oCYrmgHAIU8WpOjs"

        let cloudinaryConfigure = CLDConfiguration(cloudName: cloudinaryCloudName, apiKey: cloudinaryApiKey, apiSecret: cloudinaryApiSecret)
        let cloudinary = CLDCloudinary(configuration: cloudinaryConfigure)
        
        try? Tips.resetDatastore()
        try? Tips.configure()
    }
    
    
    @StateObject var appStates = ApplicationStates()
    @StateObject var healthManager = HealthManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .environmentObject(self.appStates)
        .environmentObject(self.healthManager)
    }
}
