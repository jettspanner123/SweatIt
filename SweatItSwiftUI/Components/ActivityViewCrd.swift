import SwiftUI

struct ActivityViewCard: View {
    
    var activity: Activity_t
    var body: some View {
        if let workout = self.activity.activityDescription as? Workout_t {
            WorkoutCard(image: workout.workoutImage, name: workout.workoutName, difficulty: workout.workoutDifficulty, sideOffset: 50, isViewCard: true)
        }
        
        if let food = self.activity.activityDescription as? Food_t {
            FoodViewCard(food: food)
        }
        
        //        if let meal = self.activity.activityDescription as? Meal_t {
        //            MealCard(meal: meal)
        //        }
    }
    
}
