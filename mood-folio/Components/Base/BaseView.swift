//
//  BaseView.swift
//  mood-folio
//
//  Created by junehee on 7/22/24.
//

import UIKit

class BaseView: UIView, Base {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHierarchy() { }
    
    func configureLayout() { }
    
    func configureUI() { }
    
}
