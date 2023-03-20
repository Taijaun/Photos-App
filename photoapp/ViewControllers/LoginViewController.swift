//
//  LoginViewController.swift
//  photoapp
//
//  Created by Taijaun Pitt on 20/03/2023.
//

import UIKit
import FirebaseAuthUI
import FirebaseEmailAuthUI

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
 
    
    @IBAction func loginTapped(_ sender: Any) {
        
        // Create a firebase AuthUI obj
        let authUI = FUIAuth.defaultAuthUI()
        
        // Check that it isnt nil
        if let authUI = authUI {
            
            // Set self as delegate for the authUI
            authUI.delegate = self
            
            // Set sign in providers
            authUI.providers = [FUIEmailAuth()]
            
            // Get the prebuilt UI view controller
            let authViewController = authUI.authViewController()
            
            // Present it
            present(authViewController, animated: true)
            
        }
        
        
    }

}

extension LoginViewController: FUIAuthDelegate {
    
    
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        
        // Check if there was an error
        if error != nil {
            // There was an error
            return
        }
        
        let user = authDataResult?.user
        
        if let user = user {
            
            // Got a user
            // Check on the database side if the user has a profile
            
            // If not, go to create profile vc
            
            // If so, go to tab bar controller
        }
        
    }
    
}
