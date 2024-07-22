//
//  ProfileViewController.swift
//  mood-folio
//
//  Created by junehee on 7/22/24.
//

import UIKit
import TextFieldEffects

final class ProfileViewController: BaseViewController {
    
    let mainView = ProfileView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundTapped()
        configureHandler()
    }
    
    override func configureViewController() {
        super.configureViewController()
        navigationItem.title = Constants.NavigationTitle.ProfileSetting
    }
    
    private func configureHandler() {
        mainView.nicknameField.addTarget(self, action: #selector(nicknameFieldEditing), for: .editingChanged)
        mainView.doneButton.addTarget(self, action: #selector(doneButtonClicked), for: .touchUpInside)
    }
    
    private func backgroundTapped() {
        let tapped = UITapGestureRecognizer(target: self, action: #selector(keyboardDismiss))
        view.addGestureRecognizer(tapped)
    }
    
    @objc private func nicknameFieldEditing() {
        print(#function)
        print(mainView.nicknameField.text)
    }
    
    @objc private func doneButtonClicked() {
        print(#function)
    }
}

