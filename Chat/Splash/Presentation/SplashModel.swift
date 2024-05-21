//
//  SplashModel.swift
//  Chat
//
//  Created by Vlad on 19.05.24.
//

import Foundation

final class SplashModel {
    
    private weak var splashVC: SplashViewController?
    private let userStatus: UserStatus
    
    init(splashVC: SplashViewController?, userStatus: UserStatus) {
        self.splashVC = splashVC
        self.userStatus = userStatus
    }
    
    func isUserAuthorized() {
        userStatus.checkUserAuthorizationStatus { [weak self] state in
            guard state == true else {
                self?.splashVC?.moveToLoginScreen()
                return
            }
            print("Основная часть")
        }
    }
}
