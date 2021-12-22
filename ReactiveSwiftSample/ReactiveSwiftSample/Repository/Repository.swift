//
//  Repository.swift
//  ReactiveSwiftSample
//
//  Created by Masanori Nakano on 2021/12/19.
//

import Foundation
import ReactiveSwift

final class Repository: NSObject {
    // MARK: - Public

    func search(_ search: String) -> SignalProducer<SearchResponse, Error> {
        DataStore.shared.search(srsearch: search)
    }
}
