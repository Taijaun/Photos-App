//
//  PhotoService.swift
//  photoapp
//
//  Created by Taijaun Pitt on 23/03/2023.
//

import Foundation
import FirebaseStorage
import FirebaseFirestore
import FirebaseAuth

class PhotoService {
    
    static func retrievePhotos(completion: @escaping ([Photo]) -> Void) {
        
        // Get a database referecen
        let db = Firestore.firestore()
        
        // Get all the documents from the photos collection
        db.collection("photos").getDocuments { snapshot, error in
            
            // Check for errors
            if error != nil {
                // Error retrieving photos
                return
            }
            
            // Get all the documents
            let documents = snapshot?.documents
            
            // Check that documents aren't nil
            if let documents = documents {
                
                // Create an array to hold the photo structs
                var photoArray = [Photo]()
                
                // Loop through the documents
                // Create a photo struct for each
                for doc in documents {
                    
                    // create photo struct
                    let p = Photo(snapshot: doc)
                    
                    if p != nil {
                        // store it in the array
                        photoArray.insert(p!, at: 0)
                    }
                    
                }
                
                // Pass back the photo array
                completion(photoArray)
            }
            
        }
        
        
    }
    
    static func savePhoto(image:UIImage, progressUpdate: @escaping (Double) -> Void) {
        
        // Check that there is a user logged in
        if Auth.auth().currentUser == nil {
            return
        }
     
        // get the data representation of the uiimage
        let photoData = image.jpegData(compressionQuality: 0.1)
        
        guard photoData != nil else {
            // Error could not get data from the UIImage
            return
        }
        
        // Create a filename
        let filename = UUID().uuidString
        
        // Get the user id of the current user
        let userId = Auth.auth().currentUser!.uid
        
        // create a firebase storage path/reference
        let ref = Storage.storage().reference().child("images/\(userId)/\(filename).jpg")
        
        // upload the data
        let uploadTask = ref.putData(photoData!) { metadata, error in
            
            // Check if upload was successful
            if error == nil {
                // upon successful upload, create database enty
                self.createDatabaseEntry(ref: ref)
                
            }
        }
        
        uploadTask.observe(.progress) { taskSnapshot in
            
            let pct = Double(taskSnapshot.progress!.completedUnitCount) / Double(taskSnapshot.progress!.totalUnitCount)
            
            print(pct)
            // pass the update to the camera view controller
            progressUpdate(pct)
        }
    }
    
    private static func createDatabaseEntry(ref: StorageReference) {
        
        // Download url
        ref.downloadURL { url, error in
            
            // if there is no error, proceed
            if error == nil {
                
                // Photo id
                let photoId = ref.fullPath
                
                // Get the current user
                let photoUser = LocalStorageService.loadUser()
                
                // User id
                let userId = photoUser?.userId
                
                // Username
                let username = photoUser?.username
                
                // Date
                let df = DateFormatter()
                df.dateStyle = .full
                
                let dateString = df.string(from: Date())
                
                // Create a dictionary of the photo metadata
                let metadata = ["photoId": photoId, "byId": userId!, "byUsername": username!, "date": dateString, "url": url!.absoluteString]
                
                // Save the metadata to the firestore database
                let db = Firestore.firestore()
                
                db.collection("photos").addDocument(data: metadata) { error in
                    
                    // Check if the saving of data was successful
                    if error == nil {
                        // Successfully created database entry
                        
                    }
                }
            }
        }
        
        
    }
    
}
