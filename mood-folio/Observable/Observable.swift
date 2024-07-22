//
//  Observable.swift
//  mood-folio
//
//  Created by junehee on 7/22/24.
//

import Foundation

final class Observable<T> {
    
    var closure: ((T) -> Void)?
    
    var value: T {
        didSet {
            closure?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(closure: @escaping (T) -> Void, immediatelyRun: Bool = false) {
        if immediatelyRun {
            closure(value)
        }
        self.closure = closure
    }
    
}
