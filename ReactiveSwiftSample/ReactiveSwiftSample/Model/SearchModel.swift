//
//  SearchModel.swift
//  ReactiveSwiftSample
//
//  Created by Masanori Nakano on 2021/12/19.
//

import Foundation
import ReactiveSwift
import ReactiveCocoa

final class SearchModel: NSObject {
    private let repository = Repository()

    @objc private(set) dynamic var items = [SearchResultItemModel]()

    func search(_ search: String) -> SignalProducer<Void, Error> {
        self.repository.search(search)
            .observe(on: UIScheduler())
            .on(value: { [weak self] in
                self?.items = $0.query.search.map { SearchResultItemModel(item: $0) }
            })
            .map { _ in }
            .take(during: self.reactive.lifetime)
    }
}
