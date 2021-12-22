//
//  ViewController.swift
//  ReactiveSwiftSample
//
//  Created by Masanori Nakano on 2021/12/18.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa
import KRProgressHUD

final class ViewController: UIViewController {
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            self.collectionView.register(nibCellType: SearchResultItemCell.self)
        }
    }

    private let viewModel = SearchViewModel()

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupBind()
    }

    // MARK: - Private

    private func setupBind() {
        // outputs
        self.collectionView.reactive.reloadData <~ self.viewModel.outputs.reloadData
        self.searchBar.reactive.becomeFirstResponder <~ self.viewModel.outputs.searchBarBecomeFirstResponder
        self.viewModel.outputs.showProgress.observeValues { KRProgressHUD.show() }
        self.viewModel.outputs.dismissProgress.observeValues { KRProgressHUD.dismiss() }
        self.viewModel.outputs.showError.observeValues { KRProgressHUD.showError(withMessage: $0) }
        self.reactive.showDetail <~ self.viewModel.outputs.showDetail

        self.searchBar.delegate = self.viewModel.searchBarDelegate
        self.collectionView.dataSource = self.viewModel.collectionViewDataSource
        self.collectionView.delegate = self.viewModel.collectionViewDelegate
    }

    fileprivate func showDetail(model: DetailModel) {
        guard let vc = self.storyboard?.instantiateViewController(
            identifier: "DetailViewController",
            creator: { coder in
                DetailViewController(coder: coder, model: model)
            }
        ) else {
            return
        }

        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Reactive

private extension Reactive where Base == ViewController {
    var showDetail: BindingTarget<DetailModel> {
        self.makeBindingTarget {
            $0.showDetail(model: $1)
        }
    }
}
