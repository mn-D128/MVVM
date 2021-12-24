//
//  Reactive+WKWebView.swift
//  RxSwiftSample
//
//  Created by Masanori Nakano on 2021/12/25.
//

import Foundation
import RxSwift
import WebKit

extension Reactive where Base: WKWebView {
    func load() -> Binder<URLRequest> {
        Binder(self.base) { target, value in
            target.load(value)
        }
    }
}
