//
//  MBTIButtton.swift
//  mood-folio
//
//  Created by junehee on 7/23/24.
//

import UIKit
import SnapKit

final class MBTIButtton: UIButton {
    
    init(title: String, size: CGFloat = 50) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        setTitleColor(Resource.Color.black, for:.normal)
        titleLabel?.font = Resource.Font.bold16
        backgroundColor = isSelected ? Resource.Color.primary : Resource.Color.white
        layer.borderColor = isSelected ? Resource.Color.primary.cgColor : Resource.Color.lightGray.cgColor
        layer.borderWidth = isSelected ? 0 : 1
        layer.cornerRadius = size / 2
        self.snp.makeConstraints {
            $0.size.equalTo(size)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
