//
//  CameraViewController.swift
//  photoapp
//
//  Created by Taijaun Pitt on 20/03/2023.
//

import UIKit

class CameraViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    func savePhoto(image: UIImage) {
        
        // call the photo service to store the photo
        PhotoService.savePhoto(image: image)
    }

}
