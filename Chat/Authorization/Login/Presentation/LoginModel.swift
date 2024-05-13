//
//  LoginModel.swift
//  Chat
//
//  Created by Vlad on 13.05.24.
//

import Foundation

final class LoginModel {
    
    private weak var loginVC: LoginViewController?
    
    init(loginVC: LoginViewController?) {
        self.loginVC = loginVC
    }
    
    func userLogin(email: String, password: String) {
        guard !email.isEmpty, !password.isEmpty else {
            loginVC?.showAlertUserLoginError()
            return
        }
        print(email)
        print(password)
    }
}
