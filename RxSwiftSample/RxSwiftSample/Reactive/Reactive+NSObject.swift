//
//  Reactive+NSObject.swift
//  RxSwiftSample
//
//  Created by Masanori Nakano on 2021/12/25.
//

import Foundation
import RxSwift
import KRProgressHUD

extension Reactive where Base: NSObject {
    var showKRProgressHUD: Binder<Void> {
        Binder(self.base) { _, _ in
            KRProgressHUD.show()
        }
    }

    var dismissKRProgressHUD: Binder<Void> {
        Binder(self.base) { _, _ in
            KRProgressHUD.dismiss()
        }
    }

    var showErrorKRProgressHUD: Binder<String?> {
        Binder(self.base) { _, message in
            KRProgressHUD.showError(withMessage: message)
        }
    }
}
