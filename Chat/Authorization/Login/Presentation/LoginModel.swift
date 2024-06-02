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
        loginVC?.showSpiner()
        guard !email.isEmpty, !password.isEmpty else {
            loginVC?.showAlertUserLoginEmpty()
            loginVC?.hideSpiner()
            return
        }
        
        userAuthentication.authUser(email: email, password: password) { [weak self] error in
            guard error == nil else {
                self?.loginVC?.showAlertIncorrectData()
                self?.loginVC?.hideSpiner()
                return
            }
            self?.loginVC?.moveToMainTabBarController()
            self?.loginVC?.hideSpiner()
        }
    }
    
    func loginUsingGoogle(loginVC: LoginViewController) {
        googleAuthorization.loginUsingGoogle(loginVC: loginVC) { [weak self] in
            self?.loginVC?.showSpiner()
        } errorCompletion: { [weak self] error in
            guard error == nil else {
                if let error = error {
                    print(error.localizedDescription)
                }
                self?.loginVC?.hideSpiner()
                return
            }
        } succesCompletion: { [weak self] in
            self?.loginVC?.moveToMainTabBarController()
            self?.loginVC?.hideSpiner()
        }
    }
}
