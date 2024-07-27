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
    
    private let repo = LikePhotoRepository()
    
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
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    private let createDateLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    let heartButton = {
        let button = UIButton()
        // let image = UIImage(resource: .like)
        // button.setImage(image, for: .normal)
        return button
    }()
    
    private let mainPhotoImage = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private let photoInfoLabel = {
        let label = UILabel()
        label.text = Constants.Detail.info
        label.font = Resource.Font.bold18
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
        label.text = Constants.Detail.size
        label.font = Resource.Font.bold14
        return label
    }()
    
    private let sizeDataLabel = {
        let label = UILabel()
        label.font = Resource.Font.regular14
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
        label.text = Constants.Detail.view
        label.font = Resource.Font.bold14
        return label
    }()
    
    private let viewDataLabel = {
        let label = UILabel()
        label.font = Resource.Font.regular14
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
        label.text = Constants.Detail.download
        label.font = Resource.Font.bold14
        return label
    }()
    
    private let downloadDataLabel = {
        let label = UILabel()
        label.font = Resource.Font.regular14
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
        
        userInfoStack.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(8)
            $0.leading.equalTo(userProfileImage.snp.trailing).offset(8)
            $0.trailing.equalTo(heartButton.snp.leading)
            $0.height.equalTo(40)
        }
        
        heartButton.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(8)
            $0.trailing.equalTo(self.safeAreaLayoutGuide).inset(16)
            $0.size.equalTo(40)
        }
        
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
        
        photoInfoStack.snp.makeConstraints {
            $0.top.equalTo(mainPhotoImage.snp.bottom).offset(16)
            $0.leading.equalTo(photoInfoLabel.snp.trailing)
            $0.trailing.equalTo(self.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(80)
        }
    }
    
    func updateUI(data: Photo?) {
        guard let data else { return }
        userProfileImage.kf.setImage(with: URL(string: data.user.profile_image.medium))
        userNameLabel.text = data.user.name
//        createDateLabel.text = "\(data.create_at)"
        sizeDataLabel.text = "\(data.width) x \(data.height)"
        mainPhotoImage.kf.setImage(with: URL(string: data.urls.small))
        
        updateHeartButtonUI(id: data.id)
    }
    
    func updateLikePhotoUI(data: LikePhoto) {
        userProfileImage.kf.setImage(with: URL(string: data.userProfileImage))
        userNameLabel.text = data.userName
        // createDateLabel.text = "\(data.create_at)"
        sizeDataLabel.text = "\(data.width) x \(data.height)"
        mainPhotoImage.kf.setImage(with: URL(string: data.urlSmall))
        
        updateHeartButtonUI(id: data.id)
    }
    
    func updateHeartButtonUI(id: String) {
        let isLikePhoto = repo.isLikePhoto(id: id)
        let buttonImage = isLikePhoto ? Resource.Image.like : Resource.Image.likeInactive
        let buttonColor = isLikePhoto ? Resource.Color.primary : Resource.Color.whiteSmoke
        
        heartButton.setImage(buttonImage, for: .normal)
        heartButton.tintColor = buttonColor
    }
    
    func updateDetailUI(data: Statistics?) {
        guard let data else { return }
        viewDataLabel.text = data.views.total.formatted()
        downloadDataLabel.text = data.downloads.total.formatted()
        
        // 임시 날짜 바인딩
        if let value = data.downloads.historical.values.first {
            let date = value.date.split(separator: "-")
            createDateLabel.text = "\(date[0])년 \(date[1])월 \(date[2])일"
        }
    }
    
}

