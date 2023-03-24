//
//  FeedViewController.swift
//  photoapp
//
//  Created by Taijaun Pitt on 20/03/2023.
//

import UIKit

class FeedViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var photos = [Photo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set view controller as datasource and delegate
        tableView.delegate = self
        tableView.dataSource = self
        
        // Add pull to refresh
        addRefreshControl()
        
        // Call the PhotoService to retrieve the photos
        PhotoService.retrievePhotos { retrievedPhotos in
            
            // set photos array to the retrieved photos
            self.photos = retrievedPhotos
            self.tableView.reloadData()
            
        }
 
    }
    
    func addRefreshControl() {
        
        // Create refresh control
        let refresh = UIRefreshControl()
        
        // set target
        refresh.addTarget(self, action: #selector(refreshFeed(refreshControl:)) , for: .valueChanged)
        
        // add to tableview
        self.tableView.addSubview(refresh)
    }
    
    @objc func refreshFeed(refreshControl: UIRefreshControl) {
        
        // Call the photo service
        PhotoService.retrievePhotos { newPhotos in
            // Assign new photos to photos property
            self.photos = newPhotos
            
            DispatchQueue.main.async {
                
                // Refresh tableview
                self.tableView.reloadData()
                
                // Stop the spinner
                refreshControl.endRefreshing()
            }
            
            
        }
        
    }
}

extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return photos.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Get a Photo Cell
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Storyboard.photoCellId, for: indexPath) as? PhotoCell
        
        // Get the photo the cell is dplaying
        let photo = self.photos[indexPath.row]
        
        // Call display photo method of the cell
        cell?.displayPhoto(photo: photo)
        
        // return the cell
        return cell!
        
    }
    
    
    
    
}
