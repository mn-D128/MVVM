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
    func showKRProgressHUD() -> Binder<Void> {
        Binder(self.base) { _, _ in
            KRProgressHUD.show()
        }
    }

    func dismissKRProgressHUD() -> Binder<Void> {
        Binder(self.base) { _, _ in
            KRProgressHUD.dismiss()
        }
    }

    func showErrorKRProgressHUD() -> Binder<String?> {
        Binder(self.base) { _, message in
            KRProgressHUD.showError(withMessage: message)
        }
    }
}
