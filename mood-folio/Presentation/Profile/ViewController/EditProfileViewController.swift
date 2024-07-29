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
            navigationItem.rightBarButtonItem?.setButtonEnabled()
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
            self?.navigationItem.rightBarButtonItem?.setButtonDisabled()
            
            guard let buttons = self?.editView.mbtiButtons else { return }
            for button in buttons {
                if let title = button.title(for: .normal), mbti.contains(title) {
                    button.isSelected = true
                } else {
                    button.isSelected = false
                }
            }
        }
        
        viewModel.outputNicknameResult.bind { [weak self] res in
            if res {
                self?.editView.invalidMessage.textColor = Resource.Color.primary
                self?.navigationItem.rightBarButtonItem?.setButtonEnabled()
            } else {
                self?.editView.invalidMessage.textColor = Resource.Color.pink
                self?.navigationItem.rightBarButtonItem?.setButtonDisabled()
            }
        }
        
        viewModel.outputNicknameInvalidMessage.bind { [weak self] validation in
            self?.editView.invalidMessage.text = validation.rawValue
        }
        
        viewModel.outputOppositeMBTI.bind { [weak self] type in
            switch type {
            case .E:
                self?.editView.mbtiButtonE.isSelected = false
            case .S:
                self?.editView.mbtiButtonS.isSelected = false
            case .T:
                self?.editView.mbtiButtonT.isSelected = false
            case .J:
                self?.editView.mbtiButtonJ.isSelected = false
            case .I:
                self?.editView.mbtiButtonI.isSelected = false
            case .N:
                self?.editView.mbtiButtonN.isSelected = false
            case .F:
                self?.editView.mbtiButtonF.isSelected = false
            case .P:
                self?.editView.mbtiButtonP.isSelected = false
            default: break
            }
        }
        

        viewModel.outputMBTIResult.bind { [weak self] res in
            if res {
                self?.navigationItem.rightBarButtonItem?.setButtonEnabled() // MBTI 성공
            } else {
                self?.navigationItem.rightBarButtonItem?.setButtonDisabled() // MBTI 실패
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
            self?.changeProfileNum = profile
        }
        navigationController?.pushViewController(editProfileImageVC, animated: true)
    }
    
    @objc private func nicknameFieldEditing() {
        viewModel.inputNicknameTextField.value = editView.nicknameField.text
    }
    
    @objc private func mbtiButtonClicked(_ sender: MBTIButtton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            viewModel.inputActiveMBTIButton.value = sender.titleLabel?.text
        } else {
            viewModel.inputInactiveMBTIButton.value = sender.titleLabel?.text
        }
    }
    
    
    @objc private func deleteAccountButtonClicked() {
        showAlert(title: Constants.Alert.Cancelation.title,
                  message: Constants.Alert.Cancelation.message,
                  buttonType: .twoButton) { [weak self] _ in
            self?.viewModel.inputDeleteAccountButton.value = ()
        }
    }
    
    @objc private func saveButtonClicked() {
        // 수정된 프로필 저장
        if viewModel.outputNicknameResult.value {
            guard let nickname = viewModel.inputNicknameTextField.value else { return }
            UserDefaultsManager.nickname = nickname
        }
        
        if let changeProfileNum {
            UserDefaultsManager.profile = changeProfileNum
        }
        
        if viewModel.outputMBTIResult.value {
            UserDefaultsManager.mbti = viewModel.outputMBTI.value
        }
        
        showAlert(title: Constants.Alert.EditProfile.title, 
                  message: Constants.Alert.EditProfile.message,
                  buttonType: .oneButton) { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }
    }
    
}
