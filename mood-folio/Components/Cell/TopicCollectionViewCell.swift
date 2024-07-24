//
//  TopicCollectionViewCell.swift
//  mood-folio
//
//  Created by junehee on 7/24/24.
//

import UIKit

import Kingfisher
import SnapKit

final class TopicCollectionViewCell: BaseCollectionViewCell {
    
    let imageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.layer.cornerRadius = 12
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
 
    override func configureHierarchy() {
        let views = [imageView, labelView]
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
    }
    
    func updateCell(data: Topic) {
        imageView.kf.setImage(with: URL(string: data.urls.small))
        starCountLabel.text = "\(data.likes.formatted())"
    }
    
}
