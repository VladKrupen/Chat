//
//  UserStatus.swift
//  Chat
//
//  Created by Vlad on 19.05.24.
//

import Foundation

protocol UserStatus {
    func checkUserAuthorizationStatus(completion: @escaping (Bool?) -> Void)
}
