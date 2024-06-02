//
//  NewChatViewController.swift
//  Chat
//
//  Created by Vlad on 2.06.24.
//

import UIKit

final class NewChatViewController: UIViewController {
    
    private let newChatView: NewChatView = NewChatView()
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Поиск пользователей..."
        return searchBar
    }()
    
    override func loadView() {
        super.loadView()
        view = newChatView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationItem()
        setupDelegates()
    }
    
    private func setupNavigationItem() {
        navigationItem.titleView = searchBar
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonTapped))
        navigationItem.rightBarButtonItem = cancelButton
    }
    
    private func setupDelegates() {
        newChatView.tableView.dataSource = self
        newChatView.tableView.delegate = self
    }
}

//MARK: - OBJC
extension NewChatViewController {
    @objc private func cancelButtonTapped() {
        dismiss(animated: true)
    }
}

//MARK: - UITableViewDataSource
extension NewChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self), for: indexPath)
        cell.textLabel?.text = "Alex"
        return cell
    }
}

//MARK: - UITableViewDelegate
extension NewChatViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
