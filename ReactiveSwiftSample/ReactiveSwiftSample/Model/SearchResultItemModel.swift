//
//  SearchResultItemModel.swift
//  ReactiveSwiftSample
//
//  Created by Masanori Nakano on 2021/12/20.
//

import Foundation

final class SearchResultItemModel: NSObject {
    let title: String
    let pageId: PageId
    
    // MARK: - NSObject

    init(item: SearchResponse.Query.Item) {
        self.title = item.title
        self.pageId = PageId(rawValue: item.pageid)

        super.init()
    }
}
