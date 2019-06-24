//
//  RegisterViewController.swift
//  FireChat
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {
    
    @IBOutlet var emailTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    @IBAction func registerPressed(_ sender: AnyObject) {
        
        print(emailTextfield.text!.trim())
        
        if emailTextfield.text!.trim().count > 4 && passwordTextfield.text!.trim().count > 5 {
            
            Auth.auth().createUser(withEmail: emailTextfield.text!, password: passwordTextfield.text!){
                
                (user, error) in
                
                if error != nil {
                    print(error as Any)
                } else {
                    print("registration successful")
                    self.performSegue(withIdentifier: "goToChat", sender: self)
                }
            }
        } else {
            print("Too short")
        }
        
    }
    
}
