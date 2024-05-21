//
//  FirebaseUserStatusManager.swift
//  Chat
//
//  Created by Vlad on 19.05.24.
//

import Foundation
import FirebaseAuth

final class FirebaseUserStatusManager: UserStatus {
    
    private let auth = Auth.auth()
    
    func checkUserAuthorizationStatus(completion: @escaping (Bool?) -> Void) {
        auth.addStateDidChangeListener { _, user in
            guard user == nil else {
                completion(true)
                return
            }
            completion(false)
        }
    }
}
