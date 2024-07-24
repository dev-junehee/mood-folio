//
//  OnboardingView.swift
//  mood-folio
//
//  Created by junehee on 7/24/24.
//

import UIKit
import SnapKit

final class OnboardingView: BaseView {
    
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
        label.font = Resource.Font.black20
        return label
    }()
    
    let startButton = {
        let button = CommonButton(title: Constants.Button.start)
        return button
    }()
    
    override func configureHierarchy() {
        let views = [titleImage, polaroidImage, startButton, nameLabel]
        views.forEach { self.addSubview($0) }
    }
    
    override func configureLayout() {
        titleImage.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.centerX.equalTo(self.safeAreaLayoutGuide)
            $0.width.equalTo(320)
            $0.height.equalTo(120)
        }
        
        polaroidImage.snp.makeConstraints {
            $0.top.equalTo(titleImage.snp.bottom).offset(16)
            $0.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            $0.height.equalTo(400)
        }
        
        startButton.snp.makeConstraints {
            $0.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(50)
            $0.bottom.equalTo(self.safeAreaLayoutGuide).inset(16)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(polaroidImage.snp.bottom).offset(16)
            $0.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            $0.height.equalTo(24)
        }
    }
}
