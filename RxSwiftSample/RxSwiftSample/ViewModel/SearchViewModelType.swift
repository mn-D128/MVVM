//
//  SearchViewModelType.swift
//  ReactiveSwiftSample
//
//  Created by Masanori Nakano on 2021/12/19.
//

import Foundation
import RxCocoa
import RxSwift
import UIKit

protocol SearchViewModelInputs: AnyObject {}

protocol SearchViewModelOutputs: AnyObject {
    var collectionViewItems: Driver<[SearchResultItemModel]> { get }
    var searchBarBecomeFirstResponder: Driver<Void> { get }
    var showProgress: Driver<Void> { get }
    var dismissProgress: Driver<Void> { get }
    var showError: Driver<String> { get }
    var showDetail: Driver<DetailModel> { get }
}

protocol SearchViewModelType: AnyObject {
    var inputs: SearchViewModelInputs { get }
    var outputs: SearchViewModelOutputs { get }
    var searchBarDelegate: UISearchBarDelegate { get }
}
