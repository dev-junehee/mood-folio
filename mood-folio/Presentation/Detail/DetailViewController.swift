//
//  DetailViewController.swift
//  mood-folio
//
//  Created by junehee on 7/25/24.
//

import UIKit

enum DetailType {
    case photo
    case likePhoto
}

final class DetailViewController: BaseViewController {
    
    private let detailView = DetailView()
    let viewModel = DetailViewModel()
    
    var detailType: DetailType = .photo
        
    override func loadView() {
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHandler()
        bindData()
        viewModel.inputViewDidLoad.value = detailType
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.inputViewWillAppear.value = detailType
    }
    
    
    private func bindData() {
        viewModel.outputViewWillAppear.bind { [weak self] id in
            self?.detailView.updateHeartButtonUI(id: id)   // 찜 화면에서 삭제했을 때 버튼 UI 업데이트
        }
        viewModel.outputStatisticsData.bind { [weak self] data in
            self?.detailView.updateUI(data: self?.viewModel.inputPhotoData.value)
            self?.detailView.updateLikePhotoUI(data: self?.viewModel.inputLikePhotoData.value)
            self?.detailView.updateDetailUI(data: data)
        }
        
        viewModel.outputCreateLikePhotoTrigger.bind { [weak self] _ in
            self?.detailView.updateHeartButtonUI(id: self?.viewModel.inputPhotoData.value?.id ?? "")
        }
        
        viewModel.outputDeleteLikePhotoTrigger.bind { [weak self] _ in
            self?.detailView.updateHeartButtonUI(id: self?.viewModel.inputPhotoData.value?.id ?? "")
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
        viewModel.inputHeartButton.value = detailType
        viewModel.inputSaveImage.value = detailView.mainPhotoImage.image
    }
    
}
