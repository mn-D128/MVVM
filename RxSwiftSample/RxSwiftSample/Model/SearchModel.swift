//
//  SearchModel.swift
//  RxSwiftSample
//
//  Created by Masanori Nakano on 2021/12/24.
//

import Action
import Foundation
import RxSwift

final class SearchModel: NSObject {
    private let repository = Repository()

    private(set) var search = Action<String, Void> { _ in .empty() }

    @objc private(set) dynamic var items = [SearchResultItemModel]()

    // MARK: - NSObject

    override init() {
        super.init()
        self.setupActions()
    }

    // MARK: - Private

    private func setupActions() {
        self.search = Action<String, Void> { [weak self] in
            self?.searchObservable($0) ?? .empty()
        }
    }

    private func searchObservable(_ search: String) -> Observable<Void> {
        self.repository.search(search)
            .observe(on: MainScheduler.instance)
            .do(onSuccess: { [weak self] in
                self?.items = $0.query.search.map { SearchResultItemModel(item: $0) }
            })
            .map { _ in }
            .asObservable()
    }
}
