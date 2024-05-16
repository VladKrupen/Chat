//
//  LoginView.swift
//  Chat
//
//  Created by Vlad on 12.05.24.
//

import UIKit

final class LoginView: UIView {
    
    weak var loginButtonDelegate: LoginButtonDelegate?
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let logoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .white
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var emailField: UITextField = {
        let emailField = UITextField()
        emailField.autocapitalizationType = .none
        emailField.autocorrectionType = .no
        emailField.returnKeyType = .continue
        emailField.layer.cornerRadius = 12
        emailField.layer.borderWidth = 1
        emailField.layer.borderColor = CustomColor().customBlue.cgColor
        emailField.placeholder = "Email"
        emailField.font = UIFont.systemFont(ofSize: 25)
        emailField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        emailField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        emailField.leftViewMode = .always
        emailField.rightViewMode = .always
        emailField.delegate = self
        emailField.translatesAutoresizingMaskIntoConstraints = false
        return emailField
    }()
    
    private lazy var passwordField: UITextField = {
        let passwordField = UITextField()
        passwordField.autocapitalizationType = .none
        passwordField.autocorrectionType = .no
        passwordField.returnKeyType = .done
        passwordField.isSecureTextEntry = true
        passwordField.textContentType = .oneTimeCode
        passwordField.layer.cornerRadius = 12
        passwordField.layer.borderWidth = 1
        passwordField.layer.borderColor = CustomColor().customBlue.cgColor
        passwordField.placeholder = "Пароль"
        passwordField.font = UIFont.systemFont(ofSize: 25)
        passwordField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        passwordField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        passwordField.leftViewMode = .always
        passwordField.rightViewMode = .always
        passwordField.delegate = self
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        return passwordField
    }()
    
    private let stackField: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Войти", for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 12
        button.backgroundColor = CustomColor().customBlue
        button.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layoutElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func clearTextField() {
        emailField.text = ""
        passwordField.text = ""
    }
    
    private func layoutElements() {
        layoutScrollView()
        layoutLogoImage()
        layoutStackField()
        layoutLoginButton()
    }
    
    private func layoutScrollView() {
        addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    private func layoutLogoImage() {
        scrollView.addSubview(logoImage)
        
        NSLayoutConstraint.activate([
            logoImage.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10),
            logoImage.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            logoImage.heightAnchor.constraint(equalToConstant: 100),
            logoImage.widthAnchor.constraint(equalToConstant: 100),
        ])
    }
    
    private func layoutStackField() {
        stackField.addArrangedSubview(emailField)
        stackField.addArrangedSubview(passwordField)
        scrollView.addSubview(stackField)
        
        NSLayoutConstraint.activate([
            stackField.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 20),
            stackField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 25),
            stackField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -25),
            emailField.heightAnchor.constraint(equalToConstant: 50),
            passwordField.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }
    
    private func layoutLoginButton() {
        scrollView.addSubview(loginButton)
        
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: stackField.bottomAnchor, constant: 20),
            loginButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            loginButton.leadingAnchor.constraint(equalTo: stackField.leadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo: stackField.trailingAnchor)
        ])
    }
}

//MARK: - OBJC
extension LoginView {
    @objc private func loginButtonTapped() {
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        guard let email = emailField.text,
              let password = passwordField.text else { return }
        loginButtonDelegate?.loginButtonPressed(email: email, password: password)
    }
}

//MARK: - UITextFieldDelegate
extension LoginView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case emailField:
            passwordField.becomeFirstResponder()
        case passwordField:
            loginButtonTapped()
        default:
            return true
        }
        return true
    }
}
