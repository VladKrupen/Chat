//
//  SplashViewController.swift
//  Chat
//
//  Created by Vlad on 12.05.24.
//

import UIKit
import Lottie
import FirebaseAuth

final class SplashViewController: UIViewController {
    
    private let firebaseUserStatusManager = FirebaseUserStatusManager()
    private lazy var model = SplashModel(splashVC: self, userStatus: firebaseUserStatusManager)
    
    private let lottieAnimation = LottieAnimationView(name: "splash")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLottieAnimation()
        showAnimation()
//        try? Auth.auth().signOut()
    }
    
    func moveToLoginScreen() {
        let loginVC = UINavigationController(rootViewController: LoginViewController())
        loginVC.modalPresentationStyle = .fullScreen
        self.present(loginVC, animated: true)
    }
    
    func moveToMainTabBarController() {
        let mainTabBarController = MainTabBarController()
        mainTabBarController.modalPresentationStyle = .fullScreen
        present(mainTabBarController, animated: true)
    }
    
    private func setupLottieAnimation() {
        view.addSubview(lottieAnimation)
        lottieAnimation.frame = view.frame
        lottieAnimation.contentMode = .scaleAspectFit
        lottieAnimation.animationSpeed = 1
        lottieAnimation.loopMode = .loop
    }
    
    private func showAnimation() {
        lottieAnimation.play()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.model.isUserAuthorized()
            self.lottieAnimation.stop()
        }
    }
}

