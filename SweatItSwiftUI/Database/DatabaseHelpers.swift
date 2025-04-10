import Foundation
import Firebase
import SwiftUI
import MessageUI

enum ErrorType: String, Codable {
    case wentWrong = "Something went wrong! 😅", serverBusy = "Ther server is busy at the given moment. 🥲", cannotParseUser = "Cannot get user from database. 🥺", userNotFound = "User not found. 🥺", authenticationError = "Server could not authenticate. ❌", invalidArguments = "Incorrect Email or Password."
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
        
        print(message.rawValue)
        
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
            
            let tempUser: User_t = .init(id: id,fullName: fullName, username: username, emailId: emailId, password: password, currentWeight: currentWeight, currentHeight: currentHeight, gender: gender, bodyType: bodyType, level: level, goal: goal, dailyPoints: dailyPoints, fitnessLevel: fitnessLevel)
            userArray.append(tempUser)
        }
        
        print(userArray)
        
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
    
}

class PostMethodStore {
    public static let current = PostMethodStore()
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
        
        print(message.rawValue)
        
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

class POST {
    
    func sendOTPTo(email: String) async throws -> Void {
        PostMethodStore.current.startLoading()
        
        defer {
            PostMethodStore.current.endLoading()
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


