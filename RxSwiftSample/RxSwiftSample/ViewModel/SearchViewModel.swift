//
//  SearchViewModel.swift
//  ReactiveSwiftSample
//
//  Created by Masanori Nakano on 2021/12/19.
//

import Foundation
import UIKit
import Action
import RxSwift
import RxCocoa

final class SearchViewModel: NSObject {
    private let model: SearchModel
    private let search: Action<String, Void>
//
//    // outputs
//    private let showDetailPipe = Signal<DetailModel, Never>.pipe()
//
//    // MARK: - NSObject
//
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
    var collectionViewDataSource: UICollectionViewDataSource { self }
    var collectionViewDelegate: UICollectionViewDelegate { self }
}

// MARK: - SearchViewModelInputs

extension SearchViewModel: SearchViewModelInputs {}

// MARK: - SearchViewModelOutputs

extension SearchViewModel: SearchViewModelOutputs {
    var reloadData: Driver<Void> {
        self.search.elements.map { _ in }.asDriver(onErrorDriveWith: .empty())
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
//
//    var showDetail: Signal<DetailModel, Never> {
//        self.showDetailPipe.output
//    }
}

// MARK: - UISearchBarDelegate

extension SearchViewModel: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        let text = searchBar.text ?? ""
        self.search.execute(text)
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
//        guard self.model.items.indices.contains(indexPath.item) else { return }
//        
//        let item = self.model.items[indexPath.item]
//        let model = DetailModel(
//            pageId: item.pageId,
//            titile: item.title
//        )
//        
//        self.showDetailPipe.input.send(value: model)
    }
}
