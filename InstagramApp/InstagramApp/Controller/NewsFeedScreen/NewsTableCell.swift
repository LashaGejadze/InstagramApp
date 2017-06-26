//
//  NewsTableCell.swift
//  InstagramApp
//
//  Created by macosx on 22.06.17.
//  Copyright © 2017 macosx. All rights reserved.
//

import UIKit

class NewsTableCell: UITableViewCell {
    // MARK: - IBOutlets
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var like: UILabel!
    @IBOutlet weak var views: UILabel!
    
    // MARK: - View Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // set avatar layer as circle and scale image to fit screen well
        avatar.layer.cornerRadius = avatar.layer.frame.size.width / 2.0
        avatar.layer.masksToBounds = true
        
        userImage.contentMode = .scaleAspectFill
        userImage.clipsToBounds = true
        
        avatar.contentMode = .scaleAspectFill
        avatar.clipsToBounds = true
        
        // make border
        avatar.layer.borderColor = UIColor.gray.cgColor
        avatar.layer.borderWidth = 0.7
    }
    
}
