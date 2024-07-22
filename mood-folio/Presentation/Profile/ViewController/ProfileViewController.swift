//
//  ProfileViewController.swift
//  mood-folio
//
//  Created by junehee on 7/22/24.
//

import UIKit
import TextFieldEffects

final class ProfileViewController: BaseViewController {
    
    private let mainView = ProfileView()
    private let viewModel = ProfileViewModel()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // 랜덤 프로필 이미지 설정
        viewModel.inputViewWillAppear.value = ()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHandler()
        bindData()
    }
    
    private func bindData() {
        viewModel.outputProfileImage.bind { [weak self] num in
            self?.mainView.profileImage.image = Resource.Image.profileImages[num]
        }
        
        viewModel.outputNicknameIsValid.bind { [weak self] isValid in
            if isValid {
                self?.mainView.invalidMessage.textColor = Resource.Color.primary
            } else {
                self?.mainView.invalidMessage.textColor = Resource.Color.pink
            }
        }
        
        viewModel.outputNicknameInvalidMessage.bind { [weak self] validation in
            self?.mainView.invalidMessage.text = validation.rawValue
        }
    }
    
    override func configureViewController() {
        super.configureViewController()
        navigationItem.title = Constants.NavigationTitle.ProfileSetting
        setImgBarButton(image: Resource.SystemImage.left, target: self, action: #selector(popViewController), type: .left)
    }
    
    private func configureHandler() {
        let tapped = UITapGestureRecognizer(target: self, action: #selector(keyboardDismiss))
        view.addGestureRecognizer(tapped)
        
        mainView.nicknameField.addTarget(self, action: #selector(nicknameFieldEditing), for: .editingChanged)
        mainView.doneButton.addTarget(self, action: #selector(doneButtonClicked), for: .touchUpInside)
    }
    
    @objc private func nicknameFieldEditing() {
        viewModel.inputNicknameTextField.value = mainView.nicknameField.text
    }
    
    @objc private func doneButtonClicked() {
        print(#function)
    }
}

