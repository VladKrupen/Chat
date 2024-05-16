//
//  RegisterModel.swift
//  Chat
//
//  Created by Vlad on 13.05.24.
//

import Foundation

final class RegisterModel {
    
    weak var registerVC: RegisterViewController?
    private let userAuthentication: UserAuthentication
    
    init(registerVC: RegisterViewController?, userAuthentication: UserAuthentication) {
        self.registerVC = registerVC
        self.userAuthentication = userAuthentication
    }

    func userRegister(firstname: String, lastname: String, email: String, password: String) {
        guard !firstname.isEmpty,
              !lastname.isEmpty,
              !email.isEmpty,
              !password.isEmpty else {
            registerVC?.showAlertUserRegisterEmpty()
            return
        }
        guard password.count >= 6 else {
            registerVC?.showAlertErrorShortPassword()
            return
        }
        userAuthentication.authUser(email: email, password: password) { [weak self] error in
            guard error == nil else {
                self?.registerVC?.showAlertIncorrectEmail()
                return
            }
            
        }
    }
}
