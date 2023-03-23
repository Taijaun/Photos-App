//
//  SettingsViewController.swift
//  photoapp
//
//  Created by Taijaun Pitt on 20/03/2023.
//

import UIKit
import FirebaseAuth

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signOutTapped(_ sender: Any) {
        
        do {
            // try to sign out with firebase auth
            try Auth.auth().signOut()
            
            // Clear local storage
            LocalStorageService.clearUser()
            
            // Transition to authentication flow
            let loginNavVC = self.storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.loginNavController)
            self.view.window?.rootViewController = loginNavVC
            self.view.window?.makeKeyAndVisible()
            
        } catch {
            // Couldn't sign out the user
        }
    }
    
    
}
