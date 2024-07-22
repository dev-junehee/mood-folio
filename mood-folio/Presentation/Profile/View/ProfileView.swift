//
//  ProfileView.swift
//  mood-folio
//
//  Created by junehee on 7/22/24.
//

import UIKit

import SnapKit
import TextFieldEffects

final class ProfileView: BaseView {
    
    private let profileImageView = {
        let view = UIView()
        return view
    }()
    
    let profileImage = {
        let view = UIImageView()
        view.backgroundColor = Resource.Color.white
        view.clipsToBounds = true
        view.layer.cornerRadius = 50
        view.layer.borderColor = Resource.Color.primary.cgColor
        view.layer.borderWidth = CGFloat(Constants.Integer.borderWidth)
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private let cameraImageView = {
        let view = UIView()
        view.backgroundColor = Resource.Color.primary
        view.layer.cornerRadius = 12
        return view
    }()
    
    private let cameraImage = {
        let view = UIImageView()
        view.image = Resource.SystemImage.camera
        view.contentMode = .scaleAspectFit
        view.tintColor = Resource.Color.white
        return view
    }()
    
    lazy var nicknameField = {
        let view = HoshiTextField()
        view.setTextFieldUI(Constants.Placeholder.nickname)
        view.returnKeyType = .done
        view.addTarget(self, action: #selector(keyboardDismiss), for: .editingDidEndOnExit)
        return view
    }()
    
    let invalidMessage = {
        let view = UILabel()
        view.textColor = Resource.Color.pink
        view.font = Resource.Font.regular13
        return view
    }()
    
    let doneButton = {
        let button = CommonButton(title: Constants.Button.done)
        button.isEnabled = false
        return button
    }()
    
    override func configureHierarchy() {
        cameraImageView.addSubview(cameraImage)
        profileImageView.addSubview(profileImage)
        profileImageView.addSubview(cameraImageView)
        
        let subviews = [profileImageView, nicknameField, invalidMessage, doneButton]
        subviews.forEach { self.addSubview($0) }
    }
    
    override func configureLayout() {
        profileImageView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).inset(16)
            $0.size.equalTo(100)
            $0.centerX.equalTo(self.safeAreaLayoutGuide)
        }
        
        profileImage.snp.makeConstraints {
            $0.top.bottom.equalTo(profileImageView)
            $0.size.equalTo(profileImageView)
            $0.centerX.equalTo(profileImageView)
        }
        
        cameraImageView.snp.makeConstraints {
            $0.trailing.equalTo(profileImage)
            $0.bottom.equalTo(profileImage).inset(8)
            $0.size.equalTo(24)
        }
        
        cameraImage.snp.makeConstraints {
            $0.center.equalTo(cameraImageView)
            $0.size.equalTo(15)
        }
        
        nicknameField.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(24)
            $0.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(24)
            $0.height.equalTo(50)
        }
        
        invalidMessage.snp.makeConstraints {
            $0.top.equalTo(nicknameField.snp.bottom).offset(8)
            $0.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(24)
            $0.height.equalTo(30)
        }
        
        doneButton.snp.makeConstraints {
            $0.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(50)
            $0.bottom.equalTo(self.safeAreaLayoutGuide).inset(16)
        }
    }
    
}
