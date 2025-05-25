import Foundation
import Firebase
import SwiftUI
import MessageUI


enum ErrorType: String, Codable {
    case wentWrong = "Something went wrong! 😅", serverBusy = "Ther server is busy at the given moment. 🥲", cannotParseUser = "Cannot get user from database. 🥺", userNotFound = "User not found. 🥺", authenticationError = "Server could not authenticate. ❌", invalidArguments = "Incorrect Email or Password.", dataNotLoaded = "Data could not be loaded."
}

enum DatabaseLoadingState: String, Codable {
   case loading = "Loading", loaded = "Loaded"
}

class GetMethodStore: ObservableObject {
    public static let current = GetMethodStore()
    private init() {
        
    }
    
    @Published var isDatabaseLoading: Bool = false {
        didSet {
            print(self.isDatabaseLoading)
        }
    }
    @Published var databaseState: DatabaseLoadingState = .loaded
    
    
    @Published var isError: Bool = false
    @Published var errorMessage: ErrorType = .wentWrong
    
    public func toggleErrorState(with message: ErrorType) -> Void {
        
        
        self.errorMessage = message
        
        withAnimation {
            self.isError = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            withAnimation {
                self.isError = false
            }
            
            self.errorMessage = .wentWrong
        }
    }
    
    func startLoading() -> Void {
        
        if self.isDatabaseLoading || self.databaseState == .loading { return }
        
        withAnimation {
            self.databaseState = .loading
            self.isDatabaseLoading = true
        }
    }
    
    func endLoading() -> Void {
        if !self.isDatabaseLoading || self.databaseState == .loaded { return }
        
        withAnimation {
            self.isDatabaseLoading = false
            self.databaseState = .loaded
        }
    }
    
}


class GET {
   
    
    public func fetchAllUsersFromDatabase() async throws -> Array<User_t> {
        var userArray: Array<User_t> = []
        
        GetMethodStore.current.startLoading()
        
        defer {
            GetMethodStore.current.endLoading()
        }
        
        let snapshotQuery = try await ApplicationDatabase.getDatabase(for: .user).getDocuments(source: .server)
        
        
        for document in snapshotQuery.documents {
            let docData = document.data()
            let id: String = docData[Constants.id.rawValue] as! String
            let fullName = docData[Constants.fullName.rawValue] as! String
            let username = docData[Constants.username.rawValue] as! String
            let emailId = docData[Constants.emailId.rawValue] as! String
            let password = docData[Constants.password.rawValue] as! String
            let currentWeight: Double = docData[Constants.currentWeight.rawValue] as! Double
            let currentHeight: Double = docData[Constants.currentHeight.rawValue] as! Double
            let gender: Extras.Gender = Extras.Gender(rawValue: docData[Constants.gender.rawValue] as! String)!
            let bodyType: Extras.BodyType = Extras.BodyType(rawValue: docData[Constants.bodyType.rawValue] as! String)!
            let level: Extras.UserLevel = Extras.UserLevel(rawValue: docData[Constants.level.rawValue] as! String)!
            let goal: Extras.Goal = Extras.Goal(rawValue: docData[Constants.goal.rawValue] as! String)!
            let dailyPoints: Int = docData[Constants.dailyPoints.rawValue] as! Int
            let fitnessLevel: Int = docData[Constants.fitnessLevel.rawValue] as! Int
            
            let tempUser: User_t = .init(id: id,fullName: fullName, username: username, emailId: emailId, password: password, currentWeight: currentWeight, currentHeight: currentHeight, gender: gender, bodyType: bodyType, level: level, goal: goal, dailyPoints: dailyPoints, fitnessLevel: fitnessLevel)
            userArray.append(tempUser)
        }
        
//        print(userArray)
        
        return userArray
    }
    
    public func fetchUserBy(id: String) async throws -> Optional<User_t> {
        var user: Optional<User_t> = nil
        
        GetMethodStore.current.startLoading()
        
        defer {
            GetMethodStore.current.endLoading()
        }
        
        do {
            let snapshot  = try await ApplicationDatabase.getDatabase(for: .user).getDocuments(source: .server)
            
            for document in snapshot.documents {
                let docData = document.data()
                if docData[Constants.id.rawValue] as! String == id {
                    let id = docData[Constants.id.rawValue] as! String
                    let fullName = docData[Constants.fullName.rawValue] as! String
                    let username = docData[Constants.username.rawValue] as! String
                    let emailId = docData[Constants.emailId.rawValue] as! String
                    let password = docData[Constants.password.rawValue] as! String
                    let currentWeight: Double = docData[Constants.currentWeight.rawValue] as! Double
                    let currentHeight: Double = docData[Constants.currentHeight.rawValue] as! Double
                    let gender: Extras.Gender = Extras.Gender(rawValue: docData[Constants.gender.rawValue] as! String)!
                    let bodyType: Extras.BodyType = Extras.BodyType(rawValue: docData[Constants.bodyType.rawValue] as! String)!
                    let level: Extras.UserLevel = Extras.UserLevel(rawValue: docData[Constants.level.rawValue] as! String)!
                    let goal: Extras.Goal = Extras.Goal(rawValue: docData[Constants.goal.rawValue] as! String)!
                    let dailyPoints: Int = docData[Constants.dailyPoints.rawValue] as! Int
                    let fitnessLevel: Int = docData[Constants.fitnessLevel.rawValue] as! Int
                    
                    user = .init(id: id, fullName: fullName, username: username, emailId: emailId, password: password, currentWeight: currentWeight, currentHeight: currentHeight, gender: gender, bodyType: bodyType, level: level, goal: goal, dailyPoints: dailyPoints, fitnessLevel: fitnessLevel)
                }
            }
        } catch {
            GetMethodStore.current.toggleErrorState(with: .wentWrong)
            return nil
        }
        
        return user
    }
        
    public func getUserBy(username: String) async throws -> Optional<User_t> {
        var user: Optional<User_t> = nil
        
        GetMethodStore.current.startLoading()
        
        defer {
            GetMethodStore.current.endLoading()
        }
        
        do {
            let snapshot = try await ApplicationDatabase.getDatabase(for: .user).getDocuments(source: .server)
            for document in snapshot.documents {
                let docData = document.data()
                user = ApplicationHelper.getUserFrom(dictionary: docData)
            }
        } catch {
            GetMethodStore.current.toggleErrorState(with: .cannotParseUser)
            return nil
        }
        
        return user
    }
    
    public func authenticateUser(by username: String, and password: String) async throws -> Optional<User_t> {
        var user: Optional<User_t> = nil
        
        GetMethodStore.current.startLoading()
        
        defer {
            GetMethodStore.current.endLoading()
        }
        
        
        do {
            let snapshot = try await ApplicationDatabase.getDatabase(for: .user).getDocuments(source: .server)
            
            for document in snapshot.documents {
                let docData = document.data()
                let user_t: User_t = ApplicationHelper.getUserFrom(dictionary: docData)
                
                if user_t.username.lowercased() == username && user_t.password == password {
                    user = user_t
                    return user
                }
            }
        } catch {
            GetMethodStore.current.toggleErrorState(with: .userNotFound)
        }
        
        GetMethodStore.current.toggleErrorState(with: .invalidArguments)
        return nil
    }
    
    public func getAllRequests() async throws -> Array<FriendRequest_t> {
        PostMethodStore.current.startLoading()
        
        defer {
            PostMethodStore.current.endLoading()
        }
        
        let snapshot = try await ApplicationDatabase.getDatabase(for: .friendRequest).getDocuments()
        
        var requests: Array<FriendRequest_t> = []
        
        for snapshotDocument in snapshot.documents {
            let docData = snapshotDocument.data()
            let fromUserId: String = docData["fromUser"] as! String
            let toUserId: String = docData["toUser"] as! String
            let status: Extras.FriendRequestStatus = Extras.FriendRequestStatus(rawValue: docData["status"] as! String)!
            requests.append(.init(fromUser: fromUserId, toUserId: toUserId, requestDate: .now, actionDate: .now, status: status))
        }
        
        return requests
    }
    
    public func hasRequested(from fromUser: String, to toUser: String) async throws -> Bool {
        GetMethodStore.current.startLoading()
        
        defer {
            GetMethodStore.current.endLoading()
        }
        
        let snapshot = try await ApplicationDatabase.getDatabase(for: .friendRequest).getDocuments()
        
        for document in snapshot.documents {
            let docData = document.data()
            let fromUserId: String = docData["fromUser"] as! String
            let toUserId: String = docData["toUser"] as! String
            
            if fromUserId == fromUser && toUserId == toUser {
                return true
            }
        }
        
        return false
    }
    
    public func getAllFriendsFor(userId id: String) async throws -> Array<User_t> {
        var users: Array<User_t> = []
        var requests: Array<FriendRequest_t> = []
        
        GetMethodStore.current.startLoading()
        
        defer {
            GetMethodStore.current.endLoading()
        }
        
        let snapshot = try await ApplicationDatabase.getDatabase(for: .friendRequest).getDocuments()
        
        do {
            for document in snapshot.documents {
                let docData = document.data()
                let friendRequest: FriendRequest_t = .init(id: docData["id"] as! String, fromUser: docData["fromUser"] as! String, toUserId: docData["toUser"] as! String, status: Extras.FriendRequestStatus(rawValue: docData["status"] as! String)!)
                requests.append(friendRequest)
            }
            
            for request in requests {
                if request.status == .accepted {
                    let user_t: User_t = try await self.fetchUserBy(id: request.toUserId)!
                    users.append(user_t)
                }
            }
        } catch {
            GetMethodStore.current.toggleErrorState(with: .serverBusy)
        }
        
        return users
    }
    
    public func getAllRequestsFor(userId id: String) async throws -> Array<FriendRequest_t> {
        var requests: Array<FriendRequest_t> = []
        
        GetMethodStore.current.startLoading()
        
        defer {
            GetMethodStore.current.endLoading()
        }
        
        let snapshot = try await ApplicationDatabase.getDatabase(for: .friendRequest).getDocuments()
        
        do {
            for document in snapshot.documents {
                let docData = document.data()
                let fromUserId: String = docData["fromUser"] as! String
                let toUserId: String = docData["toUser"] as! String
                
                let friendRequest_t: FriendRequest_t = .init(fromUser: fromUserId, toUserId: toUserId)
                requests.append(friendRequest_t)
            }
        } catch {
            GetMethodStore.current.toggleErrorState(with: .wentWrong)
        }
        
        return requests
   }
    
    public func getCurrentDayCurrentUserDailyEvents() async throws  -> DailyEvents_t {
        var finalReturn: DailyEvents_t = .init()
        GetMethodStore.current.startLoading()
        
        defer {
            GetMethodStore.current.endLoading()
        }
        
        do {
            let snapshot: QuerySnapshot = try await ApplicationDatabase.getDatabase(for: .dailyEvents).getDocuments(source: .server)
            for document in snapshot.documents {
                let documentId = document.documentID
                let date_t = documentId.split(separator: "~")[1]
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                dateFormatter.timeZone = TimeZone(identifier: "Asia/Kolkata")
                
                
                // MARK: If date if found for today
                if let fetchedDate = dateFormatter.date(from: String(date_t)) {
                    if Calendar.current.isDate(fetchedDate, inSameDayAs: .now) {
                        let fetchedDailyEvents: DailyEvents_t = try document.data(as: DailyEvents_t.self)
                        finalReturn = fetchedDailyEvents
                        return fetchedDailyEvents
                    } else {
                        GetMethodStore.current.toggleErrorState(with: .dataNotLoaded)
                    }
                }
            }
        } catch {
            GetMethodStore.current.toggleErrorState(with: .wentWrong)
        }
        
        return finalReturn
    }
    
    public func getWeeklyCalories(forUserId: String) async throws -> Dictionary<Date, Double> {
        
        GetMethodStore.current.startLoading()
        
        defer {
            GetMethodStore.current.endLoading()
        }
        
        var finalReturn: Dictionary<Date, Double> = [:]
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        
        do {
            let snapshot = try await ApplicationDatabase.getDatabase(for: .dailyEvents).getDocuments(source: .server)
            
            for document in snapshot.documents {
                let currentDailyEvent: DailyEvents_t = try document.data(as: DailyEvents_t.self)
                let documentId = document.documentID.split(separator: "~").last!
                print("Document id: ", documentId)
                if let unwrappedDate = dateFormatter.date(from: String(documentId)) {
                    finalReturn[unwrappedDate] = currentDailyEvent.caloriesBurnedForTheDay
                }
            }
        } catch {
            GetMethodStore.current.toggleErrorState(with: .dataNotLoaded)
        }
        return finalReturn
    }
    
    public func getWeeklySteps(forUserId: String) async throws -> Dictionary<Date, Int> {
        
        GetMethodStore.current.startLoading()
        
        defer {
            GetMethodStore.current.endLoading()
        }
        var finalReturn: Dictionary<Date, Int> = [:]
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        
        do {
            let snapshot: QuerySnapshot = try await ApplicationDatabase.getDatabase(for: .dailyEvents).getDocuments(source: .server)
            
            for document in snapshot.documents {
                let currentDailyEvent: DailyEvents_t = try document.data(as: DailyEvents_t.self)
                let documentId = document.documentID.split(separator: "~").last!
                if let unwrappedDate = dateFormatter.date(from: String(documentId)) {
                    finalReturn[unwrappedDate] = currentDailyEvent.stepsTaken
                }
            }
            
        } catch {
            GetMethodStore.current.toggleErrorState(with: .dataNotLoaded)
        }
        
        return finalReturn
    }
    
    public func getWeeklyWaterIntake(forUserId: String) async throws -> Dictionary<Date, Int> {
        
        GetMethodStore.current.startLoading()
        
        defer {
            GetMethodStore.current.endLoading()
        }
        var finalReturn: Dictionary<Date, Int> = [:]
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        
        do {
            let snapshot: QuerySnapshot = try await ApplicationDatabase.getDatabase(for: .dailyEvents).getDocuments(source: .server)
            
            for document in snapshot.documents {
                let currentDailyEvent: DailyEvents_t = try document.data(as: DailyEvents_t.self)
                let documentId = document.documentID.split(separator: "~").last!
                if let unwrappedDate = dateFormatter.date(from: String(documentId)) {
                    finalReturn[unwrappedDate] = currentDailyEvent.waterIntakeForTheDay
                }
            }
            
        } catch {
            GetMethodStore.current.toggleErrorState(with: .dataNotLoaded)
        }
        
        return finalReturn
    }
    
    public func getWeeklyWorkoutTimings(forUserId: String) async throws -> Dictionary<Date, Double> {
        
        GetMethodStore.current.startLoading()
        
        defer {
            GetMethodStore.current.endLoading()
        }
        var finalReturn: Dictionary<Date, Double> = [:]
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        
        do {
            let snapshot: QuerySnapshot = try await ApplicationDatabase.getDatabase(for: .dailyEvents).getDocuments(source: .server)
            
            for document in snapshot.documents {
                let currentDailyEvent: DailyEvents_t = try document.data(as: DailyEvents_t.self)
                let documentId = document.documentID.split(separator: "~").last!
                if let unwrappedDate = dateFormatter.date(from: String(documentId)) {
                    var workoutTiming: Double = .zero
                    for workout in currentDailyEvent.workoutsDone {
                        workoutTiming += workout.timeTaken
                    }
                    finalReturn[unwrappedDate] = workoutTiming
                }
            }
            
        } catch {
            GetMethodStore.current.toggleErrorState(with: .dataNotLoaded)
        }
        
        return finalReturn
    }
    
    public func getWeeklyMacroNutritions(forUserId: String) async throws -> Dictionary<Date, (protein: Double, carbs: Double, fats: Double, caloriesForTheDay: Double)> {
        
        GetMethodStore.current.startLoading()
        
        defer {
            GetMethodStore.current.endLoading()
        }
        var finalReturn: Dictionary<Date, (protein: Double, carbs: Double, fats: Double, caloriesForTheDay: Double)> = [:]
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        
        do {
            let snapshot: QuerySnapshot = try await ApplicationDatabase.getDatabase(for: .dailyEvents).getDocuments(source: .server)
            
            for document in snapshot.documents {
                let currentDailyEvent: DailyEvents_t = try document.data(as: DailyEvents_t.self)
                let documentId = document.documentID.split(separator: "~").last!
                if let unwrappedDate = dateFormatter.date(from: String(documentId)) {
                    var protien: Double = .zero, carbs: Double = .zero, fats: Double = .zero
                    
                    for meal in currentDailyEvent.mealsHad {
                        for foodItem in meal.foodItems {
                            protien += foodItem.protein
                            carbs += foodItem.carbs
                            fats += foodItem.fats
                        }
                    }
                    
                    finalReturn[unwrappedDate] = (protien, carbs, fats, currentDailyEvent.caloriesIngestedForTheDay)
                }
            }
            
        } catch {
            GetMethodStore.current.toggleErrorState(with: .dataNotLoaded)
        }
        
        return finalReturn
    }
    
    public func getCustomWorkouts(forUserId: String) async throws -> Array<Workout_t> {
        var finalReturn: Array<Workout_t> = []
        print("---------------From Getting Custom Workouts---------------")
        do {
            let snapshot: QuerySnapshot = try await ApplicationDatabase.getDatabase(for: .userCustomWorkouts).getDocuments(source: .server)
            
            for document in snapshot.documents {
                let userId: String = String(document.documentID.split(separator: "~").first!)
                let docData = try document.data(as: Workout_t.self)
                
                
                if userId == User.current.currentUser.id {
                    finalReturn.append(docData)
                }
            }
        } catch {
            GetMethodStore.current.toggleErrorState(with: .dataNotLoaded)
        }
        
        return finalReturn
    }
    
    
    
}








// MARK: Post method store

class PostMethodStore: ObservableObject {
    public static let current = PostMethodStore()
    
    
    @Published var isDatabaseLoading: Bool = false {
        didSet {
            print(self.isDatabaseLoading)
        }
    }
    @Published var databaseState: DatabaseLoadingState = .loaded
    
    
    @Published var isError: Bool = false
    @Published var errorMessage: ErrorType = .wentWrong
    @Published var testError: Bool = false
    
    public func toggleErrorState(with message: ErrorType) -> Void {
        
        
        self.errorMessage = message
        
        withAnimation {
            self.isError = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            withAnimation {
                self.isError = false
            }
            
            self.errorMessage = .wentWrong
        }
    }
    
    func startLoading() -> Void {
        
        if self.isDatabaseLoading || self.databaseState == .loading { return }
        
        withAnimation {
            self.databaseState = .loading
            self.isDatabaseLoading = true
        }
    }
    
    func endLoading() -> Void {
        if !self.isDatabaseLoading || self.databaseState == .loaded { return }
        
        withAnimation {
            self.isDatabaseLoading = false
            self.databaseState = .loaded
        }
    }
    
}





// MARK: Post method
class POST {
    
    func sendOTPTo(email: String) async throws -> Void {
        PostMethodStore.current.startLoading()
        
        defer {
            PostMethodStore.current.endLoading()
        }
        
    }
    
    func autoUpdateCurrentUserDetails(withId id: String) async throws -> Void {
        if id.isEmpty {
            return
        }
        
        PostMethodStore.current.startLoading()
        
        defer {
            PostMethodStore.current.endLoading()
        }
        
        let snapshot = try await ApplicationDatabase.getDatabase(for: .user).getDocuments(source: .server)
        
        for document in snapshot.documents {
            let docData: Dictionary<String, Any> = document.data()
            let temp_user: User_t = ApplicationHelper.getUserFrom(dictionary: docData)
            
            if temp_user.id == id {
                let user_reference_on_database: DocumentReference = ApplicationDatabase.getDatabase(for: .user).document(id)
                try await user_reference_on_database.setData(User.current.currentUser.getDictionary())
                return
            }
        }
    }
    
    func autoUpdateCurrentUserDailyEvents(for dailyEvents: DailyEvents_t) async throws -> Void {
        if User.current.currentUser.id.isEmpty { return }
        
        PostMethodStore.current.startLoading()
        
        defer {
            PostMethodStore.current.endLoading()
        }
        
        do {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            dateFormatter.timeZone = TimeZone(identifier: "Asia/Kolkata") // Or local if needed
            
            let dateString = dateFormatter.string(from: Date())
           
            let snapshot: DocumentReference = ApplicationDatabase.getDatabase(for: .dailyEvents).document("\(User.current.currentUser.id)~\(dateString)")
            try snapshot.setData(from: dailyEvents)
            
        } catch {
            print("Some error occurred while fetching data!")
        }
    }
    
    func createNewUser(with user: User_t, andInfo info: ExtraInfo_t) async throws {
        PostMethodStore.current.startLoading()
        
        defer {
            PostMethodStore.current.endLoading()
        }
        
        let userReference: DocumentReference = ApplicationDatabase.getDatabase(for: .user).document(user.id)
        let extraInfoReference: DocumentReference = ApplicationDatabase.getDatabase(for: .extraInfo).document(info.id)
        
        do {
            try await userReference.setData(user.getDictionary())
            try await extraInfoReference.setData(info.getDictionary())
            
            User.current.currentUser = user
        } catch {
            PostMethodStore.current.toggleErrorState(with: .serverBusy)
            return
        }
    }
    
    public func createRequest(from fromUser: User_t, to toUser: User_t) async throws -> Void {
        PostMethodStore.current.startLoading()
        
        defer {
            PostMethodStore.current.endLoading()
        }
        
        let friendRequest: FriendRequest_t = .init(fromUser: fromUser.id, toUserId: toUser.id)
        let friendRequestReference: DocumentReference = ApplicationDatabase.getDatabase(for: .friendRequest).document(friendRequest.id)
        
        do {
            try await friendRequestReference.setData(friendRequest.getDictionary())
            ApplicationSounds.current.successful()
        } catch {
            PostMethodStore.current.toggleErrorState(with: .wentWrong)
            ApplicationSounds.current.successful()
        }
        
    }
    
    public func addCustomWorkout(forUserId: String, workout: Workout_t) async throws -> Void {
        PostMethodStore.current.startLoading()
        
        defer {
            PostMethodStore.current.endLoading()
        }
        
        do {
            let customWorkoutDatabaseReference = ApplicationDatabase.getDatabase(for: .userCustomWorkouts).document("\(User.current.currentUser.id)~\(workout.id)")
            try customWorkoutDatabaseReference.setData(from: workout)
        } catch {
            PostMethodStore.current.toggleErrorState(with: .dataNotLoaded)
        }
    }
    
    public func setCaloriesBurnedForTheDay(forUserId: String, withCalories: Double) async throws -> Void {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        do {
            let documentRef: DocumentReference = ApplicationDatabase.getDatabase(for: .dailyEvents).document("\(forUserId)~\(dateFormatter.string(from: Date()))")
            try await documentRef.updateData(["caloriesBurnedForTheDay": withCalories])
        } catch {
            PostMethodStore.current.toggleErrorState(with: .dataNotLoaded)
        }
    }
    
    public func setWorkoutTimingsForTheDay(forUserId: String, workoutTiming: Double) async throws -> Void {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        print("Workout array is changed brrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr")
        
        do {
            let documentRef: DocumentReference = ApplicationDatabase.getDatabase(for: .dailyEvents).document("\(forUserId)~\(dateFormatter.string(from: Date()))")
            try await documentRef.updateData(["workoutTimingForTheDay": workoutTiming])
        } catch {
            PostMethodStore.current.toggleErrorState(with: .dataNotLoaded)
        }
    }
    
}

class UPDATE {
    
}

class DELETE {
    
}

class ApplicationEndpoints {
    public static let get = GET()
    public static let post = POST()
    public static let update = UPDATE()
    public static let delete = DELETE()
}


