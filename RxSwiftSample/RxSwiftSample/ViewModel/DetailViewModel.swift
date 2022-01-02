//
//  DetailViewModel.swift
//  RxSwiftSample
//
//  Created by Masanori Nakano on 2021/12/25.
//

import Foundation
import RxCocoa
import RxSwift

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
    var title: Driver<String?> {
        BehaviorRelay(value: self.model.title).asDriver().compactMap { $0 }
    }

    var webViewRequest: Driver<URLRequest> {
        BehaviorRelay(value: self.model.url)
            .asDriver()
            .compactMap {
                guard let url = $0 else { return nil }
                return URLRequest(url: url)
            }
    }
}
