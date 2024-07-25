//
//  DetailViewController.swift
//  mood-folio
//
//  Created by junehee on 7/25/24.
//

import UIKit

final class DetailViewController: BaseViewController {
    
    private let detailView = DetailView()
    let viewModel = DetailViewModel()
        
    override func loadView() {
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHandler()
        bindData()
        viewModel.inputViewDidLoad.value = ()
    }
    
    private func bindData() {
        viewModel.outputStatisticsData.bind { [weak self] data in
            self?.detailView.updateUI(data: self?.viewModel.inputPhotoData.value)
            self?.detailView.updateDetailUI(data: data)
        }
    }
    
    override func configureViewController() {
        super.configureViewController()
        setImgBarButton(image: Resource.SystemImage.left, target: self, action: #selector(popViewController), type: .left)
    }
    
    private func configureHandler() {
        detailView.heartButton.addTarget(self, action: #selector(heartButtonClicked), for: .touchUpInside)
    }
    
    @objc private func heartButtonClicked() {
        print(#function)
        // 사진 좋아요 기능 연결 예정
    }
    
}
