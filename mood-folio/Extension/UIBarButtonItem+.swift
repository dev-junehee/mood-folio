//
//  UIBarButtonItem+.swift
//  mood-folio
//
//  Created by junehee on 7/26/24.
//

import UIKit

extension UIBarButtonItem {
    func setButtonEnabled() {
        isEnabled = true
        tintColor = Resource.Color.primary
    }
    
    func setButtonDisabled() {
        isEnabled = false
    }
}
