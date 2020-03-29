//
//  Network.swift
//  coctailDB
//
//  Created by Artem Shpilka on 3/27/20.
//  Copyright © 2020 Artem Shpilka. All rights reserved.
//

import Foundation
import Moya

enum Network{
    case getCategory
    case getCoctails(name: String)
}


extension Network: TargetType{
    var baseURL: URL {
        return URL(string: "https://www.thecocktaildb.com/api/json/v1/1")!
    }
    
    var path: String {
        switch self {
        case .getCategory:
            return "/list.php"
        case .getCoctails:
            return "/filter.php"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getCategory:
            return .get
        case .getCoctails:
            return .get
        }
    }
    
    var sampleData: Data {
        switch self {
        case .getCategory:
            return "{\"c\": list}".utf8Encoded
        case .getCoctails(let name):
            return "{\"c\": \(name)}".utf8Encoded
        }
    }
    
    var task: Task {
        switch self {
        case .getCategory:
            return .requestParameters(parameters: ["c": "list"], encoding: URLEncoding.queryString)
        case let .getCoctails(name):
            return .requestParameters(parameters: ["c": name], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
    
}

private extension String{
    var urlEscaped: String{
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    var utf8Encoded: Data{
        return data(using: .utf8)!
    }
    
}
