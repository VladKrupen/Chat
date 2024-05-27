//
//  ProfileView.swift
//  Chat
//
//  Created by Vlad on 27.05.24.
//

import UIKit

final class ProfileView: UIView {
    
    weak var logOutButtonDelegate: LogOutButtonDelegate?
    
    private lazy var logOutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Выйти", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(logOutButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layoutElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutElements() {
        layoutLogOutButton()
    }
    
    private func layoutLogOutButton() {
        addSubview(logOutButton)
        
        NSLayoutConstraint.activate([
            logOutButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            logOutButton.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor)
        ])
    }
}

//MARK: - OBJC
extension ProfileView {
    @objc private func logOutButtonTapped() {
        logOutButtonDelegate?.logOutButtonPressed()
    }
}
