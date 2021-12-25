//
//  ViewController.swift
//  RxSwiftSample
//
//  Created by Masanori Nakano on 2021/12/23.
//

import UIKit
import RxSwift
import RxCocoa
import KRProgressHUD

class ViewController: UIViewController {
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
        self.viewModel.outputs.collectionViewItems.drive(self.collectionView.rx.items(dataSource: SearchCollectionViewDataSource()))
        self.viewModel.outputs.searchBarBecomeFirstResponder.drive(self.searchBar.rx.becomeFirstResponder)
        self.viewModel.outputs.showProgress.drive(self.rx.showKRProgressHUD)
        self.viewModel.outputs.dismissProgress.drive(self.rx.dismissKRProgressHUD)
        self.viewModel.outputs.showError.drive(self.rx.showErrorKRProgressHUD)
        self.viewModel.outputs.showDetail.drive(self.rx.showDetail)

        self.searchBar.delegate = self.viewModel.searchBarDelegate
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
    var showDetail: Binder<DetailModel> {
        Binder(self.base) { target, value in
            target.showDetail(model: value)
        }
    }
}
