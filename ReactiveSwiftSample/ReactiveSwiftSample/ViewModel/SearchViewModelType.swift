//
//  SearchViewModelType.swift
//  ReactiveSwiftSample
//
//  Created by Masanori Nakano on 2021/12/19.
//

import Foundation
import UIKit
import ReactiveSwift

protocol SearchViewModelInputs: AnyObject {}

protocol SearchViewModelOutputs: AnyObject {
    var reloadData: Signal<Void, Never> { get }
    var searchBarBecomeFirstResponder: Signal<Void, Never> { get }
    var showProgress: Signal<Void, Never> { get }
    var dismissProgress: Signal<Void, Never> { get }
    var showError: Signal<String, Never> { get }
    var showDetail: Signal<DetailModel, Never> { get }
}

protocol SearchViewModelType: AnyObject {
    var inputs: SearchViewModelInputs { get }
    var outputs: SearchViewModelOutputs { get }
    var searchBarDelegate: UISearchBarDelegate { get }
    var collectionViewDataSource: UICollectionViewDataSource { get }
}
