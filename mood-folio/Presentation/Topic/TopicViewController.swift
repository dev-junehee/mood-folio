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
    
    private var topicList: [[Topic]] = [
        [],
        [],
        []
    ]

    override func loadView() {
        view = topicView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTitleProfileView()
        getTopics()
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

extension TopicViewController {
    private func getTopics() {
        let group = DispatchGroup()
        
        // 골든 아워
        group.enter()
        DispatchQueue.global().async(group: group) {
            NetworkManager.shared.callRequest(api: .topic(topicId: "golden-hour")) { (res: Result<[Topic]?, Error>) in
                switch res {
                case .success(let data):
                    guard let data else { return }
                    dump(data)
                    self.topicList[0] = data
                case .failure(let error):
                    print(error)
                }
                group.leave()
            }
        }
        
        // 비즈니스 및 업무
        group.enter()
        DispatchQueue.global().async(group: group) {
            NetworkManager.shared.callRequest(api: .topic(topicId: "business-work")) { (res: Result<[Topic]?, Error>) in
                switch res {
                case .success(let data):
                    guard let data else { return }
                    dump(data)
                    self.topicList[1] = data
                case .failure(let error):
                    print(error)
                }
                group.leave()
            }
        }
        
        // 건축 및 인테리어
        group.enter()
        DispatchQueue.global().async(group: group) {
            NetworkManager.shared.callRequest(api: .topic(topicId: "architecture-interior")) { (res: Result<[Topic]?, Error>) in
                switch res {
                case .success(let data):
                    guard let data else { return }
                    dump(data)
                    self.topicList[2] = data
                case .failure(let error):
                    print(error)
                }
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            print("=====================끝났어용===================")
            self.topicView.tableView.reloadData()
        }
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
        return topicList[collectionView.tag].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopicCollectionViewCell.id, for: indexPath) as? TopicCollectionViewCell else { return TopicCollectionViewCell() }

        let data = topicList[collectionView.tag][indexPath.item]
        cell.updateCell(data: data)
        
        return cell
    }
}
