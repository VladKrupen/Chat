//
//  LoginModel.swift
//  Chat
//
//  Created by Vlad on 13.05.24.
//

import Foundation

final class LoginModel {
    
    private weak var loginVC: LoginViewController?
    private let firebaseLoginManager: FirebaseLoginManager
    
    init(loginVC: LoginViewController?, firebaseLoginManager: FirebaseLoginManager) {
        self.loginVC = loginVC
        self.firebaseLoginManager = firebaseLoginManager
    }
    
    func userLogin(email: String, password: String) {
        guard !email.isEmpty, !password.isEmpty else {
            loginVC?.showAlertUserLoginEmpty()
            return
        }
        
        firebaseLoginManager.authUser(email: email, password: password) { [weak self] error in
            guard error == nil else {
                self?.loginVC?.showAlertIncorrectData()
                return
            }
            self?.loginVC?.moveToMainTabBarController()
        }
    }
}
