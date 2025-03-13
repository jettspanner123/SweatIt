//
//  ActivityDetailsScreen.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 11/03/25.
//

import SwiftUI

struct ActivityDetailsScreen: View {
    
    var activity: Activity_t
    
    var body: some View {
        ScreenBuilder {
            AccentPageHeader(pageHeaderTitle: "Activity Details")
            
            ScrollContentView {
                
                
                CustomList {
                    SpaceSeparatedKeyValue(key: "Activity Type", value: self.activity.activityName.rawValue)
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                    CustomDivider()
                     
                    if let workout = self.activity.activityDescription as? Workout_t {
                        SpaceSeparatedKeyValue(key: "Workout Name", value: workout.workoutName)
                            .padding(.horizontal)
                            .padding(.vertical, 5)
                        
                        CustomDivider()

                        SpaceSeparatedKeyValue(key: "Calories Burned", value: String(workout.caloriesBurned) + " 🔥")
                            .padding(.horizontal)
                            .padding(.vertical, 5)
                        
                        CustomDivider()

                        SpaceSeparatedKeyValue(key: "Time Taken", value: ApplicationHelper.formatSeconds(seconds: Int(workout.timeTaken)) + " 🕘")
                            .padding(.horizontal)
                            .padding(.vertical, 5)
                        
                        
                        CustomDivider()

                        SpaceSeparatedKeyValue(key: "Workout Type", value: workout.workoutCategory.rawValue)
                            .padding(.horizontal)
                            .padding(.vertical, 5)
                        
                    }
                    
                    if let food = self.activity.activityDescription as? Food_t {
                        SpaceSeparatedKeyValue(key: "Food Name", value: food.foodName)
                            .padding(.horizontal)
                            .padding(.vertical, 5)
                        
                        CustomDivider()

                        SpaceSeparatedKeyValue(key: "Calories Consumed", value: String(food.calories) + " 🥦")
                            .padding(.horizontal)
                            .padding(.vertical, 5)
                        
                        CustomDivider()

                        SpaceSeparatedKeyValue(key: "Protien", value: String(format: "%.f 🍖", food.protein))
                            .padding(.horizontal)
                            .padding(.vertical, 5)
                        
                        
                        CustomDivider()
                        
                        SpaceSeparatedKeyValue(key: "Carbohydrates", value: String(format: "%.f 🍞", food.carbs))
                            .padding(.horizontal)
                            .padding(.vertical, 5)
                        
                        CustomDivider()

                        SpaceSeparatedKeyValue(key: "Fats", value: String(format: "%.f 🥐", food.fats))
                            .padding(.horizontal)
                            .padding(.vertical, 5)
                        
                        CustomDivider()

                        SpaceSeparatedKeyValue(key: "Quantity", value: String(format: "%.f", food.foodQuantity))
                            .padding(.horizontal)
                            .padding(.vertical, 5)
                        
                    }
                    
                }
               
                // MARK: Creation date
                SectionHeader(text: "Other Details")
                    .padding(.top, 20)
                
                
                CustomList {
                    
                    SpaceSeparatedKeyValue(key: "Creation Date", value: ApplicationHelper.formatDateToHumanReadable(date: self.activity.creationDate))
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                    
                    CustomDivider()
                    
                    SpaceSeparatedKeyValue(key: "Identification", value: String(self.activity.id.prefix(20)))
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                    
                }
                
                SectionHeader(text: "Navigation Link")
                    .padding(.top, 20)
                
                if let workout = self.activity.activityDescription as? Workout_t {
                    
                    NavigationLink(destination: ActiveWorkoutScreen(workout: workout)) {
                        WorkoutCard(image: workout.workoutImage, name: workout.workoutName, difficulty: workout.workoutDifficulty, sideOffset: 50, caloriesBurned: Int(workout.caloriesBurned), duration: String(workout.timeTaken))
                    }
                }
                
                if let food = self.activity.activityDescription as? Food_t {
                    NavigationLink(destination: EmptyView()) {
                        
                        // MARK: Outer wraper
                        HStack {
                            FoodCard(food: food)
                        }
                        .frame(maxWidth: .infinity)
                        .background(.darkBG.opacity(0.54))
                        .overlay {
                            defaultShape
                                .stroke(.white.opacity(0.18))
                        }
                        .clipShape(defaultShape)
                    }
                }
                
            }
            .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
        }
    }
}

struct SectionHeader: View {
    var text: String
    
    var body: some View {
        Text(self.text)
            .font(.system(size: 12, weight: .medium, design: .rounded))
            .foregroundStyle(.white.opacity(0.5))
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 10)
    }
}


struct SpaceSeparatedKeyValue: View {
    
    var key: String
    var value: String
    
    var body: some View {
        HStack {
            Text(self.key)
                .font(.system(size: 15, weight: .regular, design: .rounded))
                .foregroundStyle(.white)
                .multilineTextAlignment(.leading)

            Spacer()
            Text(self.value)
                .font(.system(size: 15, weight: .regular, design: .rounded))
                .foregroundStyle(.white.opacity(0.5))
                .multilineTextAlignment(.trailing)
        }
        .frame(maxWidth: .infinity)
    }
}


