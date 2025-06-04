//
//  CoachScreen.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 25/03/25.
//

import SwiftUI
import Charts

struct CoachScreen: View {
    @EnvironmentObject var appStates: ApplicationStates
    
    
    enum CardType: String {
        case caloriesBurned, waterIntake, workoutTime, caloriesIngested
    }
    
    @State var currentSelectedMuscle: Extras.Muscle = .bicep
    @State var weeklyExericseList: Array<Exercise_t> = []
    
    var filteredArray: Array<FoodItem> {
        var finalReturn: Array<FoodItem> = []
        
        for foodItem_t in self.appStates.recommendedFoodItems {
            for foodItem in self.appStates.alreadyRecommendedFoodItems {
                if foodItem.foodName != foodItem_t.foodName {
                    finalReturn.append(foodItem_t)
                }
            }
        }
        
        return finalReturn
    }
    
    var body: some View {
        ScrollContentView {
            
            
            // MARK: Horizontal scroll widgets
            SecondaryHeading(title: "Fitness Metrics", secondaryText: "( avg per week )")
                .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    CoachAttributesCard(cardType: .caloriesBurned, title: "Cal. Burned", trailingImage: "FireLogo", background: ApplicationLinearGradient.orangeGradient)
                    CoachAttributesCard(cardType: .waterIntake, title: "Water Intake", trailingImage: "Water", background: ApplicationLinearGradient.blueGradient)
                    CoachAttributesCard(cardType: .workoutTime, title: "Workout", trailingImage: "Dumbbell", background: ApplicationLinearGradient.whiteGradient, textColor: .appBloodRedDark)
                    CoachAttributesCard(cardType: .caloriesIngested, title: "Cal. Ingested", trailingImage: "Food", background: ApplicationLinearGradient.greenGradient)
                }
                .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
                
            }
            .onAppear {
                Task {
                    self.weeklyExericseList = try await ApplicationEndpoints.get.getWeeklyExerciseList(forUserId: User.current.currentUser.id)
                }
            }
            
            
            
            
            
            // MARK: Walking activity
            SecondaryHeading(title: "Passive Activities", secondaryText: "( other then workouts )")
                .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
                .padding(.top, 25)
            
            AvgStepsPerWeek()
                .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
            
            
            
            
            
            // MARK: Total weekly volume
            SecondaryHeading(title: "Total Weekly Volume", secondaryText: "( total sets did for each muscles )")
                .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
                .padding(.top, 25)
            
            
            
            
            // MARK: All muscles
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(Extras.Muscle.allCases, id: \.self) { muscle in
                        HStack {
                            Text(muscle.rawValue)
                                .font(.system(size: 13, weight: .medium, design: .rounded))
                                .foregroundStyle(self.currentSelectedMuscle == muscle ? .white : .white.opacity(0.5))
                        }
                        .applicationDropDownButton(self.currentSelectedMuscle == muscle ? ApplicationLinearGradient.blueGradientInverted : ApplicationLinearGradient.darkBGSameGradientWithOpacityHalf, height: 40)
                        .onTapWithScaleVibrate(scaleBy: 0.75) {
                            withAnimation {
                                self.currentSelectedMuscle = muscle
                            }
                        }
                    }
                }
                .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
            }
            
            if self.weeklyExericseList.filter({ $0.targettedMuscles.contains(self.currentSelectedMuscle) }).isEmpty {
                Image(systemName: "tray.fill")
                    .resizable()
                    .frame(width: 65, height: 50)
                    .foregroundStyle(.white.opacity(0.5))
                    .padding(.top, 25)
                
                Text("No Exercise For \(self.currentSelectedMuscle)")
                    .font(.system(size: 15, weight: .regular, design: .rounded))
                    .foregroundStyle(.white.opacity(0.5))
            }
            
            VStack {
                ForEach(self.weeklyExericseList.filter { $0.targettedMuscles.contains(self.currentSelectedMuscle)} , id: \.id) { exericse in
                    NavigationLink(destination: ExerciseDetailsScreen(exercise: exericse)) {
                        ExerciseViewCard(exercise: exericse)
                            .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
                            .transition(.offset(y: 500))
                    }
                }
            }
            .padding(.top)
            
            SecondaryHeading(title: "AI Food Recommendation")
                .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
                .padding(.top, 25)
            
            if self.appStates.recommendedFoodItems.isEmpty {
                ForEach(0...1, id: \.self) { _ in
                    FoodRecommendationViewCardPlaceholder()
                }
            }
            
            ForEach(self.filteredArray, id: \.id) { foodItem in
                FoodRecommendationViewCard(food: foodItem, actualArray: self.$appStates.recommendedFoodItems)
                    .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
                    .transition(.offset(x: -UIScreen.main.bounds.width).combined(with: .blurReplace))
                    .onTapGesture {
                        let food_t: Food_t = .init(foodName: foodItem.foodName, foodDescription: foodItem.foodDescription, foodQuantity: 100, calories: foodItem.caloriesPerGram * 100, foodImage: "", foodType: Extras.FoodType(rawValue: foodItem.foodType)!, protein: foodItem.protienPerGram * 100, carbs: foodItem.carbsPerGram * 100, fats: foodItem.fatsPerGram * 100)
                        self.appStates.currentSelectedFood = food_t
                        withAnimation {
                            self.appStates.showFoodDetails = true
                        }
                    }
            }
        }
    }
}

