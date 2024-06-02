//
//  ChatsViewController.swift
//  Chat
//
//  Created by Vlad on 22.05.24.
//

import UIKit

final class ChatsViewController: UIViewController {
    
    private let chatsView: ChatsView = ChatsView()
    
    override func loadView() {
        super.loadView()
        view = chatsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationItem()
        setupDelegates()
    }
    
    private func setupNavigationItem() {
        navigationItem.title = "Чаты"
    }
    
    private func setupDelegates() {
        chatsView.tableView.dataSource = self
        chatsView.tableView.delegate = self
    }
}

//MARK: - OBJC
extension ChatsViewController {
    @objc private func addChatButtonTapped() {
        
    }
}

//MARK: - UITableViewDataSource
extension ChatsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ChatsViewCell.self), for: indexPath)
        guard let chatsCell = cell as? ChatsViewCell else { return cell }
        chatsCell.accessoryType = .disclosureIndicator
        return chatsCell
    }
}

//MARK: - UITableViewDelegate
extension ChatsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let conversationVC = ConversationViewController()
        tabBarController?.tabBar.isHidden = true
        navigationController?.pushViewController(conversationVC, animated: true)
    }
}
