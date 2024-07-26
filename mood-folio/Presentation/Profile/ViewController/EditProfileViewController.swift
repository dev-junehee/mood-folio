//
//  EditProfileViewController.swift
//  mood-folio
//
//  Created by junehee on 7/24/24.
//

import Foundation

final class EditProfileViewController: BaseViewController {
    
    private let editView = ProfileView()
    private let viewModel = EditProfileViewModel()
    
    override func loadView() {
        view = editView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHandler()
        bindData()
        viewModel.inputViewDidLoad.value = ()
    }
    
    private func bindData() {
        viewModel.outputOriginInfo.bind { [weak self] (profile, nickname) in
            self?.editView.profileImage.image = Resource.Image.profileImages[profile]
            self?.editView.nicknameField.text = nickname
            self?.editView.isEditing = true
            self?.navigationItem.rightBarButtonItem?.isEnabled = false
        }
        
        viewModel.outputDeleteAccount.bind { [weak self] _ in
            self?.showAlert(title: Constants.Alert.ToOnboarding.title,
                            message: Constants.Alert.ToOnboarding.message,
                            buttonType: .oneButton,
                            okHandler: { [weak self] _ in
                self?.changeRootViewControllerToOnboarding()
            })
        }
    }
    
    override func configureViewController() {
        super.configureViewController()
        navigationItem.title = Constants.Title.editProfile
        setImgBarButton(image: Resource.SystemImage.left, target: self, action: #selector(popViewController), type: .left)
        setTextBarButtoon(title: Constants.Button.save, target: self, action: #selector(saveButtonClicked), type: .right)
    }
    
    private func configureHandler() {
        editView.deleteAccountButton.addTarget(self, action: #selector(deleteAccountButtonClicked), for: .touchUpInside)
    }
    
    @objc private func deleteAccountButtonClicked() {
        print(#function)
        showAlert(title: Constants.Alert.Cancelation.title,
                  message: Constants.Alert.Cancelation.message,
                  buttonType: .twoButton) { [weak self] _ in
            self?.viewModel.inputDeleteAccountButton.value = ()
        }
    }
    
    @objc private func saveButtonClicked() {
        print(#function)
    }
    
}
