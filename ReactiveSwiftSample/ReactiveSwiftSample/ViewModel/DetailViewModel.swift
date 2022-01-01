//
//  DetailViewModel.swift
//  ReactiveSwiftSample
//
//  Created by Masanori Nakano on 2021/12/22.
//

import Foundation
import ReactiveSwift

final class DetailViewModel: NSObject {
    private let model: DetailModel

    // MARK: - NSObject

    init(model: DetailModel) {
        self.model = model

        super.init()
    }
}

// MARK: - DetailViewModelType

extension DetailViewModel: DetailViewModelType {
    var inputs: DetailViewModelInputs { self }
    var outputs: DetailViewModelOutputs { self }
}

// MARK: - DetailViewModelInputs

extension DetailViewModel: DetailViewModelInputs {}

// MARK: - DetailViewModelOutputs

extension DetailViewModel: DetailViewModelOutputs {
    var title: SignalProducer<String?, Never> {
        SignalProducer(value: self.model.title)
    }

    var webViewRequest: SignalProducer<URLRequest, Never> {
        SignalProducer(value: self.model.url)
            .skipNil()
            .map { URLRequest(url: $0) }
    }
}
