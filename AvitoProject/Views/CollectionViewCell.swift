//
//  CollectionViewCell.swift
//  AvitoProject
//
//  Created by Lev Kolesnikov on 31/07/2019.
//  Copyright © 2019 phenomendevelopers. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var favoriteView: HeartView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
