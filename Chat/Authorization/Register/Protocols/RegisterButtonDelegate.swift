//
//  RegisterButtonDelegate.swift
//  Chat
//
//  Created by Vlad on 13.05.24.
//

import Foundation

protocol RegisterButtonDelegate: AnyObject {
    func registerButtonPressed(firstname: String, lastname: String, email: String, password: String)
}
