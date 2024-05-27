//
//  ProfileModel.swift
//  Chat
//
//  Created by Vlad on 27.05.24.
//

import Foundation

final class ProfileModel {
    
    private weak var profileVC: ProfileViewController?
    private let logout: Logout
    
    init(profileVC: ProfileViewController, logout: Logout) {
        self.profileVC = profileVC
        self.logout = logout
    }
    
    func logOut() {
        logout.logOut()
        profileVC?.dismiss(animated: true)
    }
}
