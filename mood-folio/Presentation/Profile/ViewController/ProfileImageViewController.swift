//
//  ProfileImageViewController.swift
//  mood-folio
//
//  Created by junehee on 7/23/24.
//

import UIKit

final class ProfileImageViewController: BaseViewController {
    
    private let mainView = ProfileImageView()
    private let viewModel = ProfileImageViewModel()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.inputViewWillAppear.value = ()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindData()
    }
    
    private func bindData() {
        viewModel.outputProfileImage.bind { [weak self] _ in
            self?.configureUI()
        }
    }
    
    override func configureViewController() {
        super.configureViewController()
        navigationItem.title = Constants.NavigationTitle.ProfileSetting
        setImgBarButton(image: Resource.SystemImage.left, target: self, action: #selector(popViewController), type: .left)
        
        mainView.profileCollectionView.delegate = self
        mainView.profileCollectionView.dataSource = self
        mainView.profileCollectionView.register(ProfileImageCollectionViewCell.self, forCellWithReuseIdentifier: ProfileImageCollectionViewCell.id)
    }
    
    override func configureUI() {
        let image = viewModel.outputProfileImage.value
        mainView.profileImage.image = Resource.Image.profileImages[image]
    }
}

extension ProfileImageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Resource.Image.profileImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileImageCollectionViewCell.id, for: indexPath) as? ProfileImageCollectionViewCell else { return ProfileImageCollectionViewCell() }
        
        let idx = indexPath.item
        let image = Resource.Image.profileImages[idx]
        
        if idx == viewModel.outputProfileImage.value {
            cell.isSelected = true
            collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .init())
            cell.configureSelectedUI()
        }
        cell.configureCellData(data: image)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.inputProfileImageSelected.value = indexPath.item
    }
}
