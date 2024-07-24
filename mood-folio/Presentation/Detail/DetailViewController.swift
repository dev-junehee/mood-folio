//
//  DetailViewController.swift
//  mood-folio
//
//  Created by junehee on 7/25/24.
//

import Foundation

final class DetailViewController: BaseViewController {
    
    private let detailView = DetailView()
    private let viewModel = DetailViewModel()
    
    var detailData: Topic?
    
    override func loadView() {
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindData()
        
    }
    
    private func bindData() {
        viewModel.outputTrigger.bind { [weak self] _ in
            self?.detailView.updateUI(data: self?.detailData)
        }
    }
    
    override func configureViewController() {
        super.configureViewController()
        setImgBarButton(image: Resource.SystemImage.left, target: self, action: #selector(popViewController), type: .left)
    }
    
}
