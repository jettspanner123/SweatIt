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
        difficulty: .easy
    )
    
    let benchPress = Exercise_t(
        exerciseName: "Bench Press",
        exerciseDescription: "A barbell exercise where you lower a barbell to your chest and then press it back up.",
        targettedMuscles: [.chest, .shoulders, .triceps],
        isNonActiveExercise: false,
        sets: 4,
        reps: 10,
        perRepCaloriesBurned: 0.15,
        difficulty: .easy
    )
    
    let inclinePushUp = Exercise_t(
        exerciseName: "Incline Push-Up",
        exerciseDescription: "A variation of push-ups where your hands are elevated on a bench or platform.",
        targettedMuscles: [.chest, .shoulders, .triceps],
        isNonActiveExercise: false,
        sets: 3,
        reps: 12,
        perRepCaloriesBurned: 0.08,
        difficulty: .easy
    )
    
    let overheadPress = Exercise_t(
        exerciseName: "Overhead Press",
        exerciseDescription: "A standing exercise where you press a barbell or dumbbell from shoulder height to overhead.",
        targettedMuscles: [.shoulders, .triceps],
        isNonActiveExercise: false,
        sets: 4,
        reps: 8,
        perRepCaloriesBurned: 0.2 ,
        difficulty: .easy
    )
    
    let chestDip = Exercise_t(
        exerciseName: "Chest Dip",
        exerciseDescription: "A bodyweight exercise where you dip down using parallel bars and then press up.",
        targettedMuscles: [.chest, .triceps, .shoulders],
        isNonActiveExercise: false,
        sets: 3,
        reps: 10,
        perRepCaloriesBurned: 0.18,
        difficulty: .easy
    )
    
    let bodyweightSquat = Exercise_t(
        exerciseName: "Bodyweight Squat",
        exerciseDescription: "A lower body exercise that targets the quads, glutes, and hamstrings. Stand with feet shoulder-width apart and squat down while keeping your back straight.",
        targettedMuscles: [.quads, .hamstrings, .glutes],
        isNonActiveExercise: false,
        sets: 4,
        reps: 15,
        perRepCaloriesBurned: 0.1,
        difficulty: .easy
    )
    
    let walkingLunge = Exercise_t(
        exerciseName: "Walking Lunge",
        exerciseDescription: "A dynamic exercise that targets the quads, hamstrings, and glutes. Step forward with one leg, lunge down, and then bring the other leg forward into the next lunge.",
        targettedMuscles: [.quads, .hamstrings, .glutes],
        isNonActiveExercise: false,
        sets: 3,
        reps: 12, // reps per leg
        perRepCaloriesBurned: 0.12,
        difficulty: .easy
    )
    
    let gluteBridge = Exercise_t(
        exerciseName: "Glute Bridge",
        exerciseDescription: "Lying on your back with knees bent, lift your hips off the ground by pushing through your heels, targeting the glutes and hamstrings.",
        targettedMuscles: [.glutes, .hamstrings, .core],
        isNonActiveExercise: false,
        sets: 3,
        reps: 15,
        perRepCaloriesBurned: 0.08,
        difficulty: .easy
    )
    
    let bulgarianSplitSquat = Exercise_t(
        exerciseName: "Bulgarian Split Squat",
        exerciseDescription: "A single-leg squat variation where one leg is elevated on a bench or platform behind you. This exercise targets the quads, hamstrings, and glutes.",
        targettedMuscles: [.quads, .hamstrings, .glutes],
        isNonActiveExercise: false,
        sets: 3,
        reps: 10, // reps per leg
        perRepCaloriesBurned: 0.14,
        difficulty: .easy
    )
    
    let calfRaise = Exercise_t(
        exerciseName: "Calf Raise",
        exerciseDescription: "A simple exercise to target the calves. Stand on a flat surface and raise your heels off the ground, balancing on the balls of your feet.",
        targettedMuscles: [.calves],
        isNonActiveExercise: false,
        sets: 4,
        reps: 20,
        perRepCaloriesBurned: 0.05,
        difficulty: .easy
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
        difficulty: .medium
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
}

class Agenda {
    public static var current = Agenda()
    
    var exampleAgendaList: Array<Agenda_t> = [
        .init(title: "Morning Yoga", description: "Start the day with a 30-minute yoga session.", date: Date(), isDone: false),
        .init(title: "Cardio Workout", description: "Go for a 5 km run or bike ride to boost metabolism.", date: Date().addingTimeInterval(60 * 60 * 2), isDone: false),
        .init(title: "Breakfast - High Protein", description: "Eat scrambled eggs, spinach, and whole grain toast.", date: Date().addingTimeInterval(60 * 60 * 3), isDone: false),
        .init(title: "Strength Training", description: "Lift weights for a 45-minute full-body workout.", date: Date().addingTimeInterval(60 * 60 * 5), isDone: false),
        .init(title: "Lunch - Low Carb", description: "Grilled chicken with a side of mixed greens and avocado.", date: Date().addingTimeInterval(60 * 60 * 7), isDone: false),
        .init(title: "HIIT Workout", description: "Perform a 20-minute High-Intensity Interval Training session.", date: Date().addingTimeInterval(60 * 60 * 9), isDone: false),
        .init(title: "Dinner - Balanced", description: "Salmon, quinoa, and steamed vegetables for a balanced meal.", date: Date().addingTimeInterval(60 * 60 * 12), isDone: false),
        .init(title: "Stretching & Flexibility", description: "Finish the day with 15 minutes of stretching exercises.", date: Date().addingTimeInterval(60 * 60 * 14), isDone: false),
        .init(title: "Snack - Healthy", description: "Have a protein shake or a handful of almonds.", date: Date().addingTimeInterval(60 * 60 * 16), isDone: false),
        .init(title: "Sleep - Recovery", description: "Get 7-8 hours of restful sleep to recover and rebuild muscle.", date: Date().addingTimeInterval(60 * 60 * 18), isDone: false)
    ]
    
}

class DailyEvents {
    public static var current = DailyEvents()
    
    var exerciseOfTheDay: Array<Exercise_t> = [
        Exercise.current.pushUp,
        Exercise.current.bodyweightSquat
    ]
}

enum FoodItems: String, CaseIterable {
    case friedChicken
    case salad
    case pizza
    case smoothie
    case burger
    
    // Access the food items by enum case
    var food: Food_t {
        switch self {
        case .friedChicken:
            return Food_t(foodName: "Fried Chicken", foodDescription: "Crispy fried chicken wings", foodQuantity: 200, calories: 400, foodImage: "fried_chicken.jpg", foodType: .junk, protein: 25, carbs: 30, fats: 20, recommendation: .lessRecommended)
        case .salad:
            return Food_t(foodName: "Salad", foodDescription: "Fresh green salad with vegetables", foodQuantity: 150, calories: 100, foodImage: "salad.jpg", foodType: .clean, protein: 5, carbs: 10, fats: 5, recommendation: .moreRecommended)
        case .pizza:
            return Food_t(foodName: "Pizza", foodDescription: "Cheese pizza with toppings", foodQuantity: 250, calories: 600, foodImage: "pizza.jpg", foodType: .junk, protein: 15, carbs: 60, fats: 25, recommendation: .noRecommendation)
        case .smoothie:
            return Food_t(foodName: "Smoothie", foodDescription: "Healthy fruit smoothie", foodQuantity: 200, calories: 150, foodImage: "smoothie.jpg", foodType: .beverage, protein: 3, carbs: 35, fats: 1, recommendation: .moreRecommended)
        case .burger:
            return Food_t(foodName: "Burger", foodDescription: "Beef burger with cheese", foodQuantity: 300, calories: 500, foodImage: "burger.jpg", foodType: .junk, protein: 25, carbs: 40, fats: 30, recommendation: .lessRecommended)
        }
    }
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

class Activity {
    public static var current = Activity()
    
    var exampleActivityList: Array<Activity_t> = [
        .init(activityName: .workoutCompleted, activityDescription: Workout.current.exampleWorkoutList.first!),
    ]
}

