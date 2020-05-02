//
//  AppRouter.swift
//  PetsApp
//
//  Created by Maged Omar on 2/25/20.
//  Copyright © 2020 Maged. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

enum AppRouter: URLRequestConvertible {
    static let baseURLString = "https://uaebarq.ae"
    
    case GetAllVideos
    
    // MARK:- Url Request
    func asURLRequest() throws -> URLRequest {
        var method: HTTPMethod {
            switch self {
            case .GetAllVideos:
                return .get
            }
        }
        
        //     MARK:- Parameters
        
        let params: (Parameters?) = {
            switch self {
            case .GetAllVideos:
                return nil
            }
        }()
        
        //        MARK:- Endpoints
        let url: URL = {
            // build up and return the URL for each endpoint
            let relativePath: String?
            switch self {
            case .GetAllVideos:
                relativePath = "/task.json"
            }
            var url = URL(string: AppRouter.baseURLString)!
            if let relativePath = relativePath {
                url = url.appendingPathComponent(relativePath)
            }
            return url
        }()
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        
        let encoding: ParameterEncoding = {
            switch method {
            case .post:
                return URLEncoding.default // URLEncoding.default
            case .get:
                return URLEncoding.default
            default:
                return URLEncoding.default //JSONEncoding.default
            }
        }()
        print(url)
        return try encoding.encode(urlRequest, with: params)
    }
}
