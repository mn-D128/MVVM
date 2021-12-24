//
//  SearchCollectionViewDataSource.swift
//  RxSwiftSample
//
//  Created by Masanori Nakano on 2021/12/25.
//

import Foundation
import RxCocoa
import RxSwift

final class SearchCollectionViewDataSource: NSObject {
    private var items = [SearchResultItemModel]()
}

// MARK: - UICollectionViewDataSource

extension SearchCollectionViewDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseCellType: SearchResultItemCell.self, for: indexPath)

        if self.items.indices.contains(indexPath.item) {
            let item = self.items[indexPath.item]
            cell.setTitle(item.title)
        }

        return cell
    }
}

// MARK: - RxCollectionViewDataSourceType

extension SearchCollectionViewDataSource: RxCollectionViewDataSourceType {
    typealias Element = [SearchResultItemModel]
    
    func collectionView(_ collectionView: UICollectionView, observedEvent: Event<Element>) {
        Binder(self) { dataSource, element in
            dataSource.items = element
            collectionView.reloadData()
        }
        .on(observedEvent)
    }
}
