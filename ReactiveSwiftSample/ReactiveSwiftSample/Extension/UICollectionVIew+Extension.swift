//
//  UICollectionVIew+Extension.swift
//  ReactiveSwiftSample
//
//  Created by Masanori Nakano on 2021/12/23.
//

import Foundation
import UIKit

extension UICollectionView {
    func register(nibCellType type: UICollectionViewCell.Type) {
        let identifier = String(describing: type.classForCoder())
        let nib = UINib(nibName: identifier, bundle: nil)
        self.register(nib, forCellWithReuseIdentifier: identifier)
    }

    func dequeueReusableCell<T: UICollectionViewCell>(withReuseCellType type: T.Type, for indexPath: IndexPath) -> T {
        let identifier = String(describing: T.classForCoder())
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? T else {
            fatalError("failed dequeueReusableCell")
        }
        return cell
    }
}
