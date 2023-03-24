

import UIKit

class PhotoCell: UITableViewCell {
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    var photo: Photo?
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func displayPhoto(photo: Photo) {
        
        // Reset the image for recycling
        self.photoImageView.image = nil
        
        // Set the photo property
        self.photo = photo
        
        // Set the username
        usernameLabel.text = photo.byUsername
        
        // Set the date
        dateLabel.text = photo.date
        
        // Check that there is a valid download url
        if photo.url == nil {
            return
        }
        
        // Check if the image is in cache
        if let cachedImage = ImageCacheService.getImage(url: photo.url!){
            
            // Use the cached image
            self.photoImageView.image = cachedImage
            
            // Return as downloading the image is no longer needed
            return
        }
        
        
        // Download the image
        let url = URL(string: photo.url!)
        
        // check that url object was created
        if url == nil {
            return
        }
        
        // use url session to download the image asynchronously
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: url!) { data, response, error in
            
            // Check for errors and data
            if error == nil && data != nil {
                
                // set the image view
                let image = UIImage(data: data!)
                
                // Store the image data in cache
                ImageCacheService.saveImage(url: url!.absoluteString, image: image)
                
                
                // Check that downloaded image data matches the photo that the cell is supposed to display
                if url!.absoluteString != self.photo?.url {
                    
                    // the downlaoded url does not match the url the cell is currently displaying
                    return
                }

                // set the image view
                DispatchQueue.main.async {
                    self.photoImageView.image = image
                }
                
            }
            
        }
        dataTask.resume()
        
        
    }

}
