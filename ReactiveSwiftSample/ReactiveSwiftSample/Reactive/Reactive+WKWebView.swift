//
//  Reactive+WKWebView.swift
//  ReactiveSwiftSample
//
//  Created by Masanori Nakano on 2021/12/22.
//

import Foundation
import ReactiveSwift
import WebKit

extension Reactive where Base: WKWebView {
    var load: BindingTarget<URLRequest> {
        self.makeBindingTarget {
            $0.load($1)
        }
    }
}
