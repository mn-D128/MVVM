//
//  PageId.swift
//  ReactiveSwiftSample
//
//  Created by Masanori Nakano on 2021/12/22.
//

import Foundation

struct PageId: RawRepresentable {
    let rawValue: Int

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

// MARK: - Decodable

extension PageId: Decodable {}
