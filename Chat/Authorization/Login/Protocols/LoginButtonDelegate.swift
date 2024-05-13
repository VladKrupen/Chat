//
//  LoginButtonDelegate.swift
//  Chat
//
//  Created by Vlad on 13.05.24.
//

import Foundation

protocol LoginButtonDelegate: AnyObject {
    func loginButtonPressed(email: String, password: String)
}
