//
//  TopicView.swift
//  mood-folio
//
//  Created by junehee on 7/24/24.
//

import UIKit
import SnapKit

final class ProfileTitleView: BaseView {
    
//    let backgroundView = {
//        let view = UIView()
//        return view
//    }()
    
    lazy var profileImage = {
        let view = UIButton()
        view.backgroundColor = Resource.Color.white
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        view.layer.borderColor = Resource.Color.primary.cgColor
        view.layer.borderWidth = Constants.Integer.borderWidth
        view.contentMode = .scaleAspectFit
        view.addTarget(self, action: #selector(profileClicked), for: .touchUpInside)
        return view
    }()
        
    override func configureHierarchy() {
//        backgroundView.addSubview(profileImage)
//        backgroundView.backgroundColor = .red
        self.addSubview(profileImage)
    }
    
    override func configureLayout() {
//        backgroundView.snp.makeConstraints {
//            $0.width.equalToSuperview()
//            $0.height.equalTo(40)
//        }
        
        profileImage.snp.makeConstraints {
            $0.top.trailing.equalTo(self.safeAreaLayoutGuide)
            $0.size.equalTo(40)
        }
    }
    
    @objc func profileClicked() {
        print("TEST")
    }
    
}
