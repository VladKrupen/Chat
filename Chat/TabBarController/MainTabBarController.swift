//
//  MainTabBarController.swift
//  Chat
//
//  Created by Vlad on 22.05.24.
//

import UIKit

final class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTabBarController()
    }
    
    private func setupTabBarController() {
        let chatsViewController = createNavigationController(viewController: ChatsViewController(), itemName: "Чаты", itemImage: "message.fill", tag: 0)
        let profileViewController = createNavigationController(viewController: ProfileViewController(), itemName: "Профиль", itemImage: "person.crop.circle", tag: 1)
        viewControllers = [chatsViewController, profileViewController]
    }
    
    private func createNavigationController(viewController: UIViewController, itemName: String, itemImage: String, tag: Int) -> UINavigationController {
        let item = UITabBarItem(title: itemName, image: UIImage(systemName: itemImage), tag: tag)
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.tabBarItem = item
        return navigationController
    }
}
