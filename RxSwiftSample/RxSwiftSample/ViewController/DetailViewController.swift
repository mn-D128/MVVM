//
//  DetailViewController.swift
//  RxSwiftSample
//
//  Created by Masanori Nakano on 2021/12/25.
//

import UIKit
import WebKit
import Foundation
import RxCocoa

final class DetailViewController: UIViewController {

    private let webView: WKWebView = {
        let view = WKWebView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let viewModel: DetailViewModelType

    // MARK: - UIViewController

    init?(coder: NSCoder, model: DetailModel) {
        self.viewModel = DetailViewModel(model: model)

        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(self.webView)
        self.webView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.webView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.webView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        self.webView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true

        self.setupBind()
    }

    // MARK: - Private

    private func setupBind() {
        self.viewModel.outputs.title.drive(self.rx.title)
        self.viewModel.outputs.webViewRequest.drive(self.webView.rx.load())
    }
}
