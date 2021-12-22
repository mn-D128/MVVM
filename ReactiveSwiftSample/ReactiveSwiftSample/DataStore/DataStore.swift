//
//  DataStore.swift
//  ReactiveSwiftSample
//
//  Created by Masanori Nakano on 2021/12/18.
//

import Foundation
import Moya
import ReactiveSwift

final class DataStore: NSObject {
    static let shared = DataStore()

    private let provider = MoyaProvider<WikipediaAPI>()
    private let callbackQueue = DispatchQueue.global(qos: .utility)
    private let decoder = JSONDecoder()

    func search(srsearch: String) -> SignalProducer<SearchResponse, Error> {
        self.request(.search(srsearch: srsearch))
    }

    // MARK: - Private

    private func request<T: Decodable>(_ token: WikipediaAPI) -> SignalProducer<T, Error> {
        let decoder = self.decoder

        return self.provider.reactive
            .request(
                token,
                callbackQueue: self.callbackQueue
            )
            .attemptMap {
                do {
                    let value = try decoder.decode(T.self, from: $0.data)
                    return .success(value)
                } catch {                    
                    return .failure(.underlying(error, $0))
                }
            }
            .mapError { $0 as Error }
    }
}
