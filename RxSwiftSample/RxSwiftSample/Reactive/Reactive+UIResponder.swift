//
//  Reactive+UIResponder.swift
//  RxSwiftSample
//
//  Created by Masanori Nakano on 2021/12/25.
//

import Foundation
import RxSwift

extension Reactive where Base: UIResponder {
    func becomeFirstResponder() -> Binder<Void> {
        Binder(self.base) { responder, _ in
            responder.becomeFirstResponder()
        }
    }
}
