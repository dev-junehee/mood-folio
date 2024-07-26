//
//  TopicView.swift
//  mood-folio
//
//  Created by junehee on 7/24/24.
//

import UIKit
import SnapKit

final class ProfileTitleView: BaseView {
    
    lazy var profileImage = {
        let view = UIButton()
        view.backgroundColor = Resource.Color.whiteSmoke
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        view.layer.borderColor = Resource.Color.primary.cgColor
        view.layer.borderWidth = Constants.Integer.borderWidth
        view.contentMode = .scaleAspectFit
        return view
    }()
        
    override func configureHierarchy() {
        self.addSubview(profileImage)
    }
    
    override func configureLayout() {
        profileImage.snp.makeConstraints {
            $0.top.trailing.equalTo(self.safeAreaLayoutGuide)
            $0.size.equalTo(40)
        }
    }
    
}
