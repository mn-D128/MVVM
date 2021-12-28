//
//  ViewController.swift
//  CombineSample
//
//  Created by Masanori Nakano on 2021/12/25.
//

import Combine
import KRProgressHUD
import UIKit

final class ViewController: UIViewController {
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            self.collectionView.register(nibCellType: SearchResultItemCell.self)
        }
    }

    private let viewModel = SearchViewModel()

    private var cancellable = Set<AnyCancellable>()

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupBind()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

        if self.view.window == nil {
            self.view = nil
        }
    }

    // MARK: - Private

    private func setupBind() {
        self.cancellable = Set<AnyCancellable>()

        // outputs
        self.viewModel.outputs.reloadData
            .sink(receiveValue: { [weak self] in self?.collectionView.reloadData() })
            .store(in: &self.cancellable)
        self.viewModel.outputs.searchBarBecomeFirstResponder
            .sink(receiveValue: { [weak self] in self?.searchBar.becomeFirstResponder() })
            .store(in: &self.cancellable)
        self.viewModel.outputs.showProgress
            .sink(receiveValue: { KRProgressHUD.show() })
            .store(in: &self.cancellable)
        self.viewModel.outputs.dismissProgress
            .sink(receiveValue: { KRProgressHUD.dismiss() })
            .store(in: &self.cancellable)
        self.viewModel.outputs.showError
            .sink(receiveValue: { KRProgressHUD.showError(withMessage: $0) })
            .store(in: &self.cancellable)
        self.viewModel.outputs.showDetail
            .sink(receiveValue: { [weak self] in self?.showDetail(model: $0) })
            .store(in: &self.cancellable)

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
