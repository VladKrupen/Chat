//
//  ConversationViewController.swift
//  Chat
//
//  Created by Vlad on 1.06.24.
//

import UIKit
import MessageKit

final class ConversationViewController: MessagesViewController {
    
    private var messages: [Message] = []
    
    private let selfSender: Sender = Sender(photoURL: "", senderId: "1", displayName: "Serge")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupMessagesCollectionView()
        send(message: Message(sender: selfSender, messageId: "1", sentDate: Date() , kind: .text("Привет! Как дела?")))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    private func setupMessagesCollectionView() {
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        
        messageInputBar.inputTextView.placeholder = "Сообщение"
        messageInputBar.sendButton.setImage(UIImage(systemName: "paperplane"), for: .normal)
        messageInputBar.sendButton.setTitle("", for: .normal)
    }
    
    private func send(message: Message) {
        messages.append(message)
        messagesCollectionView.reloadData()
        messagesCollectionView.scrollToLastItem()
    }
}

//MARK: - MessagesDataSource
extension ConversationViewController: MessagesDataSource {
    var currentSender: SenderType {
        return selfSender
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessageKit.MessagesCollectionView) -> any MessageKit.MessageType {
        messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessageKit.MessagesCollectionView) -> Int {
        messages.count
    }
}

//MARK: - MessagesLayoutDelegate
extension ConversationViewController: MessagesLayoutDelegate {
    
}

//MARK: - MessagesDisplayDelegate
extension ConversationViewController: MessagesDisplayDelegate {
    
}
