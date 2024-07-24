//
//  DetailView.swift
//  mood-folio
//
//  Created by junehee on 7/25/24.
//

import UIKit

import Kingfisher
import SnapKit

final class DetailView: BaseView {
    
    private let userProfileImage = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        return view
    }()
    
    private lazy var userInfoStack = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.addArrangedSubview(userNameLabel)
        stack.addArrangedSubview(createDateLabel)
        return stack
    }()
    
    private let userNameLabel = {
        let label = UILabel()
        label.text = "Kim JuneHee"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    private let createDateLabel = {
        let label = UILabel()
        label.text = "2024년 7월 3일 게시됨"
        label.font = .systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    private let heartButton = {
        let button = UIImageView()
        button.image = Resource.SystemImage.heart
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    private let mainPhotoImage = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.backgroundColor = .green
        return view
    }()
    
    private let photoInfoLabel = {
        let label = UILabel()
        label.text = "정보"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private lazy var photoInfoStack = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.addArrangedSubview(sizeStack)
        stack.addArrangedSubview(viewStack)
        stack.addArrangedSubview(downloadStack)
        return stack
    }()
    
    // 정보 - 크기
    private lazy var sizeStack = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.addArrangedSubview(sizeLabel)
        stack.addArrangedSubview(sizeDataLabel)
        return stack
    }()
    
    private let sizeLabel = {
        let label = UILabel()
        label.text = "크기"
        label.font = .systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    private let sizeDataLabel = {
        let label = UILabel()
        label.text = "3098 x 3872"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    // 정보 - 조회수
    private lazy var viewStack = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.addArrangedSubview(viewLabel)
        stack.addArrangedSubview(viewDataLabel)
        return stack
    }()
    
    private let viewLabel = {
        let label = UILabel()
        label.text = "조회수"
        label.font = .systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    private let viewDataLabel = {
        let label = UILabel()
        label.text = "1,548,623"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    // 정보 - 다운로드
    private lazy var downloadStack = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.addArrangedSubview(downloadLabel)
        stack.addArrangedSubview(downloadDataLabel)
        return stack
    }()
    
    private let downloadLabel = {
        let label = UILabel()
        label.text = "다운로드"
        label.font = .systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    private let downloadDataLabel = {
        let label = UILabel()
        label.text = "388,996"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    override func configureHierarchy() {
        let views = [
            userProfileImage, userInfoStack, heartButton,
            mainPhotoImage, photoInfoLabel, photoInfoStack
        ]
        views.forEach { self.addSubview($0) }
    }
    
    override func configureLayout() {
        userProfileImage.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(8)
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(16)
            $0.size.equalTo(40)
        }
        userProfileImage.backgroundColor = .red
        
        userInfoStack.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(8)
            $0.leading.equalTo(userProfileImage.snp.trailing).offset(8)
            $0.trailing.equalTo(heartButton.snp.leading)
            $0.height.equalTo(40)
        }
        userInfoStack.backgroundColor = .yellow
        
        heartButton.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(8)
            $0.trailing.equalTo(self.safeAreaLayoutGuide).inset(16)
            $0.size.equalTo(40)
        }
        heartButton.backgroundColor = .lightGray
        
        mainPhotoImage.snp.makeConstraints {
            $0.top.equalTo(userProfileImage.snp.bottom).offset(16)
            $0.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            $0.height.equalTo(200)
        }
        
        photoInfoLabel.snp.makeConstraints {
            $0.top.equalTo(mainPhotoImage.snp.bottom).offset(16)
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(16)
            $0.width.equalTo(80)
        }
        photoInfoLabel.backgroundColor = .yellow
        
        photoInfoStack.snp.makeConstraints {
            $0.top.equalTo(mainPhotoImage.snp.bottom).offset(16)
            $0.leading.equalTo(photoInfoLabel.snp.trailing)
            $0.trailing.equalTo(self.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(80)
        }
        photoInfoStack.backgroundColor = .lightGray
    }
    
    func updateUI(data: Topic?) {
        guard let data else { return }
        userProfileImage.kf.setImage(with: URL(string: data.user.profile_image.medium))
        userNameLabel.text = data.user.name
        createDateLabel.text = data.create_at
    }
    
}

