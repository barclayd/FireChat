//
//  ChatViewController.swift
//  FireChat
//
//  Created by Daniel Barclay on 23/07/2019.
//  Copyright (c) 2019 Daniel Barclay. All rights reserved.
//

import UIKit


class ChatViewController: UIViewController {
    
    
    // We've pre-linked the IBOutlets
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
        
    }
    


}
