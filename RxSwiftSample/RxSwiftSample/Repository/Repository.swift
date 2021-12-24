//
//  Repository.swift
//  RxSwiftSample
//
//  Created by Masanori Nakano on 2021/12/24.
//

import Foundation
import RxSwift

final class Repository: NSObject {
    // MARK: - Public

    func search(_ search: String) -> Single<SearchResponse> {
        DataStore.shared.search(srsearch: search)
    }
}
