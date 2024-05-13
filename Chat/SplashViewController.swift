//
//  SplashViewController.swift
//  Chat
//
//  Created by Vlad on 12.05.24.
//

import UIKit

final class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let loginVC = LoginViewController()
            self.navigationController?.pushViewController(loginVC, animated: true)
        }
    }
}

