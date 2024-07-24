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
//            self?.titleView.profileImage.image = Resource.Image.profileImages[profile
            self?.titleView.profileImage.setImage(Resource.Image.profileImages[profile], for: .normal)
        }
        
        viewModel.outputCallRequestNotify.bind { [weak self] _ in
            self?.topicView.tableView.reloadData()
        }
    }
    
    override func configureViewController() {
        super.configureViewController()
        topicView.tableView.delegate = self
        topicView.tableView.dataSource = self
        topicView.tableView.register(TopicTableViewCell.self, forCellReuseIdentifier: TopicTableViewCell.id)
    }
    
    
    private func setTitleProfileView() {
//        titleView.profileImage.addTarget(self, action: #selector(profileImageTapped), for: .touchUpInside)
        let profileButton = UIBarButtonItem(customView: titleView)
        navigationItem.rightBarButtonItem = profileButton
        
//        let tap = UITapGestureRecognizer(target: self, action: #selector(profileImageTapped))
//        titleView.profileImage.addTarget(self, action: #selector(profileImageTapped), for: .touchUpInside)
    }
    
    @objc private func profileImageTapped() {
        print("프로필 클릭")
//        navigationController?.pushViewController(EditProfileViewController(), animated: true)
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
        cell.collectionView.tag = indexPath.row
        cell.collectionView.reloadData()
        
        return cell
    }
}

// CollectionView
extension TopicViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.outputTopicList.value[collectionView.tag].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopicCollectionViewCell.id, for: indexPath) as? TopicCollectionViewCell else { return TopicCollectionViewCell() }

        let data = viewModel.outputTopicList.value[collectionView.tag][indexPath.item]
        cell.updateCell(data: data)
        
        return cell
    }
}
