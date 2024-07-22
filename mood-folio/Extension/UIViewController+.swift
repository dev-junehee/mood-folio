//
//  UIViewController.swift
//  mood-folio
//
//  Created by junehee on 7/22/24.
//

import UIKit

enum BarButtonPosition {
    case left
    case right
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
    
    // 여러 뷰컨에서 공통적으로 많이 사용하는 핸들러
    @objc func keyboardDismiss() {
        view.endEditing(true)
    }
    
    @objc func popViewController() {
        navigationController?.popViewController(animated: true)
    }
}
