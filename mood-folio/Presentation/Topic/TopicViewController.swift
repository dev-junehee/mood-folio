//
//  TopicViewController.swift
//  mood-folio
//
//  Created by junehee on 7/24/24.
//

import UIKit

final class TopicViewController: BaseViewController {
    
    private let titleView = ProfileTitleView()
    private let topicView = TopicView()
    private let viewModel = TopicViewModel()

    override func loadView() {
        view = topicView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTitleProfileView()
        bindData()
        viewModel.inputViewDidLoad.value = ()
    }
    
    private func bindData() {
        viewModel.outputProfileImage.bind { [weak self] profile in
            self?.titleView.profileImage.image = Resource.Image.profileImages[profile]
        }
    }
    
    override func configureViewController() {
        super.configureViewController()
        topicView.tableView.delegate = self
        topicView.tableView.dataSource = self
        topicView.tableView.register(TopicTableViewCell.self, forCellReuseIdentifier: TopicTableViewCell.id)
    }
    
    
    private func setTitleProfileView() {
        let profileButton = UIBarButtonItem(customView: titleView)
        navigationItem.rightBarButtonItem = profileButton
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(profileImageTapped))
//        navigationItem.rightBarButtonItem?.customView?.addGestureRecognizer(tap)
//        titleView.profileImage.addGestureRecognizer(tap)
    }
    
    @objc private func profileImageTapped() {
        navigationController?.pushViewController(EditProfileViewController(), animated: true)
    }
    
}

// TableView
extension TopicViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TopicTableViewCell.id, for: indexPath) as? TopicTableViewCell else { return TopicTableViewCell() }
        
        let title = Constants.Topic.titles[indexPath.row]
        cell.configureCellTitle(title: title)
        
        cell.collectionView.delegate = self
        cell.collectionView.dataSource = self
        cell.collectionView.register(TopicCollectionViewCell.self, forCellWithReuseIdentifier: TopicCollectionViewCell.id)
        
        return cell
    }
}

// CollectionView
extension TopicViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopicCollectionViewCell.id, for: indexPath) as? TopicCollectionViewCell else { return TopicCollectionViewCell() }
        
        
        return cell
    }
}
