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
    
    let profileImageView = {
        let view = UIView()
        return view
    }()
    
    let profileImage = {
        let view = UIImageView()
        view.backgroundColor = Resource.Color.white
        view.clipsToBounds = true
        view.layer.cornerRadius = 50
        view.layer.borderColor = Resource.Color.primary.cgColor
        view.layer.borderWidth = Constants.Integer.borderWidth
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
    
    private let mbtiLabel = {
        let view = UILabel()
        view.text = Constants.Profile.mbti
        view.font = Resource.Font.bold16
        return view
    }()

    private lazy var mbtiESTJBox = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .equalSpacing
        let mbtiButtons = [mbtiButtonE, mbtiButtonS, mbtiButtonT, mbtiButtonJ]
        mbtiButtons.forEach { view.addArrangedSubview($0) }
        return view
    }()
    
    private lazy var mbtiINFPBox = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .equalSpacing
        let mbtiButtons = [mbtiButtonI, mbtiButtonN, mbtiButtonF, mbtiButtonP]
        mbtiButtons.forEach { view.addArrangedSubview($0) }
        return view
    }()
    
    let mbtiButtonE = {
        let button = MBTIButtton(title: "E")
        return button
    }()
    
    let mbtiButtonS = {
        let button = MBTIButtton(title: "S")
        return button
    }()
    
    let mbtiButtonT = {
        let button = MBTIButtton(title: "T")
        return button
    }()
    
    let mbtiButtonJ = {
        let button = MBTIButtton(title: "J")
        return button
    }()
    
    let mbtiButtonI = {
        let button = MBTIButtton(title: "I")
        return button
    }()
    
    let mbtiButtonN = {
        let button = MBTIButtton(title: "N")
        return button
    }()
    
    let mbtiButtonF = {
        let button = MBTIButtton(title: "F")
        return button
    }()
    
    let mbtiButtonP = {
        let button = MBTIButtton(title: "P")
        return button
    }()
    
    let doneButton = {
        let button = CommonButton(title: Constants.Button.done, isEnabled: false)
        return button
    }()
    
    let deleteAccountButton = {
        let button = UIButton()
        button.setTitle(Constants.Button.cancelation, for: .normal)
        button.setTitleColor(Resource.Color.primary, for: .normal)
        button.titleLabel?.font = Resource.Font.regular13
        button.setUnderline()
        return button
    }()
    
    lazy var mbtiButtons = [
        mbtiButtonE, mbtiButtonS, mbtiButtonT, mbtiButtonJ,
        mbtiButtonI, mbtiButtonN, mbtiButtonF, mbtiButtonP,
    ]
    
    var isEditing = false {
        didSet {
            doneButton.isHidden = isEditing
            deleteAccountButton.isHidden = !isEditing
        }
    }
    
    override func configureHierarchy() {
        cameraImageView.addSubview(cameraImage)
        profileImageView.addSubview(profileImage)
        profileImageView.addSubview(cameraImageView)
        
        let subviews = [
            profileImageView, nicknameField, invalidMessage,
            mbtiLabel, mbtiESTJBox, mbtiESTJBox, mbtiINFPBox,
            doneButton, deleteAccountButton
        ]
        subviews.forEach { self.addSubview($0) }
    }
    
    override func configureLayout() {
        let safeArea = self.safeAreaLayoutGuide
        
        profileImageView.snp.makeConstraints {
            $0.top.equalTo(safeArea).inset(16)
            $0.size.equalTo(100)
            $0.centerX.equalTo(safeArea)
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
            $0.horizontalEdges.equalTo(safeArea).inset(24)
            $0.height.equalTo(50)
        }
        
        invalidMessage.snp.makeConstraints {
            $0.top.equalTo(nicknameField.snp.bottom).offset(8)
            $0.horizontalEdges.equalTo(safeArea).inset(24)
            $0.height.equalTo(30)
        }
        
        mbtiLabel.snp.makeConstraints {
            $0.top.equalTo(invalidMessage.snp.bottom).offset(32)
            $0.leading.equalTo(safeArea).offset(24)
            $0.width.equalTo(50)
        }
        
        mbtiESTJBox.snp.makeConstraints {
            $0.top.equalTo(invalidMessage.snp.bottom).offset(32)
            $0.trailing.equalTo(safeArea).inset(24)
            $0.width.equalTo(220)
            $0.height.equalTo(50)
        }
        
        mbtiINFPBox.snp.makeConstraints {
            $0.top.equalTo(mbtiESTJBox.snp.bottom).offset(8)
            $0.trailing.equalTo(safeArea).inset(24)
            $0.width.equalTo(220)
            $0.height.equalTo(50)
        }
        
        doneButton.snp.makeConstraints {
            $0.horizontalEdges.equalTo(safeArea).inset(16)
            $0.height.equalTo(50)
            $0.bottom.equalTo(safeArea).inset(16)
        }
        
        deleteAccountButton.snp.makeConstraints {
            $0.horizontalEdges.equalTo(safeArea).inset(16)
            $0.height.equalTo(50)
            $0.bottom.equalTo(safeArea).inset(16)
        }
    }
    
}
