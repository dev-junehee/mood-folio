//
//  EditProfileViewController.swift
//  mood-folio
//
//  Created by junehee on 7/24/24.
//

import Foundation

final class EditProfileViewController: BaseViewController {
    
    override func configureViewController() {
        navigationItem.title = "EDIT PROFILE"
        setImgBarButton(image: Resource.SystemImage.left, target: self, action: #selector(popViewController), type: .left)
    }
    
}
