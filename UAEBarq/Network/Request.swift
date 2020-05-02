//
//  Request.swift
//  NovationApp
//
//  Created by Youxel MacBook 8 on 11/6/19.
//  Copyright © 2019 Youxel. All rights reserved.
//

import Foundation
import Alamofire
import UIKit
import ObjectMapper

final class Request{
    
    // 
    static func getData<T:Mappable>(routerCase:URLRequestConvertible, completionHandler: @escaping(_ object: T?, _ error:Error?) -> Void){
        Alamofire.request(routerCase).responseJSON{
            response in
            switch response.result{
            case .success(let value):
                print(value)
                guard let data = value as? [String:Any] else{return}
                let dataMapper = Mapper<T>().map(JSON: data)
                completionHandler(dataMapper,nil)
            case .failure(let error):
                guard let status_code = response.response?.statusCode else{return}
                switch status_code{
                case 401:
                    print("unAuthorized")
                case 500...599:
                    print("Server Error")
                default:
                    break
                }
                completionHandler(nil,error)
                print(error.localizedDescription)
            }
        }
    }
}



