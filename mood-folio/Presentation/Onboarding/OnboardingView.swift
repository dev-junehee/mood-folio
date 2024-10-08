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
    
    let startButton = {
        let button = CommonButton(title: Constants.Button.start)
        return button
    }()
    
    override func configureHierarchy() {
        let views = [titleImage, polaroidImage, startButton]
        views.forEach { self.addSubview($0) }
    }
    
    override func configureLayout() {
        let safeArea = self.safeAreaLayoutGuide
        
        titleImage.snp.makeConstraints {
            $0.top.equalTo(safeArea)
            $0.centerX.equalTo(safeArea)
            $0.width.equalTo(320)
            $0.height.equalTo(120)
        }
        
        polaroidImage.snp.makeConstraints {
            $0.top.equalTo(titleImage.snp.bottom).offset(16)
            $0.horizontalEdges.equalTo(safeArea)
            $0.height.equalTo(400)
        }
        
        startButton.snp.makeConstraints {
            $0.horizontalEdges.equalTo(safeArea).inset(16)
            $0.height.equalTo(50)
            $0.bottom.equalTo(safeArea).inset(16)
        }
    }
    
}
