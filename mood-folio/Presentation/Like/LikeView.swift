//
//  LikeView.swift
//  mood-folio
//
//  Created by junehee on 7/26/24.
//

import UIKit
import SnapKit

final class LikeView: BaseView {
    
    let sortButton = {
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = Resource.Color.white
        config.baseForegroundColor = Resource.Color.black
        config.background.strokeColor = Resource.Color.whiteSmoke
        config.background.strokeWidth = 1
        config.cornerStyle = .capsule
        config.image = .sort
        config.imagePadding = 4
        
        var title = AttributedString(Constants.Like.latest)
        title.font = Resource.Font.bold14
        config.attributedTitle = title
        
        var imageConfig = UIImage.SymbolConfiguration(pointSize: 12)
        config.preferredSymbolConfigurationForImage = imageConfig
        
        let button = UIButton(configuration: config)
        return button
    }()
    
    let emptyView = EmptyView()
    
    lazy var collectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout())
        view.keyboardDismissMode = .onDrag
        return view
    }()
    
    private func layout() -> UICollectionViewLayout {
        let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/2), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: size)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(250))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(4)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 4 // 그룹 간의 간격 설정
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    override func configureHierarchy() {
        let views = [sortButton, emptyView, collectionView]
        views.forEach { self.addSubview($0) }
    }
    
    override func configureLayout() {
        let safeArea = self.safeAreaLayoutGuide
        
        sortButton.snp.makeConstraints {
            $0.top.equalTo(safeArea)
            $0.trailing.equalTo(safeArea).offset(8)
            $0.width.equalTo(90)
        }
        
        emptyView.snp.makeConstraints {
            $0.top.equalTo(sortButton.snp.bottom).offset(8)
            $0.horizontalEdges.bottom.equalTo(safeArea)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(sortButton.snp.bottom).offset(8)
            $0.horizontalEdges.bottom.equalTo(safeArea)
        }
    }
    
    func updateSortButtonUI(changeType: LikeOrder) {
        switch changeType {
        case .latest:
            var title = AttributedString(Constants.Like.latest)
            title.font = Resource.Font.bold14
            sortButton.configuration?.attributedTitle = title
        case .past:
            var title = AttributedString(Constants.Like.past)
            title.font = Resource.Font.bold14
            sortButton.configuration?.attributedTitle = title
        }
    }
    
}
