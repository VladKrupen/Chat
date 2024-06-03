//
//  RegisterModel.swift
//  Chat
//
//  Created by Vlad on 13.05.24.
//

import Foundation

final class RegisterModel {
    
    var selectedImageData: Data = Data()
    
    private weak var registerVC: RegisterViewController?
    private let userAuthentication: UserAuthentication
    private let userCreator: UserCreator
    private let imageUploader: ImageUploader
    
    private let firebase: FirebaseRegistrationManager
    
    init(registerVC: RegisterViewController?, userAuthentication: UserAuthentication, userCreator: UserCreator, firebase: FirebaseRegistrationManager, imageUploader: ImageUploader) {
        self.registerVC = registerVC
        self.userAuthentication = userAuthentication
        self.userCreator = userCreator
        self.firebase = firebase
        self.imageUploader = imageUploader
    }

    func userRegister(image: Data, firstname: String, lastname: String, email: String, password: String) {
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
        registerVC?.showSpiner()
        userAuthentication.authUser(email: email, password: password) { [weak self] error in
            guard error == nil else {
                self?.registerVC?.showAlertIncorrectEmail()
                self?.registerVC?.hideSpiner()
                return
            }
            var imageString: String = String()
            self?.firebase.uploadImage(image: image, completion: { [weak self] result in
                switch result {
                case .success(let imageURLString):
                    imageString = imageURLString
                case .failure(let error):
                    print(error)
                }
            }, completionCreate: {
                self?.userCreator.createUser(imageURLString: imageString, firstname: firstname, lastname: lastname, email: email) { [weak self] _ in
                    self?.registerVC?.moveToMainTabBarController()
                    self?.registerVC?.hideSpiner()
                    print(imageString)
                }
            })
        }
    }
}
