//
//  TableViewCell.swift
//  NetworkingAndAPIs
//
//  Created by Laptop World on 22/10/1443 AH.
//

import UIKit
import Kingfisher

class TableViewCell: UITableViewCell {
    
    //---------------------- outlet ---------------
    
    @IBOutlet weak var lableID: UILabel!
    @IBOutlet weak var labelAdress: UILabel!
    @IBOutlet weak var imageViewCell: UIImageView!
    
    //---------------------- LifeCycle ---------------
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func cellConfiguration(item: LocationObject){
        self.lableID.text = "\(item.id)"
        self.labelAdress.text = item.address
        let url = URL(string: item.photo)
        imageViewCell.kf.setImage(with: url)
    }
    
    func setURLImage(url:URL,placeholderImage:UIImage){
        self.imageViewCell.kf.indicatorType = .activity
        self.imageViewCell.kf.setImage(
            with: url,
            placeholder: placeholderImage,
            options: [
                .loadDiskFileSynchronously, .cacheOriginalImage
            ],
            progressBlock: { receivedSize, totalSize in
            // Progress updated
            },
            completionHandler: { result in
            // Done
            })
    }
}
