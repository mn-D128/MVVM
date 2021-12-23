//
//  SearchResponse.swift
//  ReactiveSwiftSample
//
//  Created by Masanori Nakano on 2021/12/19.
//

import Foundation

struct SearchResponse {
    let query: Query
}

extension SearchResponse: Decodable {}

extension SearchResponse {
    struct Query {
        let search: [Item]
    }
}

extension SearchResponse.Query: Decodable {}

extension SearchResponse.Query {
    struct Item {
        let ns: Int
        let title: String
        let pageid: PageId
        let size: Int
        let wordcount: Int
        let snippet: String
        let timestamp: String
    }
}

extension SearchResponse.Query.Item: Decodable {}
