//
//  DetailModel.swift
//  ReactiveSwiftSample
//
//  Created by Masanori Nakano on 2021/12/22.
//

import Foundation

final class DetailModel: NSObject {
    let title: String
    let url: URL?

    // MARK: - NSObject

    init(
        pageId: PageId,
        title: String
    ) {
        self.title = title
        self.url = URL(string: "https://ja.wikipedia.org/?curid=\(pageId)")

        super.init()
    }
}
