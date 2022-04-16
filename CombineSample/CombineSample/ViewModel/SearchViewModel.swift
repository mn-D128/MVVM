//
//  SearchViewModel.swift
//  ReactiveSwiftSample
//
//  Created by Masanori Nakano on 2021/12/19.
//

import Combine
import CombineAction
import Foundation
import UIKit

final class SearchViewModel: NSObject {
    private let model = SearchModel()

    // outputs
    private let showDetailSubject = PassthroughSubject<DetailModel, Never>()
}

// MARK: - SearchViewModelType

extension SearchViewModel: SearchViewModelType {
    var inputs: SearchViewModelInputs { self }
    var outputs: SearchViewModelOutputs { self }
    var searchBarDelegate: UISearchBarDelegate { self }
    var collectionViewDataSource: UICollectionViewDataSource { self }
    var collectionViewDelegate: UICollectionViewDelegate { self }
}

// MARK: - SearchViewModelInputs

extension SearchViewModel: SearchViewModelInputs {}

// MARK: - SearchViewModelOutputs

extension SearchViewModel: SearchViewModelOutputs {
    var reloadData: AnyPublisher<Void, Never> {
        self.model.$items
            .map { _ in }
            .eraseToAnyPublisher()
    }

    var searchBarBecomeFirstResponder: AnyPublisher<Void, Never> {
        self.model.search.errors.map { _ in }.eraseToAnyPublisher()
    }

    var showProgress: AnyPublisher<Void, Never> {
        self.model.search.$isExecuting.compactMap { $0 ? () : nil }.eraseToAnyPublisher()
    }

    var dismissProgress: AnyPublisher<Void, Never> {
        self.model.search.values
    }

    var showError: AnyPublisher<String, Never> {
        self.model.search.errors.map { $0.localizedDescription }.eraseToAnyPublisher()
    }

    var showDetail: AnyPublisher<DetailModel, Never> {
        self.showDetailSubject.eraseToAnyPublisher()
    }
}

// MARK: - UISearchBarDelegate

extension SearchViewModel: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()

        let text = searchBar.text ?? ""
        self.model.search.apply(text).sinkUntilCompleted()
    }
}

// MARK: - UICollectionViewDataSource

extension SearchViewModel: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.model.items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseCellType: SearchResultItemCell.self, for: indexPath)

        if self.model.items.indices.contains(indexPath.item) {
            let item = self.model.items[indexPath.item]
            cell.setTitle(item.title)
        }

        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension SearchViewModel: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sectionInset = (collectionViewLayout as? UICollectionViewFlowLayout)?.sectionInset ?? .zero
        return CGSize(
            width: collectionView.frame.width - sectionInset.left - sectionInset.right,
            height: 44
        )
    }
}

// MARK: - UICollectionViewDelegate

extension SearchViewModel: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard self.model.items.indices.contains(indexPath.item) else { return }

        let item = self.model.items[indexPath.item]
        let model = DetailModel(
            pageId: item.pageId,
            title: item.title
        )

        self.showDetailSubject.send(model)
    }
}
