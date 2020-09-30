//
//  ConversationsController.swift
//  VinChat
//
//  Created by Vincent Angelo on 09/06/20.
//  Copyright © 2020 Vincent Angelo. All rights reserved.
//

import Foundation
import UIKit
import Firebase

private let reuseIdentifier = "ConversationCell"

class ConversationsController: UIViewController {
    
    
    // MARK: - Properties
    private let tableView = UITableView()
    private var conversations = [Conversation]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    // karena dictionary tidak bisa mengenerate duplicate key
    private var conversationsDictionary = [String:Conversation]()
    
    private let newMessageButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.backgroundColor = .systemBlue
        button.tintColor = .white
        button.imageView?.setDimensions(height: 24, width: 24)
        button.addTarget(self, action: #selector(showNewMessage), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        logout()
        authenticateUserAndConfigureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        configureNavigationBar(withTitle: "Messages", prefersLargeTitles: true)
        
    }
    
    // MARK: - Selectors
    
    @objc func showProfile(){
        let controller = ProfileController(style: .insetGrouped)
        controller.delegate = self
        let nav  = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true, completion: nil)
    }
    
    @objc func showNewMessage(){
        let controller = NewMessageController()
        controller.delegate = self
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true, completion: nil)
        
        
    }
    
    // MARK: - Helpers
    
    func fetchConversations(){
        self.tableView.reloadData()
        Service.fetchConversations{ conversations in
            conversations.forEach { conversation in
                let message = conversation.message
                self.conversationsDictionary[message.chatPartnerID] = conversation
            }
            self.showLoader(false)
            self.conversations = Array(self.conversationsDictionary.values)
            self.tableView.reloadData()
            
            }
        
    }
    
    func authenticateUserAndConfigureUI(){
        if Auth.auth().currentUser == nil{
            DispatchQueue.main.async{
                let nav = UINavigationController(rootViewController: LoginController())
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
                
            }
        }else{
            fetchConversations()
            configureUI()
        }
        print("DEBUG: User is not logged in")
        
    }
    
    func logout() {
        AuthService.shared.logUserOut()
        presentLoginScreen()
    }
    
    func presentLoginScreen(){
        DispatchQueue.main.async {
            let controller = LoginController()
            let nav = UINavigationController(rootViewController: controller)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)
            
        }
    }
    
    func configureUI() {
        view.backgroundColor = .white
        configureTableView()
        
        let image = UIImage(systemName: "person.circle.fill")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(showProfile))
        
        view.addSubview(newMessageButton)
        newMessageButton.setDimensions(height: 56, width: 56)
        newMessageButton.layer.cornerRadius = 56 / 2
        newMessageButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingBottom: 16, paddingRight: 24)
    }
    
    func configureTableView(){
        tableView.backgroundColor = .white
        tableView.rowHeight = 80
        tableView.register(ConversationCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        tableView.frame = view.frame
    }
    
    func showChatController(forUser user: User) {
        let controller = ChatController(user: user)
        navigationController?.pushViewController(controller, animated: true)
        
    }
    
    
    
    
}

extension ConversationsController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = conversations[indexPath.row].user
        showChatController(forUser: user)
    }
    
}

extension ConversationsController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("COUNT: \(conversations.count)")
        return conversations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ConversationCell
        cell.conversation = conversations[indexPath.row]
        return cell
    }
    
    
}

// MARK: - NewMessageControllerDelegate
extension ConversationsController: NewMessageControllerDelegate {
    func controller(_ controller: NewMessageController, wantsToStartChatWith user: User) {
        print("DEBUG: User in conversation controller is \(user.username)")
        controller.dismiss(animated: true, completion: nil)
        showChatController(forUser: user)
        
    }
    
    
}

extension ConversationsController: ProfileControllerDelegate {
    func handleLogout() {
        logout()
    }
}
