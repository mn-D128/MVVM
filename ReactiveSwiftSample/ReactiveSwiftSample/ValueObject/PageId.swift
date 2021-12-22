//
//  PageId.swift
//  ReactiveSwiftSample
//
//  Created by Masanori Nakano on 2021/12/22.
//

import Foundation

struct PageId {
    private let rawValue: Int

    init(rawValue: Int) {
        self.rawValue = rawValue
    }
}

// MARK: - CustomStringConvertible

extension PageId: CustomStringConvertible {
    var description: String {
        "\(self.rawValue)"
    }
}
