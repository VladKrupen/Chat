//
//  FirebaseRegistrationManager.swift
//  Chat
//
//  Created by Vlad on 16.05.24.
//

import Foundation
import FirebaseAuth

final class FirebaseRegistrationManager: UserAuthentication {
    
    private let auth = Auth.auth()
    
    func authUser(email: String, password: String, completion: @escaping ((any Error)?) -> Void) {
        auth.createUser(withEmail: email, password: password) { _, error in
            completion(error)
        }
    }
}
