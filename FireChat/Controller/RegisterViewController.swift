//
//  RegisterViewController.swift
//  FireChat
//

import UIKit
import Firebase
import SVProgressHUD

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
        
        if emailTextfield.text!.trim().count > 4 && passwordTextfield.text!.trim().count > 5 {
            
            SVProgressHUD.show()
            
            Auth.auth().createUser(withEmail: emailTextfield.text!, password: passwordTextfield.text!){
                
                (user, error) in
                
                if error != nil {
                    SVProgressHUD.dismiss()
                    print(error as Any)
                } else {
                    SVProgressHUD.dismiss()
                    self.performSegue(withIdentifier: "goToChat", sender: self)
                }
            }
        } else {
            print("Too short")
        }
        
    }
    
}
