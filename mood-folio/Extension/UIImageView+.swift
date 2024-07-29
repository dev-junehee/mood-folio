//
//  UIImageView+.swift
//  mood-folio
//
//  Created by junehee on 7/28/24.
//

import UIKit

extension UIImageView {
    func setSelectedUI() {
        layer.borderColor = Resource.Color.primary.cgColor
        layer.borderWidth = Constants.Integer.borderWidth
    }
    
    func setUnselectedUI() {
       layer.borderColor = Resource.Color.lightGray.cgColor
        layer.borderWidth = Constants.Integer.borderWidthEnabled
    }
}
