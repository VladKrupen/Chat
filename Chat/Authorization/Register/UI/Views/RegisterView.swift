//
//  RegisterView.swift
//  Chat
//
//  Created by Vlad on 13.05.24.
//

import UIKit

final class RegisterView: UIView {
    
    weak var registerButtonDelegate: RegisterButtonDelegate?
    weak var changingProfileAvatarDelegate: ChangingProfileAvatarDelegate?
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.keyboardDismissMode = .interactive
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let avatarImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.fill")
        imageView.layer.cornerRadius = 100
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.tintColor = .white
        imageView.contentMode = .scaleToFill
        imageView.backgroundColor = CustomColor().customBlue
        imageView.isUserInteractionEnabled = true
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var firstnameField: UITextField = {
        let firstnameField = UITextField()
        firstnameField.autocapitalizationType = .none
        firstnameField.autocorrectionType = .no
        firstnameField.returnKeyType = .continue
        firstnameField.layer.cornerRadius = 12
        firstnameField.layer.borderWidth = 1
        firstnameField.layer.borderColor = CustomColor().customBlue.cgColor
        firstnameField.placeholder = "Имя"
        firstnameField.font = UIFont.systemFont(ofSize: 25)
        firstnameField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        firstnameField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        firstnameField.leftViewMode = .always
        firstnameField.rightViewMode = .always
        firstnameField.delegate = self
        firstnameField.translatesAutoresizingMaskIntoConstraints = false
        return firstnameField
    }()
    
    private lazy var lastnameField: UITextField = {
        let lastnameField = UITextField()
        lastnameField.autocapitalizationType = .none
        lastnameField.autocorrectionType = .no
        lastnameField.returnKeyType = .continue
        lastnameField.layer.cornerRadius = 12
        lastnameField.layer.borderWidth = 1
        lastnameField.layer.borderColor = CustomColor().customBlue.cgColor
        lastnameField.placeholder = "Фамилия"
        lastnameField.font = UIFont.systemFont(ofSize: 25)
        lastnameField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        lastnameField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        lastnameField.leftViewMode = .always
        lastnameField.rightViewMode = .always
        lastnameField.delegate = self
        lastnameField.translatesAutoresizingMaskIntoConstraints = false
        return lastnameField
    }()
    
    private lazy var emailField: UITextField = {
        let emailField = UITextField()
        emailField.autocapitalizationType = .none
        emailField.autocorrectionType = .no
        emailField.keyboardType = .emailAddress
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
    
    private lazy var registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Зарегистрироваться", for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 12
        button.backgroundColor = CustomColor().customBlue
        button.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        button.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layoutElements()
        scrollingWhenOpeningKeyboard()
        setupTapGestureImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makePasswordFieldEmpty() {
        passwordField.text = ""
    }
    
    func changeAvatarImage(image: UIImage) {
        avatarImage.image = image
    }
    
    private func setupTapGestureImageView() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(changeAvatarDidTap))
        avatarImage.addGestureRecognizer(gesture)
    }
    
    private func layoutElements() {
        layoutScrollView()
        layoutLogoImage()
        layoutStackField()
        layoutRegisterButton()
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
        scrollView.addSubview(avatarImage)
        
        NSLayoutConstraint.activate([
            avatarImage.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10),
            avatarImage.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            avatarImage.heightAnchor.constraint(equalToConstant: 200),
            avatarImage.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func layoutStackField() {
        stackField.addArrangedSubview(firstnameField)
        stackField.addArrangedSubview(lastnameField)
        stackField.addArrangedSubview(emailField)
        stackField.addArrangedSubview(passwordField)
        scrollView.addSubview(stackField)
        
        NSLayoutConstraint.activate([
            stackField.topAnchor.constraint(equalTo: avatarImage.bottomAnchor, constant: 20),
            stackField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 25),
            stackField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -25),
            firstnameField.heightAnchor.constraint(equalToConstant: 50),
            lastnameField.heightAnchor.constraint(equalToConstant: 50),
            emailField.heightAnchor.constraint(equalToConstant: 50),
            passwordField.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }
    
    private func layoutRegisterButton() {
        scrollView.addSubview(registerButton)
        
        NSLayoutConstraint.activate([
            registerButton.topAnchor.constraint(equalTo: stackField.bottomAnchor, constant: 20),
            registerButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            registerButton.leadingAnchor.constraint(equalTo: stackField.leadingAnchor),
            registerButton.trailingAnchor.constraint(equalTo: stackField.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: registerButton.bottomAnchor, constant: 20)
        ])
    }
    
    private func scrollingWhenOpeningKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

//MARK: - OBJC
extension RegisterView {
    @objc private func registerButtonTapped() {
        firstnameField.resignFirstResponder()
        lastnameField.resignFirstResponder()
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        guard let firstname = firstnameField.text,
              let lastname = lastnameField.text,
              let email = emailField.text,
              let password = passwordField.text else { return }
        registerButtonDelegate?.registerButtonPressed(firstname: firstname, lastname: lastname, email: email, password: password)
    }
    
    @objc private func changeAvatarDidTap() {
        changingProfileAvatarDelegate?.changeProfileAvatar()
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            let keyboardHeight = keyboardFrame.height
            
            let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
            scrollView.contentInset = contentInset
            scrollView.scrollIndicatorInsets = contentInset
        }
    }

    @objc private func keyboardWillHide(_ notification: Notification) {
        scrollView.contentInset = .zero
        scrollView.scrollIndicatorInsets = .zero
    }
}

//MARK: - UITextFieldDelegate
extension RegisterView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case firstnameField:
            lastnameField.becomeFirstResponder()
        case lastnameField:
            emailField.becomeFirstResponder()
        case emailField:
            passwordField.becomeFirstResponder()
        case passwordField:
            registerButtonTapped()
        default:
            return true
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let contentOffset = CGPoint(x: 0, y: textField.frame.origin.y - scrollView.contentInset.top)
        scrollView.setContentOffset(contentOffset, animated: true)
    }
}
