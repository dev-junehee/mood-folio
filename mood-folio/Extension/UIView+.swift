//
//  UIView+.swift
//  mood-folio
//
//  Created by junehee on 7/22/24.
//

import UIKit

extension UIView: Reusable {
    static var id: String {
        return String(describing: self)
    }
}

