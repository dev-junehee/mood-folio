//
//  TextFieldEffets+.swift
//  mood-folio
//
//  Created by junehee on 7/22/24.
//

import TextFieldEffects

extension HoshiTextField {
    func setTextFieldUI(_ placeholder: String) {
        self.placeholder = placeholder
        self.placeholderColor = Resource.Colors.lightGray
        self.borderInactiveColor = Resource.Colors.lightGray
        self.borderActiveColor = Resource.Colors.primary
        self.tintColor = Resource.Colors.primary
    }
}
