//
//  ViewController.swift
//  PhotoSharingAppFB
//
//  Created by Cihan on 23.01.2024.
//

import UIKit
import FirebaseCore
import FirebaseAuth

class ViewController: UIViewController {
    @IBOutlet weak var imageViewLogo: UIImageView!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var labelBottomText: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func buttonSignUp(_ sender: Any) {
        if textFieldEmail.text != "" && textFieldPassword.text != "" {
            Auth.auth().createUser(withEmail: textFieldEmail.text!, password: textFieldPassword.text!) { (authdataresult,error) in
                if error != nil {
                    self.errorMessage(title: "Register Error", message: error!.localizedDescription)
                } else {
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
        } else {
            errorMessage(title: "Wrong Info Error", message: "Enter your e-mail address and password")
        }
    }
    
    
    @IBAction func buttonSignIn(_ sender: Any) {
        if textFieldEmail.text != "" && textFieldPassword.text != "" {
            Auth.auth().signIn(withEmail: textFieldEmail.text!, password: textFieldPassword.text!) { (authdataresult,error) in
                if error != nil {
                    self.errorMessage(title: "Login Error", message: error!.localizedDescription)
                } else {
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
        } else {
            errorMessage(title: "Wrong Info Error", message: "Enter your e-mail address and password")
        }
    }
    
    func errorMessage (title:String, message:String) {
        let alertMessage = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alertMessage.addAction(okButton)
        self.present(alertMessage, animated: true, completion: nil)
    }
}

