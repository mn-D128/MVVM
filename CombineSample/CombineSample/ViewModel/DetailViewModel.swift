//
//  DetailViewModel.swift
//  ReactiveSwiftSample
//
//  Created by Masanori Nakano on 2021/12/22.
//

import Combine
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
    var title: AnyPublisher<String?, Never> {
        Just(self.model.title)
            .map { $0 }
            .eraseToAnyPublisher()
    }

    var webViewRequest: AnyPublisher<URLRequest, Never> {
        Just(self.model.url)
            .compactMap {
                guard let url = $0 else { return nil }
                return URLRequest(url: url)
            }
            .eraseToAnyPublisher()
    }
}
