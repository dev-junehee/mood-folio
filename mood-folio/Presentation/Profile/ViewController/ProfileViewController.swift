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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHandler()
        bindData()
        viewModel.inputViewDidLoad.value = ()
        print("선택한거!!!!! >>>> ", viewModel.outputProfileImage.value)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.inputViewWillAppear.value = ()  // 랜덤 프로필 이미지 설정
        print("선택한거!!!!! >>>> ", viewModel.outputProfileImage.value)
    }
    
    private func bindData() {
        // viewWillAppear 시점마다 프로필 이미지 랜덤
        viewModel.outputProfileImage.bind { [weak self] num in
            self?.mainView.profileImage.image = Resource.Image.profileImages[num]
        }
        
        // 닉네임 유효성 검사 결과
        viewModel.outputNicknameIsValid.bind { [weak self] isValid in
            if isValid {
                self?.mainView.invalidMessage.textColor = Resource.Color.primary
            } else {
                self?.mainView.invalidMessage.textColor = Resource.Color.pink
            }
        }
        
        // 닉네임 유효성 검사 메세지
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
        // 배경 탭
        let backgroundTap = UITapGestureRecognizer(target: self, action: #selector(keyboardDismiss))
        view.addGestureRecognizer(backgroundTap)
        // 프로필 이미지 탭
        let profileTap =  UITapGestureRecognizer(target: self, action: #selector(profileImageClicked))
        mainView.profileImageView.addGestureRecognizer(profileTap)
        
        // 닉네임 텍스트필드 입력
        mainView.nicknameField.addTarget(self, action: #selector(nicknameFieldEditing), for: .editingChanged)
        // MBTI 버튼 클릭
        mainView.mbtiButtons.forEach {
            $0.addTarget(self, action: #selector(mbtiButtonClicked), for: .touchUpInside)
        }
        // 완료 버튼 클릭
        mainView.doneButton.addTarget(self, action: #selector(doneButtonClicked), for: .touchUpInside)
    }
    
    @objc private func profileImageClicked() {
        navigationController?.pushViewController(ProfileImageViewController(), animated: true)
    }
    
    @objc private func nicknameFieldEditing() {
        viewModel.inputNicknameTextField.value = mainView.nicknameField.text
    }
    
    @objc private func mbtiButtonClicked(_ sender: UIButton) {
        viewModel.inputMBTIButton.value = sender.titleLabel?.text
    }
    
    @objc private func doneButtonClicked() {
        viewModel.inputDoneButton.value = ()
    }
}

