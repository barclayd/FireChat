//
//  ChatViewController.swift
//  FireChat
//
//  Created by Daniel Barclay on 23/07/2019.
//  Copyright (c) 2019 Daniel Barclay. All rights reserved.
//

import UIKit
import Firebase
import ChameleonFramework


class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    var messageArray: [Message] = [Message]()
    
    @IBOutlet var heightConstraint: NSLayoutConstraint!
    @IBOutlet var sendButton: UIButton!
    @IBOutlet var messageTextfield: UITextField!
    @IBOutlet var messageTableView: UITableView!
    
    //TODO: Change message orientation and bubble colour based on user who sent message
    //TODO: Change icon picture based on user who signed up gender
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messageTableView.delegate = self
        messageTableView.dataSource = self
        messageTextfield.delegate = self
        
        // tap guesture handling
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tableViewTapped))
        messageTableView.addGestureRecognizer(tapGesture)
        
        // register custom cells
        messageTableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "customMessageCell")
        messageTableView.register(UINib(nibName: "NonUserMessageCell", bundle: nil), forCellReuseIdentifier: "nonUserMessageCell")
        // configure table view
        configureTableView()
        // retrieve and listen for messages
        retrieveMessages()
        
        messageTableView.separatorStyle = .none
    }

    @IBAction func sendPressed(_ sender: AnyObject) {
        
        messageTextfield.endEditing(true)
        toggleMessageElementState(state: false)
        
        let messagesDB = Database.database().reference().child("messages")
        let messageDict = ["sender": Auth.auth().currentUser?.email, "message": messageTextfield.text ]
        
        messagesDB.childByAutoId().setValue(messageDict) {
            (error, ref) in
            if error != nil {
                print (error)
            } else {
                print("Message saved!")
                self.toggleMessageElementState(state: true)
                self.messageTextfield.text = ""
                
            }
            
        }
        
    }
    
    @IBAction func logOutPressed(_ sender: AnyObject) {
        
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch {
            print("Error - there was a problem signing out")
        }
        
    }
    
    //MARK: Protocols
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if messageArray[indexPath.row].sender == Auth.auth().currentUser?.email {
            let cell = tableView.dequeueReusableCell(withIdentifier: "customMessageCell", for: indexPath) as! CustomMessageCell
            
            cell.messageBody.text = messageArray[indexPath.row].text
            cell.senderUsername.text = messageArray[indexPath.row].sender
            cell.avatarImageView.image = UIImage(named: "male")
            cell.messageBackground.backgroundColor = UIColor.flatWatermelon()

            return cell
                
            } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "nonUserMessageCell", for: indexPath) as! NonUserMessageCell
            
            cell.message.text = messageArray[indexPath.row].text
            cell.sender.text = messageArray[indexPath.row].sender
            cell.avatar.image = UIImage(named: "male")
            cell.messageContainer.backgroundColor = UIColor.flatPowderBlue()
            cell.avatar.image = UIImage(named: "female")
            
            return cell
            }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        keyboardAnimations(animationSpeed: 0.5, keyboardHeight: 353)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        keyboardAnimations(animationSpeed: 0.5, keyboardHeight: 50)
    }
    
    // configure table view
    func configureTableView() {
        messageTableView.rowHeight = UITableView.automaticDimension
        messageTableView.estimatedRowHeight = 120.0
    }
    
    func keyboardAnimations(animationSpeed: Double, keyboardHeight: Int) {
        UIView.animate(withDuration: animationSpeed) {
            self.heightConstraint.constant = CGFloat(keyboardHeight)
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func tableViewTapped() {
        messageTextfield.endEditing(true)
    }
    
    func toggleMessageElementState(state: Bool) {
        messageTextfield.isEnabled = state
        sendButton.isEnabled = state
    }
    
    func retrieveMessages() {
        let messageDB = Database.database().reference().child("messages")
        messageDB.observe(.childAdded) { (snapshot) in
            let snapshotValue = snapshot.value as! Dictionary<String, String>
            
            let text = snapshotValue["message"]!
            
            let sender = snapshotValue["sender"]!
            
            let message = Message()
            message.sender = sender
            message.text = text
            
            self.messageArray.append(message)
            // configure and reformat table
            self.configureTableView()
            self.messageTableView.reloadData()
            
        }
    }
    

}
