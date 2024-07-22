//
//  CommonButton.swift
//  mood-folio
//
//  Created by junehee on 7/22/24.
//

import UIKit

final class CommonButton: UIButton {
    
    init(title: String) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        setTitleColor(Resource.Colors.white, for:.normal)
        titleLabel?.font = Resource.Fonts.button
        backgroundColor = self.isEnabled ? Resource.Colors.lightGray : Resource.Colors.primary
        layer.cornerRadius = CGFloat(Constants.Integer.buttonRadius)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
