//
//  DetailModel.swift
//  ReactiveSwiftSample
//
//  Created by Masanori Nakano on 2021/12/22.
//

import Foundation

final class DetailModel: NSObject {
    let pageId: PageId
    @objc let title: String

    // MARK: - NSObject

    init(
        pageId: PageId,
        titile: String
    ) {
        self.pageId = pageId
        self.title = titile

        super.init()
    }
}
