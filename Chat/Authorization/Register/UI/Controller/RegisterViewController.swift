//
//  RegisterViewController.swift
//  Chat
//
//  Created by Vlad on 12.05.24.
//

import UIKit

final class RegisterViewController: UIViewController {
    
    private let registerView: RegisterView = RegisterView()
    private let firebaseRegistrationManager = FirebaseRegistrationManager()
    private lazy var model = RegisterModel(registerVC: self, userAuthentication: firebaseRegistrationManager, userCreator: firebaseRegistrationManager)
    
    override func loadView() {
        super.loadView()
        view = registerView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegates()
    }
    
    func moveToMainTabBarController() {
        let mainTabBarController = MainTabBarController()
        mainTabBarController.modalPresentationStyle = .fullScreen
        present(mainTabBarController, animated: true)
    }
    
    func showAlertUserRegisterEmpty() {
        let alert = UIAlertController(title: "Ошибка", message: "Заполните все поля", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Хорошо", style: .cancel, handler: nil)
        alert.addAction(okAction)
        
        DispatchQueue.main.async { [weak self] in
            self?.present(alert, animated: true)
        }
    }
    
    func showAlertErrorShortPassword() {
        let alert = UIAlertController(title: "Ошибка", message: "Пароль должен быть не менее 6 символов", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Хорошо", style: .cancel) { [weak self] _ in
            self?.registerView.makePasswordFieldEmpty()
        }
        alert.addAction(okAction)
        
        DispatchQueue.main.async { [weak self] in
            self?.present(alert, animated: true)
        }
    }
    
    func showAlertIncorrectEmail() {
        let alert = UIAlertController(title: "Ошибка", message: "Некорректный адрес электронной почты", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Хорошо", style: .default, handler: nil)
        alert.addAction(okAction)
        
        DispatchQueue.main.async { [weak self] in
            self?.present(alert, animated: true)
        }
    }
    
    private func setupDelegates() {
        registerView.registerButtonDelegate = self
        registerView.changingProfileAvatarDelegate = self
    }
}

//MARK: - RegisterButtonDelegate
extension RegisterViewController: RegisterButtonDelegate {
    func registerButtonPressed(firstname: String, lastname: String, email: String, password: String) {
        model.userRegister(firstname: firstname, lastname: lastname, email: email, password: password)
    }
}

//MARK: - ChangingProfileAvatarDelegate
extension RegisterViewController: ChangingProfileAvatarDelegate {
    func changeProfileAvatar() {
        presentPhotoActionSheet()
    }
}

//MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension RegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func presentPhotoActionSheet() {
        let actionSheet = UIAlertController(title: "Выбор аватарки", message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Сделайте фото",
                                            style: .default,
                                            handler: { [weak self] _ in
            self?.presentCamera()
        }))
        actionSheet.addAction(UIAlertAction(title: "Выберите фото из галереи",
                                            style: .default,
                                            handler: { [weak self] _ in
            self?.presentPhotoPicker()
        }))
        actionSheet.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        DispatchQueue.main.async { [weak self] in
            self?.present(actionSheet, animated: true)
        }
    }
    
    func presentCamera() {
        let pickerController = UIImagePickerController()
        pickerController.sourceType = .camera
        pickerController.delegate = self
        pickerController.allowsEditing = true
        DispatchQueue.main.async { [weak self] in
            self?.present(pickerController, animated: true)
        }
    }
    
    func presentPhotoPicker() {
        let pickerController = UIImagePickerController()
        pickerController.sourceType = .photoLibrary
        pickerController.delegate = self
        pickerController.allowsEditing = true
        pickerController.modalPresentationStyle = .fullScreen
        DispatchQueue.main.async { [weak self] in
            self?.present(pickerController, animated: true)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            registerView.changeAvatarImage(image: image)
        }
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
