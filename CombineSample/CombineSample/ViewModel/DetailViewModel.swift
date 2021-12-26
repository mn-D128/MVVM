//
//  DetailViewModel.swift
//  ReactiveSwiftSample
//
//  Created by Masanori Nakano on 2021/12/22.
//

import Foundation
import Combine

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
        self.model.publisher(for: \.title).map { $0 }.eraseToAnyPublisher()
    }

    var webViewRequest: AnyPublisher<URLRequest, Never> {
        Just(self.model.pageId)
            .compactMap {
                guard let url = URL(string: "https://ja.wikipedia.org/?curid=\($0)") else { return nil }
                return URLRequest(url: url)
            }
            .eraseToAnyPublisher()
    }
}
