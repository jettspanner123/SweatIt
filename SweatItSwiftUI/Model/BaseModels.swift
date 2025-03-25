//
//  BaseModels.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 09/03/25.
//

import SwiftUI


struct Agenda_t: Identifiable, Codable, Hashable {
    var id: String = UUID().uuidString
    var title: String
    var description: String
    var date: Date = .now
    var isDone: Bool = false
}

struct Exercise_t: Identifiable, Codable, Hashable {
    var id: String = UUID().uuidString
    var exerciseName: String
    var exerciseDescription: String
    var targettedMuscles: Array<Extras.Muscle>
    var isNonActiveExercise: Bool = false
    var sets: Int
    var reps: Int
    var perRepCaloriesBurned: Double
    var difficulty: Extras.Difficulty
}

struct Workout_t: Identifiable, Codable, Hashable {
    var id: String = UUID().uuidString
    var workoutName: String
    var workoutDescription: String
    var workoutCategory: Extras.WorkoutCategory
    var workoutImage: String
    var workoutDifficulty: Extras.Difficulty = .easy
    var exercises: Array<Exercise_t>
    var caloriesBurned: Double {
        var totalCalories = 0
        for exercise in self.exercises {
            totalCalories += (exercise.sets * exercise.reps) * Int(exercise.perRepCaloriesBurned)
        }
        return Double(totalCalories)
    }
    var timeTaken: Double {
        var totalTime: Double = 0
        for exercise in self.exercises {
            totalTime += (Double(exercise.sets) * Double(exercise.reps)) * 10
        }
        return totalTime
    }
}

struct Challenge_t: Identifiable, Codable, Hashable {
    var id: String = UUID().uuidString
    var challengeName: String
    var challengeImage: String
    var challengeDescription: String
    var challengeExtendedDescription: String
    var challengeDifficulty: Extras.Difficulty
    var duration: Date
}

struct Activity_t {
    var id: String = UUID().uuidString
    var activityName: Extras.ActivityType
    var activityDescription: Any
    var creationDate: Date = .now
}

struct Food_t: Identifiable, Codable, Hashable {
    var id: String = UUID().uuidString
    var foodName: String
    var foodDescription: String
    var foodQuantity: Double
    var calories: Double
    var foodImage: String
    var foodType: Extras.FoodType
    var protein: Double
    var carbs: Double
    var fats: Double
    var recommendation: Extras.RecommendationType? = nil
}


struct Meal_t: Identifiable, Codable, Hashable {
    var id: String = UUID().uuidString
    var mealName: String
    var mealType: Extras.MealType
    var foodItems: Array<Food_t>
    var totalCalories: Double {
        var finalCalories: Double = .zero
        
        for food in foodItems {
            finalCalories += food.calories
        }
        return finalCalories
    }
    var totalProtein: Double {
        var finalProtein: Double = .zero
        
        for food in foodItems {
            finalProtein += food.protein
        }
        return finalProtein
    }
    
    var totalCarbs: Double {
        var finalCarbs: Double = .zero
        
        for food in foodItems {
            finalCarbs += food.carbs
        }
        return finalCarbs
    }
    var totalFats: Double {
        var finalFats: Double = .zero
        
        for food in foodItems {
            finalFats += food.protein
        }
        return finalFats
    }
    var mealTime: Date = .now
}

struct DailyEvents_t: Identifiable, Codable, Hashable  {
    var id: String = UUID().uuidString
    var date: Date = .now
    var caloriesBurnedForTheDay: Int = .zero
    var caloriesIngestedForTheDay: Int = .zero
    var waterIntakeForTheDay: Int = .zero
    var workoutTimingForTheDay: Int = .zero
    var mealsHad: Array<Meal_t> = []
    var workoutsDone: Array<Workout_t> = []
    var stepsTaken: Int = .zero
}

struct User_t: Identifiable, Codable, Hashable {
    var id: String = UUID().uuidString
    var fullName: String
    var username: String
    var emailId: String
    var password: String
    var currentWeight: Double
    var currentHeight: Double
    var gender: Extras.Gender
    var bodyType: Extras.BodyType
    var level: Extras.UserLevel
    var goal: Extras.Goal
    var dailyPoints: Int = 0
    var fitnessLevel: Int = 1
}

struct FriendRequest_t: Identifiable, Codable, Hashable {
    var id: String = UUID().uuidString
    var fromUser: User_t
    var toUserId: User_t
    var requestDate: Date = .now
    var actionDate: Date? = nil
    var status: Extras.FriendRequestStatus = .pending
}

struct Notification_t: Identifiable {
    var id: String = UUID().uuidString
    var forUserId: String
    var notificationName: String
    var notificationDescription: String
    var notificationType: Extras.NotificationType
    var notificationDate: Date = .now
    var notificationAction: Any
}
