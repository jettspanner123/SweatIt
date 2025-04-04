//
//  DataModel.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 09/03/25.
//

import SwiftUI

class Extras {
    enum Muscle: String, CaseIterable, Codable, Hashable {
        case bicep = "Biceps", core = "Core", triceps = "Triceps", chest = "Chest", shoulders = "Shoulders", legs = "Legs", back = "Back", quads = "Quads", hamstrings = "Hamstrings", glutes = "Glutes", calves = "Calves", obliques = "Obliques"
    }
    
    enum WorkoutCategory: String, CaseIterable, Codable, Hashable {
        case strength = "Strength 💪", cardio = "Cardio 🏃", endurance = "Endurance ⌛️", flexibility = "Flexibility 🧘‍♂️"
    }
    
    enum DaysOfTheWeek: String, CaseIterable, Codable, Hashable {
        case monday = "Monday", tuesday = "Tuesday", wednesday = "Wednesday", thursday = "Tursday", friday = "Friday", saturday = "Saturday", sunday = "Sunday"
    }
    
    enum Difficulty: String, Codable, CaseIterable, Hashable {
        case all = "All", easy = "Easy", medium = "Mid", hard = "Hard", hardAf = "Hard FR"
    }
    
    enum MealType: String, Codable, CaseIterable, Hashable {
        case breakfast = "Breakfast ☕️", lunch = "Lunch 🍽️", dinner = "Dinner 🍝", snack = "Snack 🍿"
    }
    
    enum FoodType: String, Codable, CaseIterable, Hashable {
        case junk = "Junk 💩", clean = "Clean 🥦", beverage = "Beverage 🥛"
    }
    
    enum MacroType: String, Codable, CaseIterable, Hashable {
        case protein = "Protein 🥩", carbohydrates = "Carbohydrates 🍞", fats = "Fats 🥐"
    }
    
    enum RecommendationType: String, Codable, CaseIterable, Hashable {
        case lessRecommended = "Less Recommended👎", moreRecommended = "More Recommended 👍", noRecommendation = "No Recommendation 😕"
    }
    
    enum ActivityType: String, Codable, CaseIterable, Hashable {
        case workoutCompleted = "Workout Completed ✅", mealEaten = "Meal Eaten 🍔", waterIntake = "Water Taken 🥛"
    }
    
    enum Gender: String, Codable, CaseIterable, Hashable {
        case male = "Male 🗿", female = "Female 👩", Others = "LGTV 🤡", none = "None"
    }
    
    enum BodyType: String, Codable, CaseIterable, Hashable {
        case skinny = "Skinny 🥢", muscular = "Muscular 🗿", skinnyFat = "Skinny Fat 🤡", fat = "Fat 🐘" , none = "None"
    }
    
    enum Goal: String, Codable, CaseIterable, Hashable {
        case looseFat = "Loose Fat", buildMuscle = "Build Muscle", bodyRecomposition = "Body Recomposition", beFit = "Being Fit", developer = "Developer 🗿", none = "None"
    }
    
    enum UserLevel: String, Codable, CaseIterable, Hashable {
        case beginner = "Beginner 👶", intermediate = "Intermediate 🏃", advanced = "Advanced 🗿", none = "None"
    }
    
    enum NotificationType: String, Codable, CaseIterable, Hashable {
        case friendRequest = "Friend Request", drinkWater = "Drink Water", unfinishedWorkout = "Unfinished Workout", completeDiet = "Complete Diet", newChallenge = "New Challenge!"
    }
    
    enum FriendRequestStatus: String, Codable, CaseIterable, Hashable {
        case pending = "Pending ⏰", accepted = "Accepted ✅", declined = "Declined ❌", ingnored = "Ignored 🥺"
    }
    
    enum UserFoodType: String, Codable, CaseIterable, Hashable {
        case vegiterian = "Vegiterian", nonVegiterian = "Non Vegiterian", eggitarian = "Eggiterian", flexiterian = "Flexiterian", pescaterian = "Pescaterian", none
    }
    
    enum MeasurenmentSystem {
        case metric, imperial
    }
    
    enum FoodAllergy: String, CaseIterable {
        case peanuts = "Peanuts"
        case treeNuts = "Tree Nuts"
        case dairy = "Dairy"
        case eggs = "Eggs"
        case wheat = "Wheat"
        case soy = "Soy"
        case fish = "Fish"
        case shellfish = "Shellfish"
        case sesame = "Sesame"
        case none = "None"
    }
    
}

class Exercise {
    
    public static let current = Exercise()
    
    let pushUp = Exercise_t(
        exerciseName: "Push-Up",
        exerciseDescription: "A bodyweight exercise where you push your body up and down while maintaining a straight body.",
        targettedMuscles: [.chest, .shoulders, .triceps],
        isNonActiveExercise: false,
        sets: 3,
        reps: 15,
        perRepCaloriesBurned: 0.1,
        difficulty: .easy,
        image: "pushups"
    )
    
    let benchPress = Exercise_t(
        exerciseName: "Bench Press",
        exerciseDescription: "A barbell exercise where you lower a barbell to your chest and then press it back up.",
        targettedMuscles: [.chest, .shoulders, .triceps],
        isNonActiveExercise: false,
        sets: 4,
        reps: 10,
        perRepCaloriesBurned: 0.15,
        difficulty: .easy,
        image: "benchPress"
    )
    
    let inclinePushUp = Exercise_t(
        exerciseName: "Incline Push-Up",
        exerciseDescription: "A variation of push-ups where your hands are elevated on a bench or platform.",
        targettedMuscles: [.chest, .shoulders, .triceps],
        isNonActiveExercise: false,
        sets: 3,
        reps: 12,
        perRepCaloriesBurned: 0.08,
        difficulty: .easy,
        image: "inclinePushUp"
    )
    
    let overheadPress = Exercise_t(
        exerciseName: "Overhead Press",
        exerciseDescription: "A standing exercise where you press a barbell or dumbbell from shoulder height to overhead.",
        targettedMuscles: [.shoulders, .triceps],
        isNonActiveExercise: false,
        sets: 4,
        reps: 8,
        perRepCaloriesBurned: 0.2 ,
        difficulty: .easy,
        image: "overheadPress"
    )
    
    let chestDip = Exercise_t(
        exerciseName: "Chest Dip",
        exerciseDescription: "A bodyweight exercise where you dip down using parallel bars and then press up.",
        targettedMuscles: [.chest, .triceps, .shoulders],
        isNonActiveExercise: false,
        sets: 3,
        reps: 10,
        perRepCaloriesBurned: 0.18,
        difficulty: .easy,
        image: "chestDip"
    )
    
    let bodyweightSquat = Exercise_t(
        exerciseName: "Bodyweight Squat",
        exerciseDescription: "A lower body exercise that targets the quads, glutes, and hamstrings. Stand with feet shoulder-width apart and squat down while keeping your back straight.",
        targettedMuscles: [.quads, .hamstrings, .glutes],
        isNonActiveExercise: false,
        sets: 4,
        reps: 15,
        perRepCaloriesBurned: 0.1,
        difficulty: .easy,
        image: "bodyWeightSquat"
    )
    
    let walkingLunge = Exercise_t(
        exerciseName: "Walking Lunge",
        exerciseDescription: "A dynamic exercise that targets the quads, hamstrings, and glutes. Step forward with one leg, lunge down, and then bring the other leg forward into the next lunge.",
        targettedMuscles: [.quads, .hamstrings, .glutes],
        isNonActiveExercise: false,
        sets: 3,
        reps: 12, // reps per leg
        perRepCaloriesBurned: 0.12,
        difficulty: .easy,
        image: "walkingLunge"
    )
    
    let gluteBridge = Exercise_t(
        exerciseName: "Glute Bridge",
        exerciseDescription: "Lying on your back with knees bent, lift your hips off the ground by pushing through your heels, targeting the glutes and hamstrings.",
        targettedMuscles: [.glutes, .hamstrings, .core],
        isNonActiveExercise: false,
        sets: 3,
        reps: 15,
        perRepCaloriesBurned: 0.08,
        difficulty: .easy,
        image: "gluteBridge"
    )
    
    let bulgarianSplitSquat = Exercise_t(
        exerciseName: "Bulgarian Split Squat",
        exerciseDescription: "A single-leg squat variation where one leg is elevated on a bench or platform behind you. This exercise targets the quads, hamstrings, and glutes.",
        targettedMuscles: [.quads, .hamstrings, .glutes],
        isNonActiveExercise: false,
        sets: 3,
        reps: 10, // reps per leg
        perRepCaloriesBurned: 0.14,
        difficulty: .easy,
        image: "bulgarianSplitSquat"
    )
    
    let calfRaise = Exercise_t(
        exerciseName: "Calf Raise",
        exerciseDescription: "A simple exercise to target the calves. Stand on a flat surface and raise your heels off the ground, balancing on the balls of your feet.",
        targettedMuscles: [.calves],
        isNonActiveExercise: false,
        sets: 4,
        reps: 20,
        perRepCaloriesBurned: 0.05,
        difficulty: .easy,
        image: "calfRaise"
    )
    let closeGripPushups = Exercise_t(
        exerciseName: "Close Grip Pushups",
        exerciseDescription: "A simple exercise to target the triceps, shoulders, and chest. Get into a pushup position, but place your hands closer together than shoulder-width apart.",
        targettedMuscles: [.triceps, .shoulders, .chest],
        isNonActiveExercise: false,
        sets: 4,
        reps: 20,
        perRepCaloriesBurned: 0.05,
        difficulty: .easy
    )
    
    let bicepCurl = Exercise_t(
        exerciseName: "Bodyweight Bicep Curl",
        exerciseDescription: "A bodyweight exercise that mimics the movement of a bicep curl. Involves pushing yourself up from a low position to focus on the biceps.",
        targettedMuscles: [.bicep],
        isNonActiveExercise: false,
        sets: 4,
        reps: 12,
        perRepCaloriesBurned: 0.8,
        difficulty: .medium
    )
    
    let tricepDips = Exercise_t(
        exerciseName: "Tricep Dips",
        exerciseDescription: "A bodyweight exercise where you lower your body by bending your elbows and then push yourself back up to target the triceps.",
        targettedMuscles: [.triceps],
        isNonActiveExercise: false,
        sets: 4,
        reps: 15,
        perRepCaloriesBurned: 0.1,
        difficulty: .medium
    )
    
    var plank = Exercise_t(
        exerciseName: "Plank",
        exerciseDescription: "A static core exercise where you hold a push-up position with your arms bent, engaging your abs, obliques, and lower back.",
        targettedMuscles: [.core, .obliques],
        isNonActiveExercise: true,
        sets: 3,
        reps: 1,
        perRepCaloriesBurned: 0.2,
        difficulty: .medium,
        image: "plank"
    )
    
    var bicycleCrunch = Exercise_t(
        exerciseName: "Bicycle Crunch",
        exerciseDescription: "A dynamic core exercise where you lie on your back, bring your knee to your opposite elbow, and switch legs while twisting your torso.",
        targettedMuscles: [.core, .obliques],
        isNonActiveExercise: false,
        sets: 3,
        reps: 20,
        perRepCaloriesBurned: 0.08,
        difficulty: .medium
    )
    
    var legRaise = Exercise_t(
        exerciseName: "Leg Raise",
        exerciseDescription: "Lying on your back, raise your legs straight up while keeping your core tight to target your lower abs.",
        targettedMuscles: [.core],
        isNonActiveExercise: false,
        sets: 3,
        reps: 15,
        perRepCaloriesBurned: 0.1,
        difficulty: .medium
    )
    
    var russianTwist = Exercise_t(
        exerciseName: "Russian Twist",
        exerciseDescription: "Sit on the floor with your legs bent and feet flat, then rotate your torso side to side while engaging your obliques.",
        targettedMuscles: [.core, .obliques],
        isNonActiveExercise: false,
        sets: 3,
        reps: 20,
        perRepCaloriesBurned: 0.12,
        difficulty: .medium
    )
    
    var mountainClimbers = Exercise_t(
        exerciseName: "Mountain Climbers",
        exerciseDescription: "A dynamic core exercise where you start in a push-up position and alternate bringing your knees toward your chest rapidly, engaging your core.",
        targettedMuscles: [.core],
        isNonActiveExercise: false,
        sets: 4,
        reps: 20,
        perRepCaloriesBurned: 0.15,
        difficulty: .medium
    )
    
    var pullups: Exercise_t = .init(exerciseName: "Pullups", exerciseDescription: "Find a hanging bar and pull yourself up as high as you can.", targettedMuscles: [.back, .bicep, .core], sets: 3, reps: 12, perRepCaloriesBurned: 1, difficulty: .medium, image: "pullups")
    
    var allExercises: Array<Exercise_t> {
        return [pullups, mountainClimbers, russianTwist, legRaise, bicycleCrunch, plank, bicepCurl, tricepDips, closeGripPushups, calfRaise, bulgarianSplitSquat, gluteBridge, walkingLunge, bodyweightSquat, chestDip, overheadPress, inclinePushUp, benchPress, pushUp]
    }
    
    var chestExercises: Array<Exercise_t> {
        return self.allExercises.filter( {$0.targettedMuscles.contains(.chest)} )
    }
    
    var lowerBodyExercises: Array<Exercise_t> {
        return self.allExercises.filter( {$0.targettedMuscles.contains(.glutes) || $0.targettedMuscles.contains(.calves) || $0.targettedMuscles.contains(.quads) || $0.targettedMuscles.contains(.hamstrings)} )
    }
    
    var armExercises: Array<Exercise_t> {
        return self.allExercises.filter( {$0.targettedMuscles.contains(.bicep) || $0.targettedMuscles.contains(.triceps) || $0.targettedMuscles.contains(.shoulders)} )
    }
    
    var coreExercises: Array<Exercise_t> {
        return self.allExercises.filter( {$0.targettedMuscles.contains(.obliques) || $0.targettedMuscles.contains(.core)} )
    }
    
}

class Workout {
    public static let current = Workout()
    
    let exercise = Exercise.current
    
    let exampleWorkoutList: Array<Workout_t> = [
        .init(workoutName: "Upper Body", workoutDescription: "Build a wider looking shoulders and a fuller chest with this workout. And a stronger one at best too.", workoutCategory: .strength, workoutImage: "upperbody", exercises: [Exercise.current.chestDip, Exercise.current.inclinePushUp, Exercise.current.pushUp, Exercise.current.benchPress]),
        .init(workoutName: "Lower Body", workoutDescription: "Got chicken legs? No problem! With this workout you'll get more dates for sure 😏. Get your guts together, shit is about to get real 🗿.", workoutCategory: .strength, workoutImage: "lowerbody", exercises: [Exercise.current.bodyweightSquat, Exercise.current.calfRaise, Exercise.current.gluteBridge, Exercise.current.walkingLunge]),
        .init(workoutName: "Arm Builder", workoutDescription: "Got No guns? What a looser 😒. Get guns now with this workout or you are gay🤡.", workoutCategory: .strength, workoutImage: "arms", exercises: [Exercise.current.closeGripPushups, Exercise.current.bicepCurl, Exercise.current.tricepDips]),
        .init(workoutName: "Core Create", workoutDescription: "Bro you got family pack instead of 6? Fear not! Be beach ready in only 30 mins a day. Let the girls know you've entered the beach premisis 😉.", workoutCategory: .strength, workoutImage: "core", exercises: [Exercise.current.plank, Exercise.current.bicycleCrunch, Exercise.current.mountainClimbers, Exercise.current.mountainClimbers])
    ]
    
    let chestWorkout: Workout_t = .init(workoutName: "Chest Workout", workoutDescription: "Chest workout for bigger chest, bigger than chiyalis ki chati.", workoutCategory: .strength, workoutImage: "chest", exercises: [Exercise.current.pushUp, Exercise.current.inclinePushUp, Exercise.current.chestDip, Exercise.current.benchPress])
    let armsWorkout: Workout_t = .init(workoutName: "Arm Workout", workoutDescription: "Don't be like Kacchap, have bigger arms.", workoutCategory: .strength, workoutImage: "arms", exercises: [Exercise.current.bicepCurl, Exercise.current.closeGripPushups, Exercise.current.pullups, Exercise.current.tricepDips])
    let coreWorkout: Workout_t = .init(workoutName: "Core Workout", workoutDescription: "Don't have a six pack, don't be a negative rizzler. Get a pack.", workoutCategory: .strength, workoutImage: "", exercises: [Exercise.current.mountainClimbers, Exercise.current.bicycleCrunch, Exercise.current.plank, Exercise.current.russianTwist])
    let fullBodyWorkotu: Workout_t = .init(workoutName: "Full Body Workout", workoutDescription: "Full body workout for when you don't have enought time. You are not a rizzler my friend. 😔", workoutCategory: .strength, workoutImage: "upperbody", exercises: [Exercise.current.pushUp, Exercise.current.pullups, Exercise.current.bulgarianSplitSquat, Exercise.current.plank])
    
    
}

class Agenda: ObservableObject, Observable {
    public static var current = Agenda()
    
    var exampleAgendaList: Array<Agenda_t> = [
        
        .init(title: "User the 'Create Agenda' button to create new agendas.", description: ""),
        .init(title: "Check out the notification area.", description: ""),

        
        
//        .init(title: "Morning Yoga", description: "Start the day with a 30-minute yoga session.", date: Date(), isDone: false),
//        .init(title: "Cardio Workout", description: "Go for a 5 km run or bike ride to boost metabolism.", date: Date().addingTimeInterval(60 * 60 * 2), isDone: false),
//        .init(title: "Breakfast - High Protein", description: "Eat scrambled eggs, spinach, and whole grain toast.", date: Date().addingTimeInterval(60 * 60 * 3), isDone: false),
//        .init(title: "Strength Training", description: "Lift weights for a 45-minute full-body workout.", date: Date().addingTimeInterval(60 * 60 * 5), isDone: false),
//        .init(title: "Lunch - Low Carb", description: "Grilled chicken with a side of mixed greens and avocado.", date: Date().addingTimeInterval(60 * 60 * 7), isDone: false),
//        .init(title: "HIIT Workout", description: "Perform a 20-minute High-Intensity Interval Training session.", date: Date().addingTimeInterval(60 * 60 * 9), isDone: false),
//        .init(title: "Dinner - Balanced", description: "Salmon, quinoa, and steamed vegetables for a balanced meal.", date: Date().addingTimeInterval(60 * 60 * 12), isDone: false),
//        .init(title: "Stretching & Flexibility", description: "Finish the day with 15 minutes of stretching exercises.", date: Date().addingTimeInterval(60 * 60 * 14), isDone: false),
//        .init(title: "Snack - Healthy", description: "Have a protein shake or a handful of almonds.", date: Date().addingTimeInterval(60 * 60 * 16), isDone: false),
//        .init(title: "Sleep - Recovery", description: "Get 7-8 hours of restful sleep to recover and rebuild muscle.", date: Date().addingTimeInterval(60 * 60 * 18), isDone: false)
    ]
    
}

class Food {
    public static var current = Food()
    
    let pizza = Food_t(foodName: "Pizza", foodDescription: "Cheese pizza with pepperoni", foodQuantity: 1, calories: 300, foodImage: "pizza.jpg", foodType: .junk, protein: 15, carbs: 35, fats: 10, recommendation: .noRecommendation)
    let salad = Food_t(foodName: "Salad", foodDescription: "Fresh salad with mixed greens and dressing", foodQuantity: 1, calories: 150, foodImage: "salad.jpg", foodType: .clean, protein: 5, carbs: 15, fats: 7, recommendation: .moreRecommended)
    let burger = Food_t(foodName: "Burger", foodDescription: "Beef burger with cheese and lettuce", foodQuantity: 1, calories: 500, foodImage: "burger.jpg", foodType: .junk, protein: 25, carbs: 40, fats: 30, recommendation: .lessRecommended)
    let smoothie = Food_t(foodName: "Smoothie", foodDescription: "Mixed fruit smoothie with yogurt", foodQuantity: 1, calories: 200, foodImage: "smoothie", foodType: .beverage, protein: 8, carbs: 35, fats: 5, recommendation: .moreRecommended)
    let friedChicken = Food_t(foodName: "Fried Chicken", foodDescription: "Crispy fried chicken wings", foodQuantity: 1, calories: 400, foodImage: "chickenDish", foodType: .junk, protein: 25, carbs: 30, fats: 20, recommendation: .lessRecommended)
    let pasta = Food_t(foodName: "Pasta", foodDescription: "Pasta with marinara sauce", foodQuantity: 1, calories: 350, foodImage: "pasta.jpg", foodType: .junk, protein: 10, carbs: 50, fats: 10, recommendation: .noRecommendation)
    let sandwich = Food_t(foodName: "Sandwich", foodDescription: "Turkey sandwich with lettuce and tomato", foodQuantity: 1, calories: 300, foodImage: "sandwich", foodType: .clean, protein: 20, carbs: 40, fats: 8, recommendation: .moreRecommended)
    let apple = Food_t(foodName: "Apple", foodDescription: "Fresh apple", foodQuantity: 1, calories: 95, foodImage: "apple", foodType: .clean, protein: 0.5, carbs: 25, fats: 0, recommendation: .moreRecommended)
    let icedCoffee = Food_t(foodName: "Iced Coffee", foodDescription: "Iced coffee with milk and sugar", foodQuantity: 1, calories: 120, foodImage: "iced_coffee.jpg", foodType: .beverage, protein: 2, carbs: 15, fats: 4, recommendation: .noRecommendation)
    let donut = Food_t(foodName: "Donut", foodDescription: "Glazed chocolate donut", foodQuantity: 1, calories: 200, foodImage: "donut.jpg", foodType: .junk, protein: 2, carbs: 30, fats: 10, recommendation: .lessRecommended)
    
    
}


class Challenge {
    public static var current = Challenge()
    
    var exampleChallengesList: Array<Challenge_t> = [
        .init(challengeName: "Pushup Contest", challengeImage: "pushups", challengeDescription: "Do a set of 25 pushups in and under 10 seconds.", challengeExtendedDescription: "Perform a set of 25 clean pushups, which by the rule of thumb should be performed with your arms fully extended in front of you, and you chest touching the ground. In and under 10 seconds.", challengeDifficulty: .medium, duration: ApplicationHelper.getSeconds(10)),
        
            .init(
                challengeName: "Squat Contest",
                challengeImage: "squats",
                challengeDescription: "Do a set of 300 squats in and under 5 mins.",
                challengeExtendedDescription: "Perform a set of 30 clean squats. Each squat should have your thighs parallel to the ground, and your back should remain straight. Complete the set in 15 seconds or less.",
                challengeDifficulty: .medium,
                duration: ApplicationHelper.getMinutes(5)
            ),
        .init(
            challengeName: "Marathon Contest",
            challengeImage: "running",
            challengeDescription: "Run a full marathon 400m within 3 mins.",
            challengeExtendedDescription: "The goal of this challenge is to run a full marathon. You need to complete the 400m within 3 mins. Pace yourself and stay hydrated to succeed in this challenge.",
            challengeDifficulty: .hard,
            duration: ApplicationHelper.getMinutes(3)
        )
    ]
}

class Meal: ObservableObject {
    public static var current = Meal()
    
    var exampleMeals: Array<Meal_t> = [
        .init(mealName: "Break Fast ☀️", mealType: .breakfast, foodItems: [Food.current.apple, Food.current.pasta, Food.current.smoothie]),
        .init(mealName: "Lunch 🥚", mealType: .lunch, foodItems: [Food.current.friedChicken, Food.current.burger]),
        .init(mealName: "Dinner 🌚", mealType: .dinner, foodItems: [Food.current.salad, Food.current.pasta, Food.current.icedCoffee]),
    ]
}

class Activity {
    public static var current = Activity()
    
    var exampleActivityList: Array<Activity_t> = [
        .init(activityName: .workoutCompleted, activityDescription: Workout.current.exampleWorkoutList.first!),
        .init(activityName: .mealEaten, activityDescription: Meal.current.exampleMeals.first!),
        .init(activityName: .mealEaten, activityDescription: Food.current.friedChicken)
    ]
}

class User {
    public static var current = User()
    
    var currentUser: User_t = .init(fullName: "Uddeshya Singh", username: "Jettspanner123", emailId: "uddeshyasingh12bsci@gmail.com", password: "Saahil123s", currentWeight: 89, currentHeight: 184, gender: .male, bodyType: .skinnyFat, level: .intermediate, goal: .beFit, dailyPoints: 382, fitnessLevel: 17)
    var exampleUserTwo: User_t = .init(fullName: "Tushar Sourav", username: "TusharKhan123", emailId: "tushar@gmail.com", password: "MyNameIsKhan", currentWeight: 70, currentHeight: 185, gender: .male, bodyType: .skinny, level: .beginner, goal: .buildMuscle)
    
}

class Notification {
    public static var current = Notification()
    
    var notifications: Array<Notification_t> = [
        .init(forUserId: User.current.currentUser.id, notificationName: "Friend Request", notificationDescription: "Mister bihari ji apke friend request aaya hai", notificationType: .friendRequest, notificationAction: FriendRequest_t(fromUser: User.current.exampleUserTwo, toUserId: User.current.currentUser))
    ]
    
    var notificationHistory: Array<Notification_t> = [
        
    ]
    
}


class DailyEvents {
    public static var current = DailyEvents()
    
    var weeklyEvents: Array<DailyEvents_t> = [
        .init(date: .now.add(-6), caloriesBurnedForTheDay: 800, caloriesIngestedForTheDay: 1570, waterIntakeForTheDay: 1000, workoutTimingForTheDay: 32, mealsHad: Meal.current.exampleMeals,workoutsDone: [Workout.current.armsWorkout] ,stepsTaken: 13020),
        .init(date: .now.add(-5), caloriesBurnedForTheDay: 600, caloriesIngestedForTheDay: 1392, waterIntakeForTheDay: 1000, workoutTimingForTheDay: 65, mealsHad: Meal.current.exampleMeals,workoutsDone: [Workout.current.coreWorkout] ,stepsTaken: 15000),
        .init(date: .now.add(-4), caloriesBurnedForTheDay: 700,caloriesIngestedForTheDay: 1888, waterIntakeForTheDay: 1000, workoutTimingForTheDay: 43, mealsHad: Meal.current.exampleMeals, workoutsDone: [Workout.current.chestWorkout] ,stepsTaken: 18000),
        .init(date: .now.add(-3), caloriesBurnedForTheDay: 800, caloriesIngestedForTheDay: 1900, waterIntakeForTheDay: 1000, workoutTimingForTheDay: 55, mealsHad: Meal.current.exampleMeals,workoutsDone: [Workout.current.fullBodyWorkotu] ,stepsTaken: 13000),
        .init(date: .now.add(-2), caloriesBurnedForTheDay: 650, caloriesIngestedForTheDay: 1679, waterIntakeForTheDay: 1000, workoutTimingForTheDay: 39, mealsHad: Meal.current.exampleMeals, workoutsDone: [Workout.current.armsWorkout, Workout.current.chestWorkout],stepsTaken: 15432),
        .init(date: .now.add(-1), caloriesBurnedForTheDay: 790, caloriesIngestedForTheDay: 1218, waterIntakeForTheDay: 1000, workoutTimingForTheDay: 39, mealsHad: Meal.current.exampleMeals, workoutsDone: [Workout.current.armsWorkout, Workout.current.fullBodyWorkotu],stepsTaken: 14325),
        .init(date: .now, caloriesBurnedForTheDay: 900, caloriesIngestedForTheDay: 1833, waterIntakeForTheDay: 1000, workoutTimingForTheDay: 70, mealsHad: Meal.current.exampleMeals, stepsTaken: 13232)
    ]
}

extension Date {
    func add(_ day: Int) -> Date {
        return self.addingTimeInterval(TimeInterval(ONE_DAY * day))
    }
}
