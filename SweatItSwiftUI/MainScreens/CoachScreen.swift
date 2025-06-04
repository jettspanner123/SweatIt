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
                        .applicationDropDownButton(self.currentSelectedMuscle == muscle ? ApplicationLinearGradient.blueGradientInverted : ApplicationLinearGradient.darkBGSameGradientWithOpacityHalf)
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
                    ExerciseViewCard(exercise: exericse)
                        .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
                        .transition(.offset(y: 500))
                }
            }
            .padding(.top)
            
            SecondaryHeading(title: "AI Food Recommendation")
                .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
                .padding(.top, 25)
            
            if self.appStates.recommendedFoodItems.isEmpty {
                NotFoundView(text: "No Recommendations")
                    .transition(.blurReplace)
            }
            
            let uniqueItems = Dictionary(grouping: self.appStates.recommendedFoodItems, by: \.id).compactMap { $0.value.first }
            ForEach(uniqueItems.shuffled().prefix(3), id: \.id) { foodItem in
                FoodRecommendationViewCard(food: foodItem)
            }
        }
    }
}


struct FoodRecommendationViewCard: View {
    var food: FoodItem
    
    func getIcon() -> String {
        switch self.food.foodType {
        case "Junk 💩":
            return "🍔"
        case "Clean 🥦":
            return "🥦"
        default:
            return "🥤"
        }
    }
    
    var body: some View {
        HStack {
            HStack {
                Text(self.getIcon())
                    .font(.system(size: 30))
            }
            .frame(width: 70, height: 70)
            .background(.white.opacity(0.08), in: Circle())
            .overlay {
                Circle()
                    .stroke(.white.opacity(0.1), lineWidth: 1)
            }
            
            VStack {
                Text(self.food.foodName)
                    .font(.system(size: 15))
                    .takeMaxWidthLeading()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(height: 75)
        .padding()
        .background(.darkBG.opacity(0.54), in: defaultShape)
        .overlay {
            defaultShape
                .stroke(.white.opacity(0.08), lineWidth: 1)
        }
        .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
    }
}



struct NotFoundView: View {
    
    var text: String
    var image: String = "tray.fill"
    var height: CGFloat = 50
    var width: CGFloat = 65
    
    var body: some View {
        VStack {
            Image(systemName: self.image)
                .resizable()
                .frame(width: self.width, height: self.height)
                .foregroundStyle(.white.opacity(0.5))
                .padding(.top, 25)
            
            Text(self.text)
                .font(.system(size: 15, weight: .regular, design: .rounded))
                .foregroundStyle(.white.opacity(0.5))
        }
    }
}
#Preview {
    CoachScreen()
}
