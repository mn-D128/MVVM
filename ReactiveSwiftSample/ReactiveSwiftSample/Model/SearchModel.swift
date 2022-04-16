//
//  SearchModel.swift
//  ReactiveSwiftSample
//
//  Created by Masanori Nakano on 2021/12/19.
//

import Foundation
import ReactiveCocoa
import ReactiveSwift

final class SearchModel: NSObject {
    private let repository = Repository()

    private(set) var search = Action<String, Void, Error> { _ in .empty }

    @objc private(set) dynamic var items = [SearchResultItemModel]()

    // MARK: - NSObject

    override init() {
        super.init()
        self.setupActions()
    }

    // MARK: - Private

    private func setupActions() {
        self.search = Action { [weak self] in
            self?.searchProducer($0) ?? .empty
        }
    }

    private func searchProducer(_ search: String) -> SignalProducer<Void, Error> {
        self.repository.search(search)
            .observe(on: UIScheduler())
            .on(value: { [weak self] in
                self?.items = $0.query.search.map { SearchResultItemModel(item: $0) }
            })
            .map { _ in }
            .take(during: self.reactive.lifetime)
    }
}
