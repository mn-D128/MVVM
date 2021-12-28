//
//  DataStore.swift
//  ReactiveSwiftSample
//
//  Created by Masanori Nakano on 2021/12/18.
//

import Foundation
import Moya
import RxSwift

final class DataStore: NSObject {
    static let shared = DataStore()

    private let provider = MoyaProvider<WikipediaAPI>()
    private let callbackQueue = DispatchQueue.global(qos: .utility)
    private let decoder = JSONDecoder()

    func search(srsearch: String) -> Single<SearchResponse> {
        self.request(.search(srsearch: srsearch))
    }

    // MARK: - Private

    private func request<T: Decodable>(_ token: WikipediaAPI) -> Single<T> {
        let decoder = self.decoder

        return self.provider.rx.request(
            token,
            callbackQueue: self.callbackQueue
        )
        .map(T.self, using: decoder)
    }
}
