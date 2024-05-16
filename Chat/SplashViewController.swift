//
//  SplashViewController.swift
//  Chat
//
//  Created by Vlad on 12.05.24.
//

import UIKit
import Lottie

final class SplashViewController: UIViewController {
    
    private let lottieAnimation = LottieAnimationView(name: "splash")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLottieAnimation()
        showAnimation()
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
            self.moveToLoginScreen()
            self.lottieAnimation.stop()
        }
    }
    
    private func moveToLoginScreen() {
        let loginVC = LoginViewController()
        loginVC.modalPresentationStyle = .fullScreen
        self.present(loginVC, animated: true)
    }
}

