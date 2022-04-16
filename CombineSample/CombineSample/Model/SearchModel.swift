//
//  SearchModel.swift
//  ReactiveSwiftSample
//
//  Created by Masanori Nakano on 2021/12/19.
//

import Combine
import CombineAction
import Foundation

final class SearchModel: NSObject {
    private let repository = Repository()

    private(set) var search = CombineAction<String, Void, Error> { _ in Empty() }

    @Published private(set) var items = [SearchResultItemModel]()

    // MARK: - NSObject

    override init() {
        super.init()
        self.setupActions()
    }

    // MARK: - Private

    private func setupActions() {
        self.search = CombineAction { [weak self] in
            self?.searchPublisher($0) ?? Empty().eraseToAnyPublisher()
        }
    }

    func searchPublisher(_ search: String) -> AnyPublisher<Void, Error> {
        self.repository.search(search)
            .receive(on: RunLoop.main)
            .handleEvents(receiveOutput: { [weak self] in
                self?.items = $0.query.search.map { SearchResultItemModel(item: $0) }
            })
            .map { _ in }
            .eraseToAnyPublisher()
    }
}
