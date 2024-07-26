//
//  EditProfileImageViewController.swift
//  mood-folio
//
//  Created by junehee on 7/26/24.
//

import UIKit

final class EditProfileImageViewController: BaseViewController {
    
    private let editProfileImageView = ProfileImageView()
    private let viewModel = EditProfileImageViewModel()
    
    var closure: ((Int) -> Void)?
    
    override func loadView() {
        view = editProfileImageView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindData()
        viewModel.inputViewDidLoad.value = ()
    }

    private func bindData() {
        viewModel.outputOriginProfileImage.bind { [weak self] num in
            self?.editProfileImageView.profileImage.image = Resource.Image.profileImages[num]
        }
        
        viewModel.outputChangedProfileImage.bind { [weak self] num in
            self?.closure?(num)
            self?.editProfileImageView.profileImage.image = Resource.Image.profileImages[num]
        }
        
    }
    
    override func configureViewController() {
        super.configureViewController()
        navigationItem.title = Constants.Title.editProfile
        setImgBarButton(image: Resource.SystemImage.left, target: self, action: #selector(popViewControllerWithClosure), type: .left)
        
        editProfileImageView.profileCollectionView.delegate = self
        editProfileImageView.profileCollectionView.dataSource = self
        editProfileImageView.profileCollectionView.register(ProfileImageCollectionViewCell.self, forCellWithReuseIdentifier: ProfileImageCollectionViewCell.id)
    }
    
    @objc private func popViewControllerWithClosure() {
        navigationController?.popViewController(animated: true)
    }
    
}


extension EditProfileImageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Resource.Image.profileImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileImageCollectionViewCell.id, for: indexPath) as? ProfileImageCollectionViewCell else { return ProfileImageCollectionViewCell() }
        
        let idx = indexPath.item
        let image = Resource.Image.profileImages[idx]
        
        if idx == viewModel.outputOriginProfileImage.value {
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

