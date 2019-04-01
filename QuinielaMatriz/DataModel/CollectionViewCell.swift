//
//  CollectionViewCell.swift
//  QuinielaMatriz
//
//  Created by User on 3/24/19.
//  Copyright © 2019 User. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = self.frame.width / 2
    }
    
}

