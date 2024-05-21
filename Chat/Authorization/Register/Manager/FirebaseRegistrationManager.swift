//
//  FirebaseRegistrationManager.swift
//  Chat
//
//  Created by Vlad on 16.05.24.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

final class FirebaseRegistrationManager: UserAuthentication, UserCreator {
    
    private let auth = Auth.auth()
    private let databaseRef = Database.database(url: "https://chat-b2805-default-rtdb.europe-west1.firebasedatabase.app").reference()
    
    func authUser(email: String, password: String, completion: @escaping ((any Error)?) -> Void) {
        auth.createUser(withEmail: email, password: password) { _, error in
            completion(error)
        }
    }
    
    func createUser(firstname: String, lastname: String, email: String, completion: @escaping ((any Error)?) -> Void) {
        guard let userId = auth.currentUser?.uid else {
            let error = NSError(domain: "Не удалось получить id", code: 401)
            completion(error)
            return
        }
        
        let newUser = ChatAppUser(id: userId, firstname: firstname, lastname: lastname, email: email)
        
        guard let userData = try? JSONEncoder().encode(newUser) else {
            let error = NSError(domain: "Не получилось создать данные", code: 401)
            completion(error)
            return
        }
        
        guard let userJSON = try? JSONSerialization.jsonObject(with: userData) as? [String: Any] else {
            let error = NSError(domain: "Не получислось получить словарь", code: 401)
            completion(error)
            return
        }
        
        self.databaseRef.child("Users").child(userId).updateChildValues(userJSON) { error, _ in
            completion(error)
        }
    }
}
