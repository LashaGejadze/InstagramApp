//
//  NewsCollCell.swift
//  InstagramApp
//
//  Created by macosx on 22.06.17.
//  Copyright © 2017 macosx. All rights reserved.
//

import UIKit

class NewsCollCell: UICollectionViewCell {
    @IBOutlet weak var avatar: UIImageView!
   
    @IBOutlet weak var userName: UILabel!
    override func awakeFromNib() { //
        super.awakeFromNib()
        
        // set avatar layer as circle and scale image to fit screen well
        avatar.layer.cornerRadius = avatar.layer.frame.size.width / 2.0
        avatar.layer.masksToBounds = true
        
        avatar.contentMode = .scaleAspectFill
        avatar.clipsToBounds = true
        
        // make border
        avatar.layer.borderColor = UIColor.purple.cgColor
        avatar.layer.borderWidth = 0.7
    }
}


