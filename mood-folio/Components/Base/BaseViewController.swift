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
    }
    
    func configureViewController() {
        view.backgroundColor = Resource.Color.white
    }
    
    func configureHierarchy() { }
    
    func configureLayout() { }
    
    func configureUI() { }
    
}
