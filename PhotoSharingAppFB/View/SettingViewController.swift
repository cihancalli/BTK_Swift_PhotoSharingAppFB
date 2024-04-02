//
//  SettingViewController.swift
//  PhotoSharingAppFB
//
//  Created by Cihan on 23.01.2024.
//

import UIKit
import FirebaseCore
import FirebaseAuth

class SettingViewController: UIViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func buttonSignOut(_ sender: Any) {
        
        do {
            try Auth.auth().signOut()
            performSegue(withIdentifier: "toLoginVC", sender: nil)
        }
        catch{
            print("Sign Out Error")
        }
    }
    
}
