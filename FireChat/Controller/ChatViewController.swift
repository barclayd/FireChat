//
//  ChatViewController.swift
//  FireChat
//
//  Created by Daniel Barclay on 23/07/2019.
//  Copyright (c) 2019 Daniel Barclay. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    
    @IBOutlet var heightConstraint: NSLayoutConstraint!
    @IBOutlet var sendButton: UIButton!
    @IBOutlet var messageTextfield: UITextField!
    @IBOutlet var messageTableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messageTableView.delegate = self
        messageTableView.dataSource = self
        messageTextfield.delegate = self
        
        // tap guesture handling
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tableViewTapped))
        messageTableView.addGestureRecognizer(tapGesture)
        
        // register custom cell
        messageTableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "customMessageCell")
        // configure table view
        configureTableView()
    }

    @IBAction func sendPressed(_ sender: AnyObject) {
        
        
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
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "customMessageCell", for: indexPath) as! CustomMessageCell
        
        let messageArray = ["Message 1", "Message 2", "Message 3"]
        
        cell.messageBody.text = messageArray[indexPath.row]
        
        return cell
        
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
    


}
