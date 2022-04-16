//
//  SearchViewModel.swift
//  ReactiveSwiftSample
//
//  Created by Masanori Nakano on 2021/12/19.
//

import Foundation
import ReactiveSwift

final class SearchViewModel: NSObject {
    private let model = SearchModel()

    // outputs
    private let showDetailPipe = Signal<DetailModel, Never>.pipe()
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
    var reloadData: Signal<Void, Never> {
        self.model.reactive.signal(for: \.items).map { _ in }
    }

    var searchBarBecomeFirstResponder: Signal<Void, Never> {
        self.model.search.errors.map { _ in }
    }

    var showProgress: Signal<Void, Never> {
        self.model.search.isExecuting.signal.compactMap { $0 ? () : nil }
    }

    var dismissProgress: Signal<Void, Never> {
        self.model.search.values
    }

    var showError: Signal<String, Never> {
        self.model.search.errors.map { $0.localizedDescription }
    }

    var showDetail: Signal<DetailModel, Never> {
        self.showDetailPipe.output
    }
}

// MARK: - UISearchBarDelegate

extension SearchViewModel: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()

        let text = searchBar.text ?? ""
        self.model.search.apply(text).start()
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

        self.showDetailPipe.input.send(value: model)
    }
}
