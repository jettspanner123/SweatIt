//
//  ContentView.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 09/03/25.
//

import SwiftUI
import SwiftData
import AVKit
@preconcurrency import GoogleGenerativeAI

class AnimatedNamespaceCoordinator: ObservableObject {
    public var current = AnimatedNamespaceCoordinator()
    @Namespace var animatedNamespace
}


struct ContentView: View {
    
    let model: GenerativeModel
    
    init() {
        let apiKey = "AIzaSyAnqRlW22bqKvIKWNgzKCT3UgbHK8vqlhw"
        model = GenerativeModel(name: "gemini-1.5-flash-latest", apiKey: apiKey)
    }
    
    @EnvironmentObject var appStates: ApplicationStates
    
    @State var currentPage_t: PageNavigationBar.PageNavigationOptions = .coach
    
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
            let toIndex = jsonString.index(jsonString.endIndex, offsetBy: -6)
            return String(jsonString[index...toIndex]).trimmingCharacters(in: .whitespacesAndNewlines)
        }
        return jsonString
    }
    
    func cleanJSONString(from input: String) -> String? {
        // Convert string to Data
        guard let data = input.data(using: .utf8) else { return nil }
        
        // Try to decode it into a generic JSON object
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
            
            // Convert it back to a clean JSON string with no formatting
            let cleanedData = try JSONSerialization.data(withJSONObject: jsonObject, options: [])
            
            // Return compact JSON string
            return String(data: cleanedData, encoding: .utf8)
        } catch {
            print("Error cleaning JSON string:", error)
            return nil
        }
    }
    
    func extractValidJSONString(from input: String) -> String {
        var cleaned = input.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Remove Markdown-style ```json or ``` wrappers
        if cleaned.hasPrefix("```json") {
            cleaned = String(cleaned.dropFirst(7))
        }
        if cleaned.hasPrefix("```") {
            cleaned = String(cleaned.dropFirst(3))
        }
        if cleaned.hasSuffix("```") {
            cleaned = String(cleaned.dropLast(3))
        }

        return cleaned.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    private func fetchAIFoodRecommendation() -> Void {
        struct ScannedFood_t: Codable {
            var foodName: String
            var foodDescription: String
            var foodQuantity: Double
            var calories: Double
            var protein: Double
            var carbs: Double
            var fats: Double
            var caloriesPerGram: Double
            var foodType: Extras.FoodType
            var foodImage: String
            var protienPerGram: Double
            var carbsPerGram: Double
            var fatsPerGram: Double
            var mealType: Extras.MealType
            
            enum CodingKeys: String, CodingKey {
                case foodName
                case foodDescription
                case foodQuantity
                case calories
                case protein
                case carbs
                case fats
                case caloriesPerGram = "calories_per_gram"
                case foodType
                case foodImage
                case protienPerGram
                case carbsPerGram
                case fatsPerGram
                case mealType
            }
        }
        
        
        
        
        Task {
            withAnimation {
                self.appStates.foodRecommendationLoading = true
            }
            
            print("Food Recommendation Loading: true")
            
            let weeklyFoodItems: Array<Food_t> = try await ApplicationEndpoints.get.getAllFoodItems(forUserId: User.current.currentUser.id)
            var prompt: String = """
            Generate a strict JSON object with foodName as non-empty string of max 5 words, 
            foodDescription as non-empty of atleast 50 words and max 75 words and foodType which is also a non-empty string and can be either of these [`Junk 💩`, `Clean 🥦`, `Beverage 🥛`], just like the others foodImage shoudld be empty string,foodQuantity as a double value representing grams, calories, protein, carbs, fats, protienPerGram, carbsPerGram, fatsPerGram and calories_per_gram as double values, mealType which is also a non-empty string and can be either of these [`Breakfast ☕️`, `Lunch 🍽️`, `Beverage 🥛`, `Dinner 🍝`, ``Snack 🍿] if the image is of food, just give out null if the image is not a food item — and return only the JSON object without extra text and if there is no food item just return null no other text.
            Make sure that the food you are generating will be based on the these food items that i'm giving you through json, make sure that the food you recommend matches with these food item, my matheches i mean some what similar to these food items: [
            """
            
            var responesText: String = ""
            
            do {
                
                for foodItem in weeklyFoodItems {
                    prompt.append("'\(foodItem.foodName)', ")
                }
                
                prompt.append("],please generate around 5-6 food items ,make sure that there are no aditional text after or before the response.")
                
                let response = try await model.generateContent(prompt)
                responesText = response.text ?? "No response received."
                let cleanedResponse = self.extractValidJSONString(from: responesText)
                print(cleanedResponse)
                
                let foodJSONData = Data(cleanedResponse.utf8)
                let decodedFood = try JSONDecoder().decode([FoodItem].self, from: foodJSONData)
                
                
                withAnimation {
                    self.appStates.recommendedFoodItems = decodedFood
                }
                
                
            } catch {
                responesText = "Error: \(error.localizedDescription)"
                print("Failed to fetch food Items")
            }
            
            print("Food Recommendation Loading: false")
            withAnimation {
                self.appStates.foodRecommendationLoading = false
            }
        }
        
        
    }
    
    var body: some View {
        NavigationStack {
            ScreenBuilder {
                //                if self.isUserLoggedIn == false {
                //                    LoginScreen(isUserLoggedIn: self.$isUserLoggedIn ,showLoginScreen: self.$isUserLoggedIn, showIsland: self.$showIsland)
                //                        .zIndex(99999)
                //                        .transition(ScaleBlurOffsetTransition())
                //                }
                
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
                            
                            SimpleButton(
                                content: {
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
        .onAppear {
            self.fetchAIFoodRecommendation()
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
                
                
                Text("Analizing Food Data")
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

