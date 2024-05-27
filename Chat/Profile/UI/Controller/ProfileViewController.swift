//
//  ProfileViewController.swift
//  Chat
//
//  Created by Vlad on 22.05.24.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    private let firebaseProfileManager: FirebaseProfileManager = FirebaseProfileManager()
    private let profileView: ProfileView = ProfileView()
    private lazy var model: ProfileModel = ProfileModel(profileVC: self, logout: firebaseProfileManager)
    
    override func loadView() {
        super.loadView()
        view = profileView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegates()
    }
    
    private func showAlertAboutLeavingYourProfile() {
        let alert = UIAlertController(title: "Уведомление", message: "Вы действительно хотите выйти из профиля?", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Да", style: .default) { _ in
            self.model.logOut()
        }
        let noAction = UIAlertAction(title: "Нет", style: .destructive, handler: nil)
        alert.addAction(yesAction)
        alert.addAction(noAction)
        
        DispatchQueue.main.async { [weak self] in
            self?.present(alert, animated: true)
        }
    }
    
    private func setupDelegates() {
        profileView.logOutButtonDelegate = self
    }
}

//MARK: - LogOutButtonDelegate
extension ProfileViewController: LogOutButtonDelegate {
    func logOutButtonPressed() {
        showAlertAboutLeavingYourProfile()
    }
}

