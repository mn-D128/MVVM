//
//  DataStore.swift
//  ReactiveSwiftSample
//
//  Created by Masanori Nakano on 2021/12/18.
//

import Combine
import Foundation
import Moya

final class DataStore: NSObject {
    static let shared = DataStore()

    private let provider = MoyaProvider<WikipediaAPI>()
    private let callbackQueue = DispatchQueue.global(qos: .utility)
    private let decoder = JSONDecoder()

    func search(srsearch: String) -> AnyPublisher<SearchResponse, Error> {
        self.request(.search(srsearch: srsearch))
    }

    // MARK: - Private

    private func request<T: Decodable>(_ token: WikipediaAPI) -> AnyPublisher<T, Error> {
        self.provider.requestPublisher(
            token,
            callbackQueue: self.callbackQueue
        )
        .map(T.self, using: self.decoder)
        .mapError { $0 as Error }
        .eraseToAnyPublisher()
    }
}
