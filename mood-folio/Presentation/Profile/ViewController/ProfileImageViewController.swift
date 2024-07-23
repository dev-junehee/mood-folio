//
//  ProfileImageViewController.swift
//  mood-folio
//
//  Created by junehee on 7/23/24.
//

import Foundation

final class ProfileImageViewController: BaseViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureViewController() {
        super.configureViewController()
        navigationItem.title = Constants.NavigationTitle.ProfileSetting
        setImgBarButton(image: Resource.SystemImage.left, target: self, action: #selector(popViewController), type: .left)
    }
    
}
