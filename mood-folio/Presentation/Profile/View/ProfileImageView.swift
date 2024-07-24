//
//  ProfileImageView.swift
//  mood-folio
//
//  Created by junehee on 7/23/24.
//

import UIKit
import SnapKit

final class ProfileImageView: BaseView {
    
    private let profileImageView = UIView()
    
    let profileImage = {
        let view = UIImageView()
        view.backgroundColor = Resource.Color.white
        view.clipsToBounds = true
        view.layer.cornerRadius = 50
        view.layer.borderColor = Resource.Color.primary.cgColor
        view.layer.borderWidth = Constants.Integer.borderWidth
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private let cameraImageView = {
        let view = UIView()
        view.backgroundColor = Resource.Color.primary
        view.layer.cornerRadius = 12
        return view
    }()
    
    private let cameraImage = {
        let view = UIImageView()
        view.image = Resource.SystemImage.camera
        view.contentMode = .scaleAspectFit
        view.tintColor = Resource.Color.white
        return view
    }()
    
    // 프로필 이미지 컬렉션 뷰
    lazy var profileCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    
    // 프로필 이미지 컬렉션 뷰 레이아웃 구성
    private func layout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        
        let sectionSpaciing: CGFloat = 16
        let cellSpacing: CGFloat = 16
        
        let width = UIScreen.main.bounds.width - (sectionSpaciing) - (cellSpacing)
        layout.itemSize = CGSize(width: width / 6, height: width / 6)
        layout.scrollDirection = .vertical
        
        layout.minimumInteritemSpacing = cellSpacing
        layout.minimumLineSpacing = cellSpacing
        layout.sectionInset = UIEdgeInsets(top: sectionSpaciing, left: sectionSpaciing, bottom: sectionSpaciing, right: sectionSpaciing)  // 셀과 뷰 사이 간격
        
        return layout
    }

    override func configureHierarchy() {
        cameraImageView.addSubview(cameraImage)
        profileImageView.addSubview(profileImage)
        profileImageView.addSubview(cameraImageView)
    
        let subViews = [profileImageView, profileCollectionView]
        subViews.forEach {
            self.addSubview($0)
        }
    }
    
    override func configureLayout() {
        profileImageView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).inset(16)
            $0.size.equalTo(100)
            $0.centerX.equalTo(self.safeAreaLayoutGuide)
        }
        
        profileImage.snp.makeConstraints {
            $0.top.bottom.equalTo(profileImageView)
            $0.size.equalTo(profileImageView)
            $0.centerX.equalTo(profileImageView)
        }
        
        cameraImageView.snp.makeConstraints {
            $0.trailing.equalTo(profileImage)
            $0.bottom.equalTo(profileImage).inset(8)
            $0.size.equalTo(24)
        }
        
        cameraImage.snp.makeConstraints {
            $0.center.equalTo(cameraImageView)
            $0.size.equalTo(15)
        }
        
        profileCollectionView.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(32)
            $0.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(16)
            $0.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
}
