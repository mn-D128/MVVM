//
//  SearchViewModel.swift
//  ReactiveSwiftSample
//
//  Created by Masanori Nakano on 2021/12/19.
//

import Action
import Foundation
import RxCocoa
import RxSwift
import UIKit

final class SearchViewModel: NSObject {
    private let model: SearchModel
    private let search: Action<String, Void>

    // outputs
    private let showDetailRelay = PublishRelay<DetailModel>()

    // MARK: - NSObject

    override init() {
        let model = SearchModel()
        self.model = model
        self.search = Action<String, Void> { [weak model] in model?.search($0).asObservable() ?? .empty() }

        super.init()
    }
}

// MARK: - SearchViewModelType

extension SearchViewModel: SearchViewModelType {
    var inputs: SearchViewModelInputs { self }
    var outputs: SearchViewModelOutputs { self }
    var searchBarDelegate: UISearchBarDelegate { self }
    var collectionViewDelegate: UICollectionViewDelegate { self }
}

// MARK: - SearchViewModelInputs

extension SearchViewModel: SearchViewModelInputs {}

// MARK: - SearchViewModelOutputs

extension SearchViewModel: SearchViewModelOutputs {
    var collectionViewItems: Driver<[SearchResultItemModel]> {
        self.model.rx.observe(\.items).asDriver(onErrorDriveWith: .empty())
    }

    var searchBarBecomeFirstResponder: Driver<Void> {
        self.search.errors.map { _ in }.asDriver(onErrorDriveWith: .empty())
    }

    var showProgress: Driver<Void> {
        self.search.executing.compactMap { $0 ? () : nil }.asDriver(onErrorDriveWith: .empty())
    }

    var dismissProgress: Driver<Void> {
        self.search.elements.asDriver(onErrorDriveWith: .empty())
    }

    var showError: Driver<String> {
        self.search.errors.map { $0.localizedDescription }.asDriver(onErrorDriveWith: .empty())
    }

    var showDetail: Driver<DetailModel> {
        self.showDetailRelay.asDriver(onErrorDriveWith: .empty())
    }
}

// MARK: - UISearchBarDelegate

extension SearchViewModel: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()

        let text = searchBar.text ?? ""
        self.search.execute(text)
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

        self.showDetailRelay.accept(model)
    }
}
