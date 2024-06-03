//
//  ChatAppUser.swift
//  Chat
//
//  Created by Vlad on 20.05.24.
//

import Foundation

struct ChatAppUser: Codable {
    let id: String
    let firstname: String
    let lastname: String
    let email: String
    let imageURLString: String
}
