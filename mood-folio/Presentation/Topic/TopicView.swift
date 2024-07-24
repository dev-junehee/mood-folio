//
//  TopicView.swift
//  mood-folio
//
//  Created by junehee on 7/24/24.
//

import UIKit
import SnapKit

final class TopicView: BaseView {

    private let titleLabel = {
        let label = UILabel()
        label.text = "OUR TOPIC"
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        return label
    }()
    
    override func configureHierarchy() {
        self.addSubview(titleLabel)
    }
    
    override func configureLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(50)
        }
    }
    
}
