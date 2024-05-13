//
//  RegisterViewController.swift
//  Chat
//
//  Created by Vlad on 12.05.24.
//

import UIKit

final class RegisterViewController: UIViewController {
    
    private let registerView: RegisterView = RegisterView()
    private lazy var model = RegisterModel(registerVC: self)
    
    override func loadView() {
        super.loadView()
        view = registerView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegates()
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
    
    private func setupDelegates() {
        registerView.registerButtonDelegate = self
    }
}

//MARK: - RegisterButtonDelegate
extension RegisterViewController: RegisterButtonDelegate {
    func registerButtonPressed(firstname: String, lastname: String, email: String, password: String) {
        model.userRegister(firstname: firstname, lastname: lastname, email: email, password: password)
    }
}
