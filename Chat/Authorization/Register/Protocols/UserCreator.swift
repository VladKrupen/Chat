//
//  UserCreator.swift
//  Chat
//
//  Created by Vlad on 20.05.24.
//

import Foundation

protocol UserCreator {
    func createUser(imageURLString: String, firstname: String, lastname: String, email: String, completion: @escaping (Error?) -> Void)
}
