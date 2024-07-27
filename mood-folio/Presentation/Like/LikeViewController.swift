//
//  LikeViewController.swift
//  mood-folio
//
//  Created by junehee on 7/24/24.
//

import UIKit

final class LikeViewController: BaseViewController {
    
    private enum LikeSection: CaseIterable {
        case main
    }
    
    private let likeView = LikeView()
    private let viewModel = LikeViewModel()
    
    private var dataSource: UICollectionViewDiffableDataSource<LikeSection, Photo>!
    
    override func loadView() {
        view = likeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHandler()
        bindData()
    }
    
    private func bindData() {
        
    }
    
    override func configureViewController() {
        navigationItem.title = Constants.Title.like
    }
    
    private func configureHandler() {
        likeView.sortButton.addTarget(self, action: #selector(sortButtonClicked), for: .touchUpInside)
    }
    
    private func configureCellRegistration() -> UICollectionView.CellRegistration<SearchCollectionViewCell, Photo> {
        return UICollectionView.CellRegistration { cell, indexPath, itemIdentifier in
            cell.updateUI(data: itemIdentifier)
        }
    }
    
    private func configureDataSource() {
        let cellRegistration = configureCellRegistration()
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: likeView.collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(
                using: cellRegistration,
                for: indexPath,
                item: itemIdentifier)
            return cell
        })
    }
    
    private func updateSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<LikeSection, Photo>()
        snapshot.appendSections(LikeSection.allCases)
        snapshot.appendItems(viewModel.outputLikePhotoList.value, toSection: .main)
        dataSource.apply(snapshot)
    }
    
    private func viewToggle() {
        likeView.collectionView.isHidden = !likeView.emptyView.isHidden
    }
    
    
    @objc private func sortButtonClicked(_ sender: UIButton) {
        let buttonLabel = sender.titleLabel?.text
        if buttonLabel == Constants.Like.latest {
            likeView.updateSortButtonUI(changeType: .past)
        } else {
            likeView.updateSortButtonUI(changeType: .latest)
        }
    }
    
}

