import SwiftUI

struct DynamicLoadingScreen: View {
    @EnvironmentObject var appStates: ApplicationStates
    @Binding var showSplashScreen: Bool
    
    @State var scaleX: CGFloat = .zero
    @State var isDataLoading: Bool = false
    @StateObject var applicationHelperStateObject = ApplicationHelper()
    
    
    var body: some View {
        VStack {
            Image(ApplicationImages.dumbbellSVG)
                .resizable()
                .frame(width: 100, height: 75)
            
            if self.appStates.isDataLoading {
                ProgressView()
                    .tint(.white)
                    .transition(.blurReplace.combined(with: .scale))
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(ApplicationLinearGradient.redGradient)
        .onAppear {
            
            enum CombinedItem: Hashable {
                case workout(Workout_t)
                case meal(Meal_t)
            }
            
            Task {
                self.appStates.dailyEvents = try await ApplicationEndpoints.get.getCurrentDayCurrentUserDailyEvents()
                
                let mealArray = self.appStates.dailyEvents.mealsHad.map { CombinedItem.meal($0) }
                let workoutArray = self.appStates.dailyEvents.workoutsDone.map { CombinedItem.workout($0) }
                
                let bothMealAndWorkoutCombined = Array(Set(mealArray + workoutArray).shuffled().prefix(3))
                var finalActivityArray: Array<Activity_t> = []
                
                for item in bothMealAndWorkoutCombined {
                    switch item {
                    case .meal(let meal):
                        finalActivityArray.append(.init(activityName: .mealEaten, activityDescription: meal))
                    case .workout(let workout):
                        finalActivityArray.append(.init(activityName: .workoutCompleted, activityDescription: workout))
                    }
                }
                
                self.appStates.dailyActivities = finalActivityArray
                
                withAnimation {
                    self.appStates.isDataLoading = false
                }
                
                if let user_t = ApplicationHelper.getCurrentUserFromUserDefaults() {
                    User.current.setCurrentUser(user_t)
                }
            }
        }
    }
}

