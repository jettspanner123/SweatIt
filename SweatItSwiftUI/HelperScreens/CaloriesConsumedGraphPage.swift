//
//  CaloriesConsumedGraphPage.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 23/04/25.
//

import SwiftUI
import Charts

struct CaloriesConsumedGraphPage: View {
    @EnvironmentObject var appStates: ApplicationStates
    
    @State var currentSelectedCategory: CaloriesBurnedGraphPage.CaloriesBurnedGraphCategory = .today
    
    var foodItems: Array<Food_t> {
        var allFoodItems: Array<Food_t> = []
        for meals in self.appStates.dailyEvents.mealsHad {
            for food in meals.foodItems {
                allFoodItems.append(food)
            }
        }
        return allFoodItems
    }
    
    
    var body: some View {
        ScreenBuilder {
            
            AccentPageHeader(pageHeaderTitle: "Calories Consumed")
            
            ScrollContentView {
                
                
                // MARK: Segmented controller
                HStack {
                    ForEach(CaloriesBurnedGraphPage.CaloriesBurnedGraphCategory.allCases, id: \.self) { category in
                        HStack {
                            Text(category.rawValue.capitalized)
                                .font(.system(size: 13, weight: .medium, design: .rounded))
                                .foregroundStyle(self.currentSelectedCategory == category ? .white : .white.opacity(0.5))
                                .frame(maxWidth: .infinity)
                        }
                        .applicationDropDownButton(self.currentSelectedCategory == category ? ApplicationLinearGradient.blueGradientInverted : ApplicationLinearGradient.darkBGSameGradientWithOpacityHalf, height: 40)
                        .onTapWithScaleVibrate {
                            withAnimation {
                                self.currentSelectedCategory = category
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                
                
                
                SectionHeader(text: "Calories Statistics")
                    .padding(.top, 25)
                
                switch self.currentSelectedCategory {
                case .today:
                    self.TodayCaloriesGainedGraph
                case .weekly:
                    self.WeeklyCaloriesGainedGraph
                case .monthly:
                    self.MonthlyCaloriesGainedGraph
                }
                
                
                
                SectionHeader(text: "Others")
                    .padding(.top, 25)
                VStack {
                    Text("About")
                        .font(.custom(ApplicationFonts.oswaldRegular, size: 20))
                        .foregroundStyle(.white)
                        .takeMaxWidthLeading()
                        .padding(.top, 10)
                    
                    
                    Text("Calories Consumed is all about the fuel you feed your body — think of it as the energy deposit you make every time you eat or drink. These edible energy units come from macronutrients like carbs, proteins, and fats — the real MVPs of your meal plan. How much you plate up depends on things like your age, sex, height, weight, and how active you are. Eating more than your body needs? You might be stacking up some extra pounds. Eating less? You’re on the path to shedding some bread (and not just the sandwich kind). Tracking your calories can help you bite into better nutrition, chew through your fitness goals, and digest what your body really needs. Just remember — those calorie numbers on labels and apps? They're more of a guest-imet than an exact science. So take them with a grain of salt — unless you're counting sodium too!")
                        .font(.system(size: 15, weight: .medium, design: .rounded))
                        .foregroundStyle(.white.opacity(0.5))
                        .takeMaxWidthLeading()
                        .padding(.bottom)
                }
                .applicationDropDownButton()
            }
            .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
        }
    }
    
    
    var TodayCaloriesGainedGraph: some View {
        VStack {
            
            // MARK: Bar graph
            VStack {
                if self.foodItems.isEmpty {
                    VStack {
                        Image(systemName: "carrot.fill")
                            .resizable()
                            .frame(width: 70, height: 70)
                            .foregroundStyle(.white.opacity(0.5))
                        
                        Text("Calories Ingested Will Display Here.")
                            .font(.system(size: 13, weight: .medium, design: .rounded))
                            .foregroundStyle(.white.opacity(0.5))
                            .padding(.top, 5)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 25)
                } else {
                    Text("Calorie Intake Bar")
                        .font(.custom(ApplicationFonts.oswaldRegular, size: 20))
                        .foregroundStyle(.white)
                        .takeMaxWidthLeading()
                        .padding(.top, 10)
                    
                    let totalCaloriesGained: Double = self.foodItems.reduce(0) {$0 + $1.calories}
                    Text("Bar over graph showing calories gained each time of the day.")
                        .font(.system(size: 15, weight: .medium, design: .rounded))
                        .foregroundStyle(.white.opacity(0.5))
                        .takeMaxWidthLeading()
                    
                    Chart(self.foodItems) { food in
                        BarMark(x: .value("Hour", Calendar.current.dateComponents([.hour], from: food.timeOfHaving).hour!), y: .value("Calories", food.calories))
                            .foregroundStyle(.appGreenLight)
                    }
                    .padding(.vertical)
                }
            }
            .applicationDropDownButton()
            
            
            
            
            SectionHeader(text: "Highlights")
                .padding(.top, 25)
            
            
            
            // MARK: Line graph
            VStack {
                if self.foodItems.isEmpty {
                    VStack {
                        Image(systemName: "fork.knife")
                            .resizable()
                            .frame(width: 50, height: 65)
                            .foregroundStyle(.white.opacity(0.5))
                        
                        Text("Calories Not Added Yet!")
                            .font(.system(size: 13, weight: .medium, design: .rounded))
                            .foregroundStyle(.white.opacity(0.5))
                            .padding(.top, 5)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 25)
                } else {
                    Text("Calorie Intake Over Time")
                        .font(.custom(ApplicationFonts.oswaldRegular, size: 20))
                        .foregroundStyle(.white)
                        .takeMaxWidthLeading()
                        .padding(.top, 10)
                    
                    let totalCaloriesGained: Double = self.foodItems.reduce(0) {$0 + $1.calories}
                    Text("Over the last \(self.foodItems.count) meals/food, you have gained")
                        .font(.system(size: 15, weight: .medium, design: .rounded))
                        .foregroundStyle(.white.opacity(0.5))
                        .takeMaxWidthLeading()
                    
                    Text(String(format: "%.f kCal", totalCaloriesGained))
                        .font(.custom(ApplicationFonts.oswaldRegular, size: 20))
                        .foregroundStyle(.white.opacity(0.75))
                        .takeMaxWidthLeading()
                    
                    Chart(self.foodItems, id: \.id) { food in
                        LineMark(x: .value("Caloires", food.calories), y: .value("Calories", Calendar.current.dateComponents([.hour], from: food.timeOfHaving).hour!))
                            .foregroundStyle(.appGreenLight)
                    }
                    .padding(.vertical)
                }
            }
            .applicationDropDownButton()
        }
    }
    
    var WeeklyCaloriesGainedGraph: some View {
        VStack {
            
        }
    }
    
    var MonthlyCaloriesGainedGraph: some View {
        VStack {
            
        }
    }
}

