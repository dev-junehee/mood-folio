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
    
    private var dataSource: UICollectionViewDiffableDataSource<LikeSection, LikePhoto>!
    
    private var likeOrder: LikeOrder = .latest
    
    override func loadView() {
        view = likeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHandler()
        configureDataSource()
        updateSnapshot()
        bindData()
        viewModel.inputViewDidLoad.value = likeOrder
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.inputViewWillAppear.value = likeOrder
    }
    
    private func bindData() {
        viewModel.outputLikePhotoList.bind { [weak self] _ in
            self?.updateSnapshot()
            self?.viewToggle()
        }
        
        // viewModel.outputLikePhotoListSorted.bind { [weak self] _ in
        //     self?.updateSnapshot()
        //     self?.viewToggle()
        // }
    }
    
    override func configureViewController() {
        navigationItem.title = Constants.Title.like
        likeView.collectionView.delegate = self
    }
    
    private func configureHandler() {
        likeView.sortButton.addTarget(self, action: #selector(sortButtonClicked), for: .touchUpInside)
    }
    
    private func configureCellRegistration() -> UICollectionView.CellRegistration<SearchCollectionViewCell, LikePhoto> {
        return UICollectionView.CellRegistration { [weak self] cell, indexPath, itemIdentifier in
            cell.updateLikePhotoCell(data: itemIdentifier)
            cell.heartButtonAction = {
                self?.heartButtonClicked(for: itemIdentifier)
            }
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
        var snapshot = NSDiffableDataSourceSnapshot<LikeSection, LikePhoto>()
        snapshot.appendSections(LikeSection.allCases)
        snapshot.appendItems(viewModel.outputLikePhotoList.value, toSection: .main)
        dataSource.apply(snapshot)
    }
    
    private func viewToggle() {
        let isEmpty = viewModel.outputLikePhotoList.value.isEmpty
        if isEmpty {
            likeView.collectionView.isHidden = true
            likeView.emptyView.isHidden = false
            likeView.emptyView.emptyText = "저장된 사진이 없어요!"
        } else {
            likeView.collectionView.isHidden = false
            likeView.emptyView.isHidden = true
        }
    }
    
    @objc private func sortButtonClicked(_ sender: UIButton) {
        let buttonLabel = sender.titleLabel?.text
        if buttonLabel == Constants.Like.latest {
            likeOrder = .past
        } else {
            likeOrder = .latest
        }
        likeView.updateSortButtonUI(changeType: likeOrder)
        viewModel.inputSortButton.value = likeOrder
    }
    
    @objc private func heartButtonClicked(for likePhoto: LikePhoto) {
        viewModel.inputHeartButton.value = (likePhoto.id, likeOrder)
                                            
    }
    
}

extension LikeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        detailVC.detailType = .likePhoto
        detailVC.viewModel.inputLikePhotoData.value = viewModel.outputLikePhotoListSorted.value[indexPath.item]
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
