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

