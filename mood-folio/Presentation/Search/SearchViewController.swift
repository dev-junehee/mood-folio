//
//  SearchViewController.swift
//  mood-folio
//
//  Created by junehee on 7/24/24.
//

import UIKit

final class SearchViewController: BaseViewController {
    
    enum EmptyViewType {
        case noSearch
        case noResult
    }
    
    enum Section: CaseIterable {
        case main
    }
    
    private let searchView = SearchView()
    private let viewModel = SearchViewModel()
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, Photo>!
    
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
    }
    
    override func configureViewController() {
        navigationItem.title = Constants.Title.search
        searchView.searchBar.delegate = self
    }
    
    private func configureHandler() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(keyboardDismiss))
        view.addGestureRecognizer(tap)
        
        // 정렬 버튼
        searchView.sortButton.addTarget(self, action: #selector(sortButtonClicked), for: .touchUpInside)
    }
    
    private func configureCellRegistration() -> UICollectionView.CellRegistration<SearchCollectionViewCell, Photo> {
        return UICollectionView.CellRegistration { cell, indexPath, itemIdentifier in
            cell.updateUI(data: itemIdentifier)
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
        var snapshot = NSDiffableDataSourceSnapshot<Section, Photo>()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(viewModel.outputSearchResult.value?.results ?? [], toSection: .main)
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
    
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.inputSearchText.value = searchBar.text
    }
}
