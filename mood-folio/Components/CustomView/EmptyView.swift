//
//  EmptyView.swift
//  mood-folio
//
//  Created by junehee on 7/25/24.
//

import UIKit
import SnapKit

final class EmptyView: BaseView {
    
    private let emptyLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    var emptyText: String? {
        didSet {
            emptyLabel.text = emptyText
        }
    }
    
    override func configureHierarchy() {
        addSubview(emptyLabel)
    }
    
    override func configureLayout() {
        emptyLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
}
