import Foundation
import Firebase
import Cloudinary


internal class FirestoreDatabaseSingleton {
    init() { }
    
    public static let current = FirestoreDatabaseSingleton()
    let database = Firestore.firestore()
}


class ApplicationDatabase {
    
    enum Colleciton: String {
        case user, exercises, extraInfo, friendRequest, dailyEvents, dailyActivity, userCustomWorkouts
    }
    
    
    public static let databaseSingleton = FirestoreDatabaseSingleton.current
    
    public static func getDatabase(for collection: ApplicationDatabase.Colleciton) -> CollectionReference {
        return ApplicationDatabase.databaseSingleton.database.collection(collection.rawValue)
    }
    
    public static func getUserFromDictionary(_ docData: [String: Any]) -> User_t {
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
        
        let user: User_t = .init(id: id, fullName: fullName, username: username, emailId: emailId, password: password, currentWeight: currentWeight, currentHeight: currentHeight, gender: gender, bodyType: bodyType, level: level, goal: goal, dailyPoints: dailyPoints, fitnessLevel: fitnessLevel)
        return user
    }
}

internal class CloudinarySingleton {
    init() {
        self.cloudinaryConfig = .init(cloudName: "dqa9dgdso")
        self.cloudinary = .init(configuration: self.cloudinaryConfig)
    }
    public static let current = CloudinarySingleton()
    let cloudinaryConfig: CLDConfiguration!
    let cloudinary: CLDCloudinary!
}


class CloudinaryImageDB {
    public static func setImage(forUserId: String, withImage: Data) -> Void {
        
    }
}

