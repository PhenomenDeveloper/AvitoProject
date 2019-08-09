//
//  UIImageView+Corner+Shadow.swift
//  AvitoProject
//
//  Created by Lev Kolesnikov on 04/08/2019.
//  Copyright © 2019 phenomendevelopers. All rights reserved.
//

import UIKit

extension UIImageView {
    func applyshadowWithCorner (containerView : UIView, cornerRadious : CGFloat) {
        containerView.clipsToBounds = false
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 1
        containerView.layer.shadowOffset = CGSize.zero
        containerView.layer.shadowRadius = 3
        containerView.layer.cornerRadius = cornerRadious
        containerView.layer.shadowPath = UIBezierPath(roundedRect: containerView.bounds, cornerRadius: cornerRadious).cgPath
        self.clipsToBounds = true
        self.layer.cornerRadius = cornerRadious
    }
}
