//
//  DetailViewModelType.swift
//  RxSwiftSample
//
//  Created by Masanori Nakano on 2021/12/25.
//

import Foundation
import RxCocoa
import UIKit

protocol DetailViewModelInputs: AnyObject {}

protocol DetailViewModelOutputs: AnyObject {
    var title: Driver<String?> { get }
    var webViewRequest: Driver<URLRequest> { get }
}

protocol DetailViewModelType: AnyObject {
    var inputs: DetailViewModelInputs { get }
    var outputs: DetailViewModelOutputs { get }
}
