//
//  ProfileViewController.swift
//  mood-folio
//
//  Created by junehee on 7/22/24.
//

import UIKit
import TextFieldEffects

final class ProfileViewController: BaseViewController {
    
    private let profileView = ProfileView()
    private let viewModel = ProfileViewModel()
    
    override func loadView() {
        view = profileView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHandler()
        bindData()
        viewModel.inputViewDidLoad.value = ()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.inputViewWillAppear.value = ()  // 랜덤 프로필 이미지 설정
    }
    
    private func bindData() {
        // viewWillAppear 시점마다 프로필 이미지 랜덤
        viewModel.outputProfileImage.bind { [weak self] num in
            self?.profileView.profileImage.image = Resource.Image.profileImages[num]
            self?.profileView.isEditing = false
        }
        
        // 닉네임 유효성 검사 결과
        viewModel.outputNicknameResult.bind { [weak self] res in
            if res {
                self?.profileView.invalidMessage.textColor = Resource.Color.primary
            } else {
                self?.profileView.invalidMessage.textColor = Resource.Color.pink
            }
        }
        
        // 닉네임 유효성 검사 메세지
        viewModel.outputNicknameInvalidMessage.bind { [weak self] validation in
            self?.profileView.invalidMessage.text = validation.rawValue
        }
        
        // MBTI 누를 때 반대 버튼 변경
        viewModel.outputOppositeMBTI.bind { [weak self] type in
            switch type {
            case .E:
                self?.profileView.mbtiButtonE.isSelected = false
            case .S:
                self?.profileView.mbtiButtonS.isSelected = false
            case .T:
                self?.profileView.mbtiButtonT.isSelected = false
            case .J:
                self?.profileView.mbtiButtonJ.isSelected = false
            case .I:
                self?.profileView.mbtiButtonI.isSelected = false
            case .N:
                self?.profileView.mbtiButtonN.isSelected = false
            case .F:
                self?.profileView.mbtiButtonF.isSelected = false
            case .P:
                self?.profileView.mbtiButtonP.isSelected = false
            default: break
            }
        }
        
        // MBTI 설정 결과
        viewModel.outputMBTIResult.bind { [weak self] res in
            guard let nickname = self?.viewModel.outputNicknameResult.value else { return }
            if res && nickname {
                // MBTI 성공
                self?.profileView.doneButton.isEnabled = true
            } else {
                // MBTI 실패
                self?.profileView.doneButton.isEnabled = false
            }
        }
        
        // 유저 가입 완료
        viewModel.outputUserAccountResult.bind { [weak self] res in
            if !res { return }
            self?.showAlert(
                title: UserDefaultsManager.getWelcomeMessage(),
                message: Constants.Alert.Welcome.message,
                buttonType: .oneButton,
                okHandler: { [weak self] _ in
                    self?.changeRootViewController()
                }
            )
        }
    }
    
    override func configureViewController() {
        super.configureViewController()
        navigationItem.title = Constants.Title.profileSetting
        setImgBarButton(image: Resource.SystemImage.left, target: self, action: #selector(popViewController), type: .left)
    }
    
    private func configureHandler() {
        // 배경 탭
        let backgroundTap = UITapGestureRecognizer(target: self, action: #selector(keyboardDismiss))
        view.addGestureRecognizer(backgroundTap)
        
        // 프로필 이미지 탭
        let profileTap =  UITapGestureRecognizer(target: self, action: #selector(profileImageClicked))
        profileView.profileImageView.addGestureRecognizer(profileTap)
        
        // 닉네임 텍스트필드 입력
        profileView.nicknameField.addTarget(self, action: #selector(nicknameFieldEditing), for: .editingChanged)
        
        // MBTI 버튼 클릭
        profileView.mbtiButtons.forEach {
            $0.addTarget(self, action: #selector(mbtiButtonClicked), for: .touchUpInside)
        }
        // 완료 버튼 클릭
        profileView.doneButton.addTarget(self, action: #selector(doneButtonClicked), for: .touchUpInside)
    }
    
    @objc private func profileImageClicked() {
        let profileImageVC = ProfileImageViewController()
        navigationController?.pushViewController(profileImageVC, animated: true)
    }
    
    @objc private func nicknameFieldEditing() {
        viewModel.inputNicknameTextField.value = profileView.nicknameField.text
    }
    
    @objc private func mbtiButtonClicked(_ sender: MBTIButtton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            viewModel.inputActiveMBTIButton.value = sender.titleLabel?.text
        } else {
            viewModel.inputInactiveMBTIButton.value = sender.titleLabel?.text
        }
    }
    
    @objc private func doneButtonClicked() {
        // print(#function)
        viewModel.inputDoneButton.value = ()
    }
}
