//
//  TopicTableViewCell.swift
//  mood-folio
//
//  Created by junehee on 7/24/24.
//

import UIKit
import SnapKit

final class TopicTableViewCell: BaseTableViewCell {
    
    let titleLabel = {
        let label = UILabel()
        label.font = Resource.Font.bold16
        return label
    }()
    
    lazy var collectionView =  UICollectionView(frame: .zero, collectionViewLayout: layout())
    
    private func layout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 180, height: 240)
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        return layout
    }
    
    override func configureHierarchy() {
        let views = [titleLabel, collectionView]
        views.forEach { contentView.addSubview($0) }
    }
    
    override func configureLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(contentView).offset(8)
            $0.horizontalEdges.equalTo(contentView).inset(20)
            $0.height.equalTo(20)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.horizontalEdges.bottom.equalTo(contentView)
        }
    }
    
    func configureCellTitle(title: String) {
        titleLabel.text = title
    }
}
