import Foundation
import Firebase
import SwiftUI



class DatabaseError: ObservableObject {
    
    
    enum ErrorType: String, Codable {
        case wentWrong = "Something went wrong! 😅"
    }
    
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
}


public class GET {
    @StateObject var databaseError = DatabaseError()
       
        
}

public class POST {
    @StateObject var databaseError = DatabaseError()
    
    public func updateUsersOnDatabase() -> Void {
        let allUsers: Array<User_t> = User.current.allUsers
        
        for user in allUsers {
            let collectionReference: DocumentReference = ApplicationDatabase.getDatabase(for: .user).document(user.id)
            collectionReference.setData(user.getDictionary()) { error in
                if let _ = error {
                    self.databaseError.toggleErrorState(with: .wentWrong)
                    return
                }
                
                print("User's data updated to firebase✅")
            }
        }
    }
}

public class UPDATE {
    
}

public class DELETE {
    
}

public class ApplicationEndpoints {
    public static let get = GET()
    public static let post = POST()
    public static let update = UPDATE()
    public static let delete = DELETE()
}


