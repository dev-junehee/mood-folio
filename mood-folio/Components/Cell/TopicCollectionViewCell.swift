//
//  TopicCollectionViewCell.swift
//  mood-folio
//
//  Created by junehee on 7/24/24.
//

import UIKit

final class TopicCollectionViewCell: BaseCollectionViewCell {
    
    let imageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.layer.cornerRadius = 10
        // 임시
        view.backgroundColor = .systemPink
        return view
    }()
    
    let labelView = {
        let view = UIView()
        view.backgroundColor = Resource.Color.gray
        return view
    }()
 
    override func configureHierarchy() {
        let views = [imageView]
        views.forEach { contentView.addSubview($0) }
    }
    
    override func configureLayout() {
        imageView.snp.makeConstraints {
            $0.edges.equalTo(contentView)
        }
    }
    
}
