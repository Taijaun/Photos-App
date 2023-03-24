//
//  MainTabBarController.swift
//  photoapp
//
//  Created by Taijaun Pitt on 23/03/2023.
//

import UIKit

class MainTabBarController: UITabBarController{

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        // Detect which tab was tapped on
        if item.tag == 2 {
            
            // Camera tab was tapped on
            
            // Create the action sheet
            let actionSheet = UIAlertController(title: "Add a Photo", message: "Select a Source:", preferredStyle: .actionSheet)
            
            // Only add camera buttin if camera is available
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                // Create and add the camera button
                let cameraButton = UIAlertAction(title: "Camera", style: .default) { action in
                    
                    // Display the UIImagePickerController set to camera mode
                    self.showImagePickerController(mode: .camera)
                }
                actionSheet.addAction(cameraButton)
                
            }
            
            // Only add the Library button if it is available
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                
                // Create and add the Photo library button
                let libraryButton = UIAlertAction(title: "Photo Library", style: .default) { action in
                    
                    // Display the UIImagePickerController set to library mode
                    self.showImagePickerController(mode: .photoLibrary)
                }
                actionSheet.addAction(libraryButton)
            }
            
            
            // create and add the cancel button
            let cancelButton = UIAlertAction(title: "Cancel", style: .cancel)
            actionSheet.addAction(cancelButton)
            
            // Display the action sheet
            present(actionSheet, animated: true)
        }
    }
    
    func showImagePickerController(mode: UIImagePickerController.SourceType) {
        
        // Create the picker and set the mode
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = mode
        
        // Set the tab bar controlelr as teh delegate
        imagePicker.delegate = self
        
        //Present the image picker
        present(imagePicker, animated: true)
        
    }

}

extension MainTabBarController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        // Dismiss the image picker
        dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // Get a reference to the selected photo
        let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        
        // Check that the selected image isn't nil
        if let selectedImage = selectedImage {
            
            // Get a reference to the camera view controller tab
            let cameraVC = self.selectedViewController as? CameraViewController
            
            if let cameraVC = cameraVC {
                
                // Upload it
                cameraVC.savePhoto(image: selectedImage)
                
            }
            
            
            
        }
        
        // Dismiss the image picker
        dismiss(animated: true)
    }
    
    func goToFeed() {
        
        // Switch tab to the first one
        selectedIndex = 0
        
    }
    
}
