//
//  OnboardingViewController.swift
//  mood-folio
//
//  Created by junehee on 7/22/24.
//

import UIKit
import SnapKit

final class OnboardingViewController: BaseViewController {
    
    private let titleImage = {
        let view = UIImageView()
        view.image = UIImage.launchTitle
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private let polaroidImage = {
        let view = UIImageView()
        view.image = UIImage.launchPolaroid
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private let nameLabel = {
        let label = UILabel()
        label.text = "김준희"
        label.textAlignment = .center
        label.font = Resource.Fonts.black20
        return label
    }()
    
    private lazy var startButton = {
        let button = CommonButton(title: Constants.Button.start)
        button.addTarget(self, action: #selector(startButtonClicked), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func configureHierarchy() {
        let views = [titleImage, polaroidImage, startButton, nameLabel]
        views.forEach { view.addSubview($0) }
    }
    
    override func configureLayout() {
        titleImage.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(32)
            $0.width.equalTo(320)
            $0.height.equalTo(120)
        }
        
        polaroidImage.snp.makeConstraints {
            $0.top.equalTo(titleImage.snp.bottom).offset(16)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(400)
        }
        
        startButton.snp.makeConstraints {
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(50)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(polaroidImage.snp.bottom).offset(16)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(24)
        }
    }
    
    @objc private func startButtonClicked() {
        let profileVC = ProfileViewController()
        navigationController?.pushViewController(profileVC, animated: true)
    }
}
