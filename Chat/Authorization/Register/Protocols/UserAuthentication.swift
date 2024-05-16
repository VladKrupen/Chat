//
//  UserAuthentication.swift
//  Chat
//
//  Created by Vlad on 16.05.24.
//

import Foundation

protocol UserAuthentication {
    func authUser(email: String, password: String, completion: @escaping (Error?) -> Void)
}
