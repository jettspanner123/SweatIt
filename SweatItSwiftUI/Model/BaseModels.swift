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
    
    
    func toDictionary() -> Dictionary<String, Any> {
        var dictionary: Dictionary<String, Any> = ["id": self.id, "exerciseName": self.exerciseName, "exerciseDescription": self.exerciseDescription, "isNonActiveExercise": self.isNonActiveExercise, "sets": self.sets, "reps": self.reps, "perRepCaloriesBurned": self.perRepCaloriesBurned, "difficulty": self.difficulty.rawValue]
        var temp: Array<String> = []
        for muscle in self.targettedMuscles {
            temp.append(muscle.rawValue)
        }
        dictionary["targettedMuscles"] = temp
        return dictionary
    }
}

struct Workout_t: Identifiable, Codable, Hashable {
    var id: String = UUID().uuidString
    var workoutName: String
    var workoutDescription: String
    var workoutCategory: Extras.WorkoutCategory
    var workoutImage: String
    var workoutDifficulty: Extras.Difficulty = .easy
    var exercises: Array<Exercise_t>
    var timing: Date = .now
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
    
    func getDictionary() -> Dictionary<String, Any> {
        let isoDateFormatter = ISO8601DateFormatter()
        var dictionary: Dictionary<String, Any> = ["id": self.id, "workoutName": self.workoutName, "workoutDescription": self.workoutDescription, "workoutCategory": self.workoutCategory.rawValue, "workoutImage": self.workoutImage, "workoutDifficulty": self.workoutDifficulty.rawValue, "timing": isoDateFormatter.string(from: self.timing)]
        var temp: Array<Dictionary<String, Any>> = []
        for exercise in self.exercises {
            temp.append(exercise.toDictionary())
        }
        dictionary["exercises"] = temp
        return dictionary
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

struct Activity_t: Identifiable {
    
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
    
    
    func toDictionary() -> Dictionary<String, Any> {
        let isoDateFormatter = ISO8601DateFormatter()
        if let rec = self.recommendation {
            return ["id": self.id, "timeOfHaving": self.timeOfHaving, "foodName": self.foodName, "foodDescription": self.foodDescription, "foodQuantity": self.foodQuantity, "calories": self.calories, "foodImage": self.foodImage, "foodType": self.foodType.rawValue, "protein": self.protein, "carbs": self.carbs, "fats": self.fats, "recommendation": rec.rawValue]
        }
        return ["id": self.id, "timeOfHaving": self.timeOfHaving, "foodName": self.foodName, "foodDescription": self.foodDescription, "foodQuantity": self.foodQuantity, "calories": self.calories, "foodImage": self.foodImage, "foodType": self.foodType.rawValue, "protein": self.protein, "carbs": self.carbs, "fats": self.fats, "recommendation": "null"]
    }
}


struct Meal_t: Identifiable, Codable, Hashable {
    var id: String = UUID().uuidString
    var mealName: String
    var mealType: Extras.MealType
    var foodItems: Array<Food_t>
    var mealTime: Date = .now
    
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
    
    func toDictionary() -> Dictionary<String, Any> {
        let isoDateFormatter = ISO8601DateFormatter()
        var diction: Dictionary<String, Any> = ["id": self.id, "mealName": self.mealName, "mealType": self.mealType.rawValue, "mealTime": isoDateFormatter.string(from: self.mealTime)]
        var temp: Array<Dictionary<String, Any>> = []
        for food in self.foodItems {
            temp.append(food.toDictionary())
        }
        diction["foodItems"] = temp
        return diction
    }
}

struct DailyEvents_t: Identifiable, Codable, Hashable  {
    var id: String = UUID().uuidString
    var date: Date = .now
    var caloriesBurnedForTheDay: Double = .zero
    var caloriesIngestedForTheDay: Double = .zero
    var waterIntakeForTheDay: Int = .zero
    var workoutTimingForTheDay: Int = .zero
    var mealsHad: Array<Meal_t> = []
    var workoutsDone: Array<Workout_t> = []
    var stepsTaken: Int = .zero
    
    func getDictionary() -> Dictionary<String, Any> {
        let isoDateFormatter = ISO8601DateFormatter()
        var dictionary: Dictionary<String, Any> = [Constants.id.rawValue: self.id, Constants.date.rawValue: isoDateFormatter.string(from: self.date), Constants.caloriesBurnedForTheDay.rawValue: self.caloriesBurnedForTheDay, Constants.caloriesIngestedForTheDay.rawValue: self.caloriesIngestedForTheDay, Constants.waterIntakeForTheDay.rawValue: self.waterIntakeForTheDay, Constants.workoutTimingForTheDay.rawValue: self.workoutTimingForTheDay, Constants.stepsTaken.rawValue: self.stepsTaken]
        var meals: Array<Dictionary<String, Any>> = []
        var workouts: Array<Dictionary<String, Any>> = []
        
        
        
        for meal in self.mealsHad {
            meals.append(meal.toDictionary())
        }
        
        for workout in self.workoutsDone {
            workouts.append(workout.getDictionary())
        }
        
        dictionary[Constants.workoutsDone.rawValue] =  workouts
        dictionary[Constants.mealsHad.rawValue] =  meals
        return dictionary
    }
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
        let weight = User.current.currentUser.currentWeight * 10
        let height = User.current.currentUser.currentHeight * 6.25
        let age = 25 * 5
        return weight + height - Double(age) + 5
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

