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
        self.placeholderColor = Resource.Color.lightGray
        self.borderInactiveColor = Resource.Color.lightGray
        self.borderActiveColor = Resource.Color.primary
        self.tintColor = Resource.Color.primary
    }
}
