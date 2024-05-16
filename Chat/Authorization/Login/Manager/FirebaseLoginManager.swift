//
//  FirebaseLoginManager.swift
//  Chat
//
//  Created by Vlad on 16.05.24.
//

import Foundation
import FirebaseAuth

class FirebaseLoginManager: UserAuthentication {
    
    private let auth = Auth.auth()
    
    func authUser(email: String, password: String, completion: @escaping ((any Error)?) -> Void) {
        auth.signIn(withEmail: email, password: password) { _, error in
            completion(error)
        }
    }
}
