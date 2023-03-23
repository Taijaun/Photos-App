//
//  UserService.swift
//  photoapp
//
//  Created by Taijaun Pitt on 20/03/2023.
//

import Foundation
import FirebaseFirestore

class UserService {
    
    static func createProfile(userId: String, username: String, completion: @escaping (PhotoUser?) -> Void ) {
        
        // Create a dictionary for the profile data
        let profileData = ["username": username]
        
        // Get a firestore reference
        let db = Firestore.firestore()
        
        // Create the document for the userid
        db.collection("users").document(userId).setData(profileData) { error in
            
            // Check for errors
            if error == nil {
                // Profile was created successfully
                // Create and return a photo user
                var u = PhotoUser()
                u.username = username
                u.userId = userId
                
                completion(u)
            } else {
                // Something went wrong
                // Return nil
                completion(nil)
            }
        }

        
    }
    
    static func retrieveProfile(userId: String, completion: @escaping (PhotoUser?) -> Void ) {
        
        // Get a firestore reference
        let db = Firestore.firestore()
        
        // Check for a profile, given the user id
        db.collection("users").document(userId).getDocument { snapshot, error in
            
            if error != nil || snapshot == nil {
                // Something wrong happened
                return
            }
            
            if let profile = snapshot!.data() {
                // Profile was found, create a new user
                var u = PhotoUser()
                u.userId = snapshot!.documentID
                u.username = profile["username"] as? String
                
                // Return the user
                completion(u)
                
            } else {
                // Couldn't get profile, or no profile
                // return nil
                completion(nil)
            }
            
        }
    }
    
    
}
