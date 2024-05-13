//
//  RegisterModel.swift
//  Chat
//
//  Created by Vlad on 13.05.24.
//

import Foundation

final class RegisterModel {
    
    weak var registerVC: RegisterViewController?
    
    init(registerVC: RegisterViewController?) {
        self.registerVC = registerVC
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
        print(firstname)
    }
}
