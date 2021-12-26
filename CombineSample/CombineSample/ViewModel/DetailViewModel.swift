//
//  DetailViewModel.swift
//  ReactiveSwiftSample
//
//  Created by Masanori Nakano on 2021/12/22.
//

import Foundation

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
//    var title: SignalProducer<String?, Never> {
//        SignalProducer(value: self.model.title)
//    }
//
//    var webViewRequest: SignalProducer<URLRequest, Never> {
//        var request: URLRequest?
//        if let url = URL(string: "https://ja.wikipedia.org/?curid=\(self.model.pageId)") {
//            request = URLRequest(url: url)
//        }
//
//        return SignalProducer(value: request).skipNil()
//    }
}
