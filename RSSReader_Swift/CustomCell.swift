//
//  CustomCell.swift
//  RSSReader_Swift
//
//  Created by MTL on 2015/03/05.
//  Copyright (c) 2015年 MTL. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setCell(timeline :TimelineModel) {
        self.title.text = timeline.title
        var err: NSError?
        var imageData :NSData = NSData(contentsOfURL: timeline.imageUrl!,options: NSDataReadingOptions.DataReadingMappedIfSafe, error: &err)!
        self.iconImage.image = UIImage(data:imageData)
    }
}