//
//  FirebaseProfileManager.swift
//  Chat
//
//  Created by Vlad on 27.05.24.
//

import Foundation
import FirebaseAuth

final class FirebaseProfileManager: Logout {
    
    private let auth = Auth.auth()
    
    func logOut() {
        try? auth.signOut()
    }
}
