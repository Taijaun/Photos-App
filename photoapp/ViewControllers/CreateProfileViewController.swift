//
//  CreateProfileViewController.swift
//  photoapp
//
//  Created by Taijaun Pitt on 20/03/2023.
//

import UIKit
import FirebaseAuth

class CreateProfileViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func confirmTapped(_ sender: Any) {
        
        // Check that there is a user logged in
        // use firebase auth static method auth
        
        guard Auth.auth().currentUser != nil else {
            // No user logged in
            return
        }
        
        // Get the username
        // Check it against whitespaces, new lines, illegal characters etc
        let username = usernameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Check that username isn't nil
        if username == nil || username == "" {
            
            // Show error message
            return
        }
        
        // Call the user service to create the profile
        UserService.createProfile(userId: Auth.auth().currentUser!.uid, username: username!) { user in
            
            // Check if it was created successfully
            if user != nil {
                // If so, go to the tab bar controller
                // Save the user to local storage
                LocalStorageService.saveUser(userId: user!.userId, username: user!.username)
                let tabBarVC = self.storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.tabBarController)
                
                self.view.window?.rootViewController = tabBarVC
                self.view.window?.makeKeyAndVisible()
                
            } else {
                // if not, display error
                
            }
            
            
            
        }
        
        
    }
    

}
