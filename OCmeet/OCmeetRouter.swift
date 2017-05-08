//
//  OCmeetRouter.swift
//  OCmeet
//
//  Created by Jirka Ketner on 03/05/17.
//  Copyright © 2017 Jirka Ketner. All rights reserved.
//

import Foundation
import Alamofire

enum OCmeetRouter: URLRequestConvertible {
    static let baseURLString = "http://ocmeet.sites.dev/api/"
    
    case getCar(Int)
    case getCars()
    
    func asURLRequest() throws -> URLRequest {
        var method: HTTPMethod {
            switch self {
            case .getCar, .getCars:
                return .get
            }
        }
        
        let url: URL = {
            let relPath: String?
            switch self {
            case .getCar(let number):
                relPath = "cars/\(number)"
            case .getCars():
                relPath = "cars"
            }
            
            var url = URL(string: OCmeetRouter.baseURLString)!
            if let relPath = relPath {
                url = url.appendingPathComponent(relPath)
            }
            return url
        }()
        
        let params: ([String: Any]?) = {
            switch self {
            case .getCar, .getCars:
                return nil
            }
        }()
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        
        let encoding = JSONEncoding.default
        return try encoding.encode(urlRequest, with: params)
    }
}
