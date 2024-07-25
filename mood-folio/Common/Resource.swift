//
//  Resource.swift
//  mood-folio
//
//  Created by junehee on 7/22/24.
//

import UIKit

/**
 Color: 프로젝트에서 사용하는 색상
 Fonts: 프로젝트에서 사용하는 폰트 사이즈
 */

enum Resource {
    enum Color {
        static let primary: UIColor = .init(rgb: 0x186ff2)
        static let pink: UIColor = .init(rgb: 0xF04452)
        static let yellow: UIColor = .systemYellow
        static let white: UIColor = .init(rgb: 0xFFFFFF)
        static let whiteSmoke: UIColor = .init(rgb: 0xF2F2F2)
        static let lightGray: UIColor = .init(rgb: 0x8C8C8C)
        static let gray: UIColor = .init(rgb: 0x4D5652)
        static let black: UIColor = .init(rgb: 0x000000)
    }
    
    enum Font {
        static let regular13: UIFont = .systemFont(ofSize: 13, weight: .regular)
        static let bold14: UIFont = .systemFont(ofSize: 14, weight: .bold)
        static let bold16: UIFont = .systemFont(ofSize: 16, weight: .bold)
        static let black20: UIFont = .systemFont(ofSize: 20, weight: .black)
        static let button: UIFont = .systemFont(ofSize: 16, weight: .black)
    }
    
    enum Image {
        static let profileImages: [UIImage] = [
            .profile0, .profile1, .profile2, .profile3,
            .profile4, .profile5, .profile6, .profile7,
            .profile8, .profile9, .profile10, .profile11,
        ]
    }
    
    enum SystemImage {
        static let camera = UIImage(systemName: "camera.fill")!
        static let left = UIImage(systemName: "chevron.left")!
        static let star = UIImage(systemName: "star.fill")!
        static let heart = UIImage(systemName: "heart")!
        static let heartFill = UIImage(systemName: "heart.fill")!
        static let questionmark = UIImage(systemName: "questionmark.circle")!
        
        static let tabBarImages = ["chart.line.uptrend.xyaxis", "play.square", "magnifyingglass", "heart"]
    }
}
