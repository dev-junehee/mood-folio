//
//  BaseViewController.swift
//  mood-folio
//
//  Created by junehee on 7/22/24.
//

import UIKit

class BaseViewController: UIViewController, Base {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureHierarchy()
        configureLayout()
        configureUI()
        
        if !NetworkMonitorManager.shared.isConnected {
            showAlert(title: Constants.Alert.NetworkFail.title, message: Constants.Alert.NetworkFail.message, buttonType: .twoButton) { _ in
                // 설정으로 연결
                guard let setting = URL(string: UIApplication.openSettingsURLString) else { return }
                if UIApplication.shared.canOpenURL(setting) {
                    UIApplication.shared.open(setting, options: [:], completionHandler: nil)
                }
            }
            return
        }
    }
    
    func configureViewController() {
        view.backgroundColor = Resource.Color.white
    }
    
    func configureHierarchy() { }
    
    func configureLayout() { }
    
    func configureUI() { }
    
}
