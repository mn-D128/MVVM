//
//  WikipediaAPI+Moya.swift
//  ReactiveSwiftSample
//
//  Created by Masanori Nakano on 2021/12/18.
//

import Foundation
import Moya
import Alamofire

extension WikipediaAPI: TargetType {
    var baseURL: URL {
        URL(string: "https://ja.wikipedia.org")!
    }
    
    var path: String {
        "/w/api.php"
    }
    
    var method: HTTPMethod {
        .get
    }

    var sampleData: Data {
        Data()
    }
    
    var task: Task {
        switch self {
        case let .search(srsearch):
            return .requestParameters(
                parameters: [
                    "format" : "json",
                    "action" : "query",
                    "list" : "search",
                    "srsearch" : srsearch,
                ],
                encoding: URLEncoding.queryString
            )
        }
    }
    
    var headers: [String : String]? {
        nil
    }
}
