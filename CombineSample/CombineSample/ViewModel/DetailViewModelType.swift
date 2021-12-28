//
//  DetailViewModelType.swift
//  ReactiveSwiftSample
//
//  Created by Masanori Nakano on 2021/12/22.
//

import Combine
import Foundation
import UIKit

protocol DetailViewModelInputs: AnyObject {}

protocol DetailViewModelOutputs: AnyObject {
    var title: AnyPublisher<String?, Never> { get }
    var webViewRequest: AnyPublisher<URLRequest, Never> { get }
}

protocol DetailViewModelType: AnyObject {
    var inputs: DetailViewModelInputs { get }
    var outputs: DetailViewModelOutputs { get }
}
