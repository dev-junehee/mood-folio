//
//  UIViewController.swift
//  mood-folio
//
//  Created by junehee on 7/22/24.
//

import UIKit
import Toast

enum BarButtonPosition {
    case left
    case right
}

enum AlertButtonType {
    case oneButton
    case twoButton
}

enum ToastType {
    case createPhoto
    case deletePhoto
    case custom
}

extension UIViewController {
    // Navigation Bar Button Setting
    func setTextBarButtoon(title: String?, target: Any?, action: Selector?, type: BarButtonPosition) {
        let barButton = UIBarButtonItem(title: title, style: .plain, target: target, action: action)
        
        barButton.tintColor = Resource.Color.gray
        
        switch type {
        case .left:
            navigationItem.leftBarButtonItem = barButton
        case .right:
            navigationItem.rightBarButtonItem = barButton
        }
    }
    
    func setImgBarButton(image: UIImage, target: Any?, action: Selector?, type: BarButtonPosition) {
        let barButton = UIBarButtonItem(image: image, style: .plain, target: target, action: action)
        
        barButton.tintColor = Resource.Color.gray
        
        switch type {
        case .left:
            navigationItem.leftBarButtonItem = barButton
        case .right:
            navigationItem.rightBarButtonItem = barButton
        }
    }
    
    // RootViewController - TabBar 변경
    func changeRootViewController() {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDeleagate = windowScene?.delegate as? SceneDelegate
        
        var rootViewController: UIViewController?
        
        let tabBarController = UITabBarController()
        tabBarController.view.backgroundColor = Resource.Color.white
        tabBarController.tabBar.tintColor = Resource.Color.black
        
        let topic = UINavigationController(rootViewController: TopicViewController())
        let random = UINavigationController(rootViewController: RandomViewController())
        let search = UINavigationController(rootViewController: SearchViewController())
        let like = UINavigationController(rootViewController: LikeViewController())
        
        let viewControllers = [topic, random, search, like]
        tabBarController.setViewControllers(viewControllers, animated: true)
        
        if let items = tabBarController.tabBar.items {
            for i in 0..<items.count {
                items[i].image = Resource.SystemImage.tabBarImages[i]
            }
        }
        
        rootViewController = tabBarController
            
        sceneDeleagate?.window?.rootViewController = rootViewController
        sceneDeleagate?.window?.makeKeyAndVisible()
    }
    
    // RootViewController - Onboarding 변경
    func changeRootViewControllerToOnboarding() {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDeleagate = windowScene?.delegate as? SceneDelegate
        
        let onboardingVC = UINavigationController(rootViewController: OnboardingViewController())
        sceneDeleagate?.window?.rootViewController = onboardingVC
        sceneDeleagate?.window?.makeKeyAndVisible()
    }
    
    // Alert
    func showAlert(title: String?, message: String? = nil, buttonType: AlertButtonType, okHandler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)
        
        switch buttonType {
        case .oneButton:
            let okay = UIAlertAction(title: Constants.Button.okay, style: .default, handler: okHandler)
            alert.addAction(okay)
        case .twoButton:
            let okay = UIAlertAction(title: Constants.Button.okay, style: .default, handler: okHandler)
            let cancel = UIAlertAction(title: Constants.Button.cancel, style: .cancel)
            alert.addAction(okay)
            alert.addAction(cancel)
        }
        
        present(alert, animated: true)
    }
    
    // Toast
    func showToast(type: ToastType, message: String? = nil) {
        switch type {
        case .createPhoto:
            view.makeToast(Constants.Toast.createPhoto)
        case .deletePhoto:
            view.makeToast(Constants.Toast.deletePhoto)
        case .custom:
            view.makeToast(message)
        }
        
    }
    
    // 여러 뷰컨에서 공통적으로 많이 사용하는 핸들러
    @objc func keyboardDismiss() {
        view.endEditing(true)
    }
    
    @objc func popViewController() {
        navigationController?.popViewController(animated: true)
    }
}
