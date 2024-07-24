//
//  OnboardingViewController.swift
//  mood-folio
//
//  Created by junehee on 7/22/24.
//

import Foundation

final class OnboardingViewController: BaseViewController {
    
    private let onboardingView = OnboardingView()
    
    override func loadView() {
        view = onboardingView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHandler()
    }
    
    private func configureHandler() {
        onboardingView.startButton.addTarget(self, action: #selector(startButtonClicked), for: .touchUpInside)
    }
    
    @objc private func startButtonClicked() {
        let profileVC = ProfileViewController()
        navigationController?.pushViewController(profileVC, animated: true)
    }
}
