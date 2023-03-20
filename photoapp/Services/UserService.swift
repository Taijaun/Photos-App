//
//  UserService.swift
//  photoapp
//
//  Created by Taijaun Pitt on 20/03/2023.
//

import Foundation
import FirebaseFirestore

class UserService {
    
    static func retrieveProfile(userId: String) {
        
        // Get a firestore reference
        let db = Firestore.firestore()
        
        // Check for a profile, given the user id
        db.collection("users").document(userId).getDocument { snapshot, error in
            
            if error != nil || snapshot == nil {
                // Seomthing wrong happened
                return
            }
            
            if let profile = snapshot!.data() {
                // Profile was found, create a new photo user
                
                var u = PhotoUser()
                u.userId = snapshot!.documentID
                u.username = profile["username"] as? String
                
                // Return the user
                
            } else {
                // Couldn't get profile
                // Return nil
            }
            
        }
        
    }
    
    
}
