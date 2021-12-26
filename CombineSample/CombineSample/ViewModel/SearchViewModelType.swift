//
//  SearchViewModelType.swift
//  ReactiveSwiftSample
//
//  Created by Masanori Nakano on 2021/12/19.
//

import Foundation
import UIKit
import Combine

protocol SearchViewModelInputs: AnyObject {}

protocol SearchViewModelOutputs: AnyObject {
    var reloadData: AnyPublisher<Void, Never> { get }
    var searchBarBecomeFirstResponder: AnyPublisher<Void, Never> { get }
    var showProgress: AnyPublisher<Void, Never> { get }
    var dismissProgress: AnyPublisher<Void, Never> { get }
    var showError: AnyPublisher<String, Never> { get }
    var showDetail: AnyPublisher<DetailModel, Never> { get }
}

protocol SearchViewModelType: AnyObject {
    var inputs: SearchViewModelInputs { get }
    var outputs: SearchViewModelOutputs { get }
    var searchBarDelegate: UISearchBarDelegate { get }
    var collectionViewDataSource: UICollectionViewDataSource { get }
}
