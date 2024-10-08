//
//  SearchCollectionViewCell.swift
//  mood-folio
//
//  Created by junehee on 7/25/24.
//

import UIKit

import Kingfisher
import SnapKit

final class SearchCollectionViewCell: BaseCollectionViewCell {
    
    var heartButtonAction: (() -> Void)?
    
    private let imageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.backgroundColor = .lightGray
        return view
    }()
    
    private lazy var labelView = {
        let view = UIView()
        view.backgroundColor = Resource.Color.gray
        view.layer.cornerRadius = 15
        view.addSubview(starImage)
        view.addSubview(starCountLabel)
        return view
    }()
    
    private let starImage = {
        let view = UIImageView()
        view.image = Resource.SystemImage.star
        view.tintColor = Resource.Color.yellow
        return view
    }()
    
    private let starCountLabel = {
        let label = UILabel()
        label.textColor = Resource.Color.white
        label.font = Resource.Font.bold14
        return label
    }()
    
    lazy var heartButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(heartButtonClicked), for: .touchUpInside)
        return button
    }()
 
    override func configureHierarchy() {
        let views = [imageView, labelView, heartButton]
        views.forEach { contentView.addSubview($0) }
    }
    
    override func configureLayout() {
        imageView.snp.makeConstraints {
            $0.edges.equalTo(contentView)
        }
        
        labelView.snp.makeConstraints {
            $0.leading.equalTo(imageView.snp.leading).offset(8)
            $0.bottom.equalTo(imageView.snp.bottom).inset(8)
            $0.width.equalTo(80)
            $0.height.equalTo(30)
        }
        
        starImage.snp.makeConstraints {
            $0.leading.equalTo(labelView.snp.leading).offset(10)
            $0.centerY.equalTo(labelView)
            $0.size.equalTo(14)
        }
        
        starCountLabel.snp.makeConstraints {
            $0.trailing.equalTo(labelView.snp.trailing).inset(10)
            $0.centerY.equalTo(labelView)
        }
        
        heartButton.snp.makeConstraints {
            $0.trailing.equalTo(imageView.snp.trailing).inset(8)
            $0.bottom.equalTo(imageView.snp.bottom).inset(8)
            $0.size.equalTo(30)
        }
    }
    
    // 검색
    func updateSearchCellUI(data: Photo) {
        starCountLabel.text = data.likes.formatted()
        
        if let image = URL(string: data.urls.small) {
            imageView.kf.setImage(with: image)
        } else {
            imageView.image = Resource.SystemImage.questionmark
        }
        
        updateHeartButtonUI(id: data.id)
    }
    
    func updateHeartButtonUI(id: String) {
        let repo = LikePhotoRepository()
        let isLikePhoto = repo.isLikePhoto(id: id)
        let buttonImage = isLikePhoto ? Resource.Image.likeCircle : Resource.Image.likeCircleInactive
        heartButton.setImage(buttonImage, for: .normal)
    }
    
    // 찜한 사진 셀
    func updateLikePhotoCell(data: LikePhoto) {
        labelView.isHidden = true
        
        if let image = DocumentFileManager.shared.loadImageToDocument(filename: data.id) {
            imageView.image = image
        }
        
        heartButton.setImage(Resource.Image.likeCircle, for: .normal)
    }
    
    @objc private func heartButtonClicked() {
        heartButtonAction?()
    }
    
}
