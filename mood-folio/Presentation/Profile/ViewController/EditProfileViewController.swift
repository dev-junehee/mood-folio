//
//  EditProfileViewController.swift
//  mood-folio
//
//  Created by junehee on 7/24/24.
//

import UIKit

final class EditProfileViewController: BaseViewController {
    
    private let editView = ProfileView()
    private let viewModel = EditProfileViewModel()
    
    private var changeProfileNum: Int? {
        didSet {
            guard let num = changeProfileNum else { return }
            editView.profileImage.image = Resource.Image.profileImages[num]
            navigationItem.rightBarButtonItem?.isEnabled = true
            navigationItem.rightBarButtonItem?.tintColor = Resource.Color.primary
        }
    }
    
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
        viewModel.outputOriginInfo.bind { [weak self] (profile, nickname, mbti) in
            self?.editView.profileImage.image = Resource.Image.profileImages[profile]
            self?.editView.nicknameField.text = nickname
            self?.editView.isEditing = true
            self?.navigationItem.rightBarButtonItem?.isEnabled = false
            
            guard let buttons = self?.editView.mbtiButtons else { return }
            for button in buttons {
                if let title = button.title(for: .normal), mbti.contains(title) {
                    button.isSelected = true
                } else {
                    button.isSelected = false
                }
            }
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
        // 배경 탭
        let backgroundTap = UITapGestureRecognizer(target: self, action: #selector(keyboardDismiss))
        view.addGestureRecognizer(backgroundTap)
        
        // 프로필 이미지 탭
        let profileTap =  UITapGestureRecognizer(target: self, action: #selector(profileImageClicked))
        editView.profileImageView.addGestureRecognizer(profileTap)
        
        // 닉네임 텍스트필드 입력
        editView.nicknameField.addTarget(self, action: #selector(nicknameFieldEditing), for: .editingChanged)
        
        // MBTI 버튼 클릭
        editView.mbtiButtons.forEach {
            $0.addTarget(self, action: #selector(mbtiButtonClicked), for: .touchUpInside)
        }
        
        // 회원탈퇴 버튼
        editView.deleteAccountButton.addTarget(self, action: #selector(deleteAccountButtonClicked), for: .touchUpInside)
    }
    
    @objc private func profileImageClicked() {
        let editProfileImageVC = EditProfileImageViewController()
        editProfileImageVC.closure = { [weak self] profile in
            // 바꾸려고 하는 프로필 사진을 보여주기만 하는 상황 (아직 UD에 저장 안됨!)
            self?.changeProfileNum = profile
        }
        navigationController?.pushViewController(editProfileImageVC, animated: true)
    }
    
    @objc private func nicknameFieldEditing() {
        
    }
    
    @objc private func mbtiButtonClicked() {
        
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
        // 새로운 정보 저장
        guard let changeProfileNum else { return }
        UserDefaultsManager.shared.profile = changeProfileNum
        
        showAlert(title: Constants.Alert.EditProfile.title, message: Constants.Alert.EditProfile.message, buttonType: .oneButton) { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }
    }
    
}
