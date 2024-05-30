//
//  LoginModel.swift
//  Chat
//
//  Created by Vlad on 13.05.24.
//

import Foundation

final class LoginModel {
    
    private weak var loginVC: LoginViewController?
    private let userAuthentication: UserAuthentication
    private let googleAuthorization: GoogleAuthorization
    
    init(loginVC: LoginViewController?,
         userAuthentication: FirebaseLoginManager,
         googleAuthorization: GoogleAuthorization) {
        self.loginVC = loginVC
        self.userAuthentication = userAuthentication
        self.googleAuthorization = googleAuthorization
    }
    
    func userLogin(email: String, password: String) {
        guard !email.isEmpty, !password.isEmpty else {
            loginVC?.showAlertUserLoginEmpty()
            return
        }
        
        userAuthentication.authUser(email: email, password: password) { [weak self] error in
            guard error == nil else {
                self?.loginVC?.showAlertIncorrectData()
                return
            }
            self?.loginVC?.moveToMainTabBarController()
        }
    }
    
    func loginUsingGoogle(loginVC: LoginViewController) {
        googleAuthorization.loginUsingGoogle(loginVC: loginVC) { [weak self] error in
            self?.loginVC?.showSpiner()
            guard error == nil else {
                if let error = error {
                    print(error.localizedDescription)
                }
                return
            }
        } succesCompletion: {
            self.loginVC?.moveToMainTabBarController()
            self.loginVC?.hideSpiner()
        }
    }
}
