//
//  ChatViewController.swift
//  FireChat
//
//  Created by Daniel Barclay on 23/07/2019.
//  Copyright (c) 2019 Daniel Barclay. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {
    
    
    @IBOutlet var heightConstraint: NSLayoutConstraint!
    @IBOutlet var sendButton: UIButton!
    @IBOutlet var messageTextfield: UITextField!
    @IBOutlet var messageTableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
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
    


}
