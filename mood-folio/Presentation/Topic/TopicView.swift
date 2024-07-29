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
        label.text = Constants.Title.topic
        label.font = Resource.Font.bold32
        return label
    }()
    
    let tableView = {
        let view = UITableView()
        view.separatorStyle = .none
        return view
    }()
    
    override func configureHierarchy() {
        let views = [titleLabel, tableView]
        views.forEach { self.addSubview($0) }
    }
    
    override func configureLayout() {
        let safeArea = self.safeAreaLayoutGuide
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(safeArea)
            $0.horizontalEdges.equalTo(safeArea).inset(16)
            $0.height.equalTo(50)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.horizontalEdges.bottom.equalTo(safeArea)
        }
    }
    
}
