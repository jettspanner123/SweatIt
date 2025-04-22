//
//  BaseModels.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 09/03/25.
//

import SwiftUI
import Firebase


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
    var image: String = ""
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
        var totalCalories: Double = 0
        for exercise in self.exercises {
            totalCalories += (Double(exercise.sets) * Double(exercise.reps)) * exercise.perRepCaloriesBurned
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
    var timeOfHaving: Date = .now
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
    
    
    
    public func getDictionary() -> Dictionary<String, Any> {
        return ["id": self.id, "fullName": self.fullName, "username": self.username, "emailId": self.emailId, "password": self.password, "currentWeight": self.currentWeight, "currentHeight": self.currentHeight, "gender": self.gender.rawValue, "bodyType": self.bodyType.rawValue, "level": self.level.rawValue, "goal": self.goal.rawValue, "dailyPoints": self.dailyPoints, "fitnessLevel": self.fitnessLevel]
    }
}

struct FriendRequest_t: Identifiable, Codable, Hashable {
    var id: String = UUID().uuidString
    var fromUser: String
    var toUserId: String
    var requestDate: Date = .now
    var actionDate: Date? = nil
    var status: Extras.FriendRequestStatus = .pending
    
    func getDictionary() -> Dictionary<String, Any> {
        return ["id": self.id, "fromUser": self.fromUser, "toUser": self.toUserId, "requestDate": self.requestDate, "actionDate": self.actionDate ?? "none", "status": self.status.rawValue]
    }
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


struct SignUpUserDataStore {
    var fullName: String
    var username: String
    var password: String
    var email: String
    var age: Int
    var gender: Extras.Gender
    var height: Double
    var weight: Double
    var bodyType: Extras.BodyType
    var activeDaysAWeek: Int
    var activeHoursADay: Double
    var activeDays: Array<String> = []
    var region: String
    var foodType: Extras.UserFoodType = .none
    var foodBudged: Double
    var alergies: Array<Extras.FoodAllergy> = []
    var fitnessLevel: Extras.UserLevel = .none
    var goalType: Extras.Goal = .none
    var phoneNumber: String = ""
    var dob: Date
}

struct LogInUserDataStore {
    var username: String
    var password: String
    var confirmPassword: String
    var emailIfForgot: String
}

struct ExtraInfo_t {
    var id: String = UUID().uuidString
    var ofUserId: String
    var age: Int
    var activeDaysAWeek: Int
    var activehoursADay: Double
    var activeDays: Array<String>
    var region: String
    var foodType: Extras.UserFoodType
    var foodBudget: Double
    var alergies: Array<Extras.FoodAllergy>
    var fitnessLevel: Extras.UserLevel
    var goalType: Extras.Goal
    var phontNumber: String
    var dateOfBirth: Date
    
    func getDictionary() -> Dictionary<String, Any> {
        var dict: Dictionary<String, Any> = ["id": self.id, "ofUserId": self.ofUserId, "age": self.age, "activeDaysAWeek": self.activeDaysAWeek, "activehoursADay": self.activehoursADay, "activeDays": self.activeDays, "region": self.region, "foodType": self.foodType.rawValue, "foodBudget": self.foodBudget, "fitnessLevel": self.fitnessLevel.rawValue, "goalType": self.goalType.rawValue, "phontNumber": self.phontNumber, "dateOfBirth": self.dateOfBirth]
        
        var alergies_t: Array<String> = []
        for alergy in self.alergies {
            alergies_t.append(alergy.rawValue)
        }
        
        dict["alergies"] = alergies_t
        return dict
    }
}

struct DailyNeeds_t {
    var dailyCalories: Double {
        return Double(2500)
    }
    var dailyProtien: Double {
       return Double(User.current.currentUser.currentWeight * 1.5)
    }
    var dailyCarbs: Double {
        return Double(2 * User.current.currentUser.currentWeight)
    }
    var dailyFats: Double {
        return Double(0.5 * User.current.currentUser.currentWeight)
    }
    var dailySteps: Int {
        return 15000
    }
}

