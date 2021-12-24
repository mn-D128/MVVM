//
//  SearchModel.swift
//  RxSwiftSample
//
//  Created by Masanori Nakano on 2021/12/24.
//

import Foundation
import RxSwift

final class SearchModel: NSObject {
    private let repository = Repository()

    private(set) var items = [SearchResultItemModel]()

    func search(_ search: String) -> Single<Void> {
        self.repository.search(search)
            .observe(on: MainScheduler.instance)
            .do(onSuccess: { [weak self] in
                self?.items = $0.query.search.map { SearchResultItemModel(item: $0) }
            })
            .map { _ in }
    }
}
