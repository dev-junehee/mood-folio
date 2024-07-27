//
//  SearchView.swift
//  mood-folio
//
//  Created by junehee on 7/25/24.
//

import UIKit
import SnapKit

final class SearchView: BaseView {
    
    let searchBar = {
        let view = UISearchBar()
        view.searchBarStyle = .minimal
        view.placeholder = Constants.Search.placeholder
        return view
    }()
    
    private let lineView = {
        let view = UIView()
        view.backgroundColor = Resource.Color.whiteSmoke
        return view
    }()
    
    let sortButton = {
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = Resource.Color.white
        config.baseForegroundColor = Resource.Color.black
        config.background.strokeColor = Resource.Color.whiteSmoke
        config.background.strokeWidth = 1
        config.cornerStyle = .capsule
        config.image = .sort
        config.imagePadding = 4
        
        var title = AttributedString(Constants.Search.relevant)
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
        let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/2), heightDimension: .fractionalHeight(1.0)) // 셀 크기
        let item = NSCollectionLayoutItem(layoutSize: size) // 아이템 크기
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(250)) // 아이템 담는 그룹 크기
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item]) // 수평
        group.interItemSpacing = .fixed(4) // 그룹 내 셀 사이 간격 설정
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 4 // 그룹 간의 간격
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    override func configureHierarchy() {
        let views = [searchBar, lineView, sortButton, emptyView, collectionView]
        views.forEach { self.addSubview($0) }
    }
    
    override func configureLayout() {
        searchBar.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(8)
            $0.height.equalTo(44)
        }
        
        lineView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(8)
            $0.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            $0.height.equalTo(1)
        }
        
        sortButton.snp.makeConstraints {
            $0.top.equalTo(lineView.snp.bottom).offset(8)
            $0.trailing.equalTo(self.safeAreaLayoutGuide).offset(8)
            $0.width.equalTo(90)
        }
        
        emptyView.snp.makeConstraints {
            $0.top.equalTo(sortButton.snp.bottom).offset(8)
            $0.horizontalEdges.bottom.equalTo(self.safeAreaLayoutGuide)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(sortButton.snp.bottom).offset(8)
            $0.horizontalEdges.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
    func updateSortButtonUI(changeType: SearchOrder) {
        switch changeType {
        case .relevant:
            var title = AttributedString(Constants.Search.relevant)
            title.font = Resource.Font.bold14
            sortButton.configuration?.attributedTitle = title
        case .latest:
            var title = AttributedString(Constants.Search.latest)
            title.font = Resource.Font.bold14
            sortButton.configuration?.attributedTitle = title
        }
    }
    
}
