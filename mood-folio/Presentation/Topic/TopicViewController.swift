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
