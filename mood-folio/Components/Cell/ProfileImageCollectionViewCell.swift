//
//  ProfileImageCollectionViewCell.swift
//  mood-folio
//
//  Created by junehee on 7/24/24.
//

import UIKit
import SnapKit

final class ProfileImageCollectionViewCell: BaseCollectionViewCell {
    
    private let profileImageView = UIView()
    private let profileImage = UIImageView()
    
    private let profileNum = UserDefaultsManager.profile

    override func layoutSubviews() {
        super.layoutSubviews()
        profileImage.layoutIfNeeded()
        profileImage.clipsToBounds = true
        profileImage.layer.cornerRadius = profileImage.frame.width / 2
    }
    
    // 선택한 Cell에 대한 UI
    override var isSelected: Bool {
        didSet {
            if isSelected {
                profileImageView.alpha = 1.0
                profileImage.setSelectedUI()
            } else {
                profileImageView.alpha = 0.5
                profileImage.setUnselectedUI()
            }
        }
    }
    
    override func configureHierarchy() {
        profileImageView.addSubview(profileImage)
        contentView.addSubview(profileImageView)
    }
    
    override func configureLayout() {
        profileImageView.snp.makeConstraints {
            $0.top.equalTo(contentView).inset(16)
            $0.size.equalTo(70)
            $0.centerX.equalTo(contentView)
        }
        
        profileImage.snp.makeConstraints {
            $0.top.bottom.equalTo(profileImageView)
            $0.size.equalTo(profileImageView)
            $0.centerX.equalTo(profileImageView)
        }
    }
    
    override func configureUI() {
        profileImage.backgroundColor = Resource.Color.white
        profileImage.contentMode = .scaleAspectFit
        
        profileImageView.alpha = 0.5
        profileImage.setUnselectedUI()
    }
    
    func configureSelectedUI() {
        profileImageView.alpha = 1.0
        profileImage.setSelectedUI()
    }
    
    func configureCellData(data: UIImage) {
        profileImage.image = data
    }
    
}

