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
        self.viewModel.outputs.reloadData.drive(onNext: { [weak self] in self?.collectionView.reloadData() })
        self.viewModel.outputs.searchBarBecomeFirstResponder.drive(self.searchBar.rx.becomeFirstResponder())
        self.viewModel.outputs.showProgress.drive(self.rx.showKRProgressHUD())
        self.viewModel.outputs.dismissProgress.drive(self.rx.dismissKRProgressHUD())
        self.viewModel.outputs.showError.drive(self.rx.showErrorKRProgressHUD())
        
//        self.reactive.showDetail <~ self.viewModel.outputs.showDetail

        self.searchBar.delegate = self.viewModel.searchBarDelegate
        self.collectionView.dataSource = self.viewModel.collectionViewDataSource
        self.collectionView.delegate = self.viewModel.collectionViewDelegate
    }
}

