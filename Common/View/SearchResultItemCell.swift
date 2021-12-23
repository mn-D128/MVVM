//
//  SearchResultItemCell.swift
//  ReactiveSwiftSample
//
//  Created by Masanori Nakano on 2021/12/20.
//

import Foundation
import UIKit

final class SearchResultItemCell: UICollectionViewCell {
    @IBOutlet private weak var titleLabel: UILabel!

    func setTitle(_ title: String) {
        self.titleLabel.text = title
    }
}
