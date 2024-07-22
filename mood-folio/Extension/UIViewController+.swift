//
//  UIViewController.swift
//  mood-folio
//
//  Created by junehee on 7/22/24.
//

import UIKit

extension UIViewController {
    // 여러 뷰컨에서 공통적으로 많이 사용하는 핸들러
    @objc func keyboardDismiss() {
        view.endEditing(true)
    }
    
    @objc func popViewController() {
        navigationController?.popViewController(animated: true)
    }
}
