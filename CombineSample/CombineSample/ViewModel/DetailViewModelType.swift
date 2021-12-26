//
//  DetailViewModelType.swift
//  ReactiveSwiftSample
//
//  Created by Masanori Nakano on 2021/12/22.
//

import Foundation
import UIKit

protocol DetailViewModelInputs: AnyObject {}

protocol DetailViewModelOutputs: AnyObject {
//    var title: SignalProducer<String?, Never> { get }
//    var webViewRequest: SignalProducer<URLRequest, Never> { get }
}

protocol DetailViewModelType: AnyObject {
    var inputs: DetailViewModelInputs { get }
    var outputs: DetailViewModelOutputs { get }
}
