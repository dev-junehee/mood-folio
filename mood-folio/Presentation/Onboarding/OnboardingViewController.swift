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
        return view
    }()
    
    private let polaroidImage = {
        let view = UIImageView()
        view.image = UIImage.launchPolaroid
        return view
    }()
    
    private let startButton = {
        let button = CommonButton(title: Constants.Button.start)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func configureHierarchy() {
        let views = [titleImage, polaroidImage, startButton]
        views.forEach { view.addSubview($0) }
    }
    
    override func configureLayout() {
        titleImage.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(100)
        }
        
        polaroidImage.snp.makeConstraints {
            $0.top.equalTo(titleImage.snp.bottom).offset(50)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
        
        startButton.snp.makeConstraints {
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(50)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
    }
}
