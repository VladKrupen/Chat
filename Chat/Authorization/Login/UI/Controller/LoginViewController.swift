//
//  LoginViewController.swift
//  Chat
//
//  Created by Vlad on 12.05.24.
//

import UIKit

final class LoginViewController: UIViewController {
 
    private let loginView: LoginView = LoginView()
    private let firebaseLoginManager = FirebaseLoginManager()
    private lazy var model = LoginModel(loginVC: self, firebaseLoginManager: firebaseLoginManager)
    
    override func loadView() {
        super.loadView()
        view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationItem()
        setupDelegates()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loginView.clearTextField()
    }
    
    func showAlertUserLoginEmpty() {
        let alert = UIAlertController(title: "Ошибка", message: "Заполните все поля", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Хорошо", style: .cancel, handler: nil)
        alert.addAction(okAction)
        
        DispatchQueue.main.async { [weak self] in
            self?.present(alert, animated: true)
        }
    }
    
    func showAlertIncorrectData() {
        let alert = UIAlertController(title: "Ошибка", message: "Неправильный логи или пароль", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Хорошо", style: .cancel, handler: nil)
        alert.addAction(okAction)
        
        DispatchQueue.main.async { [weak self] in
            self?.present(alert, animated: true)
        }
    }
    
    private func setupNavigationItem () {
        navigationItem.title = "Вход"
        let rightBarButton = UIBarButtonItem(title: "Регистрация",
                                             style: .done,
                                             target: self,
                                             action: #selector(rightBarButtonTapped))
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    private func setupDelegates() {
        loginView.loginButtonDelegate = self
    }
}

//MARK: - OBJC
extension LoginViewController {
    @objc private func rightBarButtonTapped() {
        let registerVC = RegisterViewController()
        registerVC.title = "Регистрация"
        navigationController?.pushViewController(registerVC, animated: true)
    }
}

//MARK: - LoginButtonDelegate
extension LoginViewController: LoginButtonDelegate {
    func loginButtonPressed(email: String, password: String) {
        model.userLogin(email: email, password: password)
    }
}
