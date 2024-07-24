//
//  TopicView.swift
//  mood-folio
//
//  Created by junehee on 7/24/24.
//

import UIKit
import SnapKit

final class ProfileTitleView: BaseView {
    
    private let backgroundView = {
        let view = UIView()
        return view
    }()
    
    let profileImage = {
        let view = UIImageView()
        view.backgroundColor = Resource.Color.white
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        view.layer.borderColor = Resource.Color.primary.cgColor
        view.layer.borderWidth = Constants.Integer.borderWidth
        view.contentMode = .scaleAspectFit
        return view
    }()
        
    override func configureHierarchy() {
        backgroundView.addSubview(profileImage)
        backgroundView.backgroundColor = .red
        self.addSubview(backgroundView)
    }
    
    override func configureLayout() {
        backgroundView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(40)
        }
        
        profileImage.snp.makeConstraints {
            $0.top.trailing.equalTo(backgroundView)
            $0.size.equalTo(40)
        }
    }
    
}
