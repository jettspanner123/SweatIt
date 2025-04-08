import Foundation
import Firebase


internal class FirestoreDatabaseSingleton {
    init() { }
    
    public static let current = FirestoreDatabaseSingleton()
    let database = Firestore.firestore()
}


class ApplicationDatabase {
    
    enum Colleciton: String {
        case user, exercises
    }
    
    
    public static let databaseSingleton = FirestoreDatabaseSingleton.current
    
    public static func getDatabase(for collection: ApplicationDatabase.Colleciton) -> CollectionReference {
        return ApplicationDatabase.databaseSingleton.database.collection(collection.rawValue)
    }
}

