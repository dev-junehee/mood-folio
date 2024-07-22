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
    enum Colors {
        static let primary: UIColor = .init(rgb: 0x186ff2)
        static let pink: UIColor = .init(rgb: 0xF04452)
        static let white: UIColor = .init(rgb: 0xFFFFFF)
        static let whiteSmoke: UIColor = .init(rgb: 0xF2F2F2)
        static let lightGray: UIColor = .init(rgb: 0x8C8C8C)
        static let gray: UIColor = .init(rgb: 0x4D5652)
        static let black: UIColor = .init(rgb: 0x000000)
    }
    
    enum Fonts {
//        static let bold20: UIFont = .systemFont(ofSize: 20, weight: .bold)
        static let black20: UIFont = .systemFont(ofSize: 20, weight: .black)
        static let button: UIFont = .systemFont(ofSize: 16, weight: .black)
    }
}
