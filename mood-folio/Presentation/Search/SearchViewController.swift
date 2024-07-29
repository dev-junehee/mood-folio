//
//  SearchViewController.swift
//  mood-folio
//
//  Created by junehee on 7/24/24.
//

import UIKit

final class SearchViewController: BaseViewController {
    
    private enum EmptyViewType {
        case noSearch
        case noResult
    }
    
    private enum SearchSection: CaseIterable {
        case main
    }
    
    private let searchView = SearchView()
    private let viewModel = SearchViewModel()
    
    private var dataSource: UICollectionViewDiffableDataSource<SearchSection, Photo>!
    
    override func loadView() {
        view = searchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHandler()
        bindData()
        configureDataSource()
        updateSnapshot()
        showEmptyView(type: .noSearch)
    }
    
    private func bindData() {
        viewModel.outputSearchResult.bind { [weak self] _ in
            self?.showCollectionView()
            self?.updateSnapshot()
        }
        
        viewModel.outputSearchNoResult.bind { [weak self] _ in
            self?.showEmptyView(type: .noResult)
        }
        
        viewModel.outputCreateLikePhotoTrigger.bind { [weak self] _ in
            self?.updateSnapshot()
        }
        
        viewModel.outputCreateLikePhotoTrigger.bind { [weak self] _ in
            self?.updateSnapshot()
        }
    }
    
    override func configureViewController() {
        navigationItem.title = Constants.Title.search
        searchView.searchBar.delegate = self
        searchView.collectionView.delegate = self
        searchView.collectionView.prefetchDataSource = self
    }
    
    private func configureHandler() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(keyboardDismiss))
        searchView.emptyView.addGestureRecognizer(tap)
        
        // 정렬 버튼
        searchView.sortButton.addTarget(self, action: #selector(sortButtonClicked), for: .touchUpInside)
    }
    
    private func configureCellRegistration() -> UICollectionView.CellRegistration<SearchCollectionViewCell, Photo> {
        return UICollectionView.CellRegistration { [weak self] cell, indexPath, itemIdentifier in
            cell.updateSearchCellUI(data: itemIdentifier)
            cell.heartButtonAction = {
                self?.heartButtonClicked(for: itemIdentifier)
            }
        }
    }
    
    private func configureDataSource() {
        let cellRegistration = configureCellRegistration()
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: searchView.collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(
                using: cellRegistration,
                for: indexPath,
                item: itemIdentifier)
            return cell
        })
    }
    
    private func updateSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<SearchSection, Photo>()
        snapshot.appendSections(SearchSection.allCases)
        snapshot.appendItems(viewModel.outputSearchResult.value.results, toSection: .main)
        dataSource.apply(snapshot)
    }
    
    private func showEmptyView(type: EmptyViewType) {
        searchView.collectionView.isHidden = true
        searchView.emptyView.isHidden = false
        
        switch type {
        case .noSearch:
            searchView.emptyView.emptyText = Constants.Search.noSearch
        case .noResult:
            searchView.emptyView.emptyText = Constants.Search.noResult
        }
    }
    
    private func showCollectionView() {
        searchView.collectionView.isHidden = false
        searchView.emptyView.isHidden = true
    }
    
    @objc private func sortButtonClicked(_ sender: UIButton) {
        // 관련순일 때 - 최신순 변경, 최신순일 때 - 관련순 변경
        let buttonLabel = sender.titleLabel?.text
        if buttonLabel == Constants.Search.relevant {
            viewModel.inputSortButton.value = .latest
            searchView.updateSortButtonUI(changeType: .latest)
        } else {
            viewModel.inputSortButton.value = .relevant
            searchView.updateSortButtonUI(changeType: .relevant)
        }
    }
    
    private func heartButtonClicked(for Photo: Photo) {
        viewModel.inputHeartButton.value = Photo
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.inputSearchText.value = searchBar.text
    }
}

extension SearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        detailVC.viewModel.inputPhotoData.value = viewModel.outputSearchResult.value.results[indexPath.item]
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension SearchViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if viewModel.outputSearchResult.value.results.count - 2 == indexPath.item {
                viewModel.inputInfinityScroll.value = ()
            }
        }
    }
}
