//
//  Reactive+NSObject.swift
//  ReactiveSwiftSample
//
//  Created by Masanori Nakano on 2021/12/24.
//

import Foundation
import KRProgressHUD
import ReactiveSwift

extension Reactive where Base: NSObject {
    var showKRProgressHUD: BindingTarget<Void> {
        self.makeBindingTarget { _, _ in
            KRProgressHUD.show()
        }
    }

    var dismissKRProgressHUD: BindingTarget<Void> {
        self.makeBindingTarget { _, _ in
            KRProgressHUD.dismiss()
        }
    }

    var showErrorKRProgressHUD: BindingTarget<String?> {
        self.makeBindingTarget { _, value in
            KRProgressHUD.showError(withMessage: value)
        }
    }
}
