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
        setTitleColor(Resource.Color.white, for:.normal)
        titleLabel?.font = Resource.Font.button
        backgroundColor = isEnabled ? Resource.Color.primary : Resource.Color.lightGray
        layer.cornerRadius = Constants.Integer.commonButtonRadius
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
