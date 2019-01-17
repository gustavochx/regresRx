//
//  Endpoint.swift
//  RegresRx
//
//  Created by Gustavo Henrique on 04/01/19.
//  Copyright © 2019 Gustavo Henrique. All rights reserved.
//

import UIKit

protocol Endpoint {
    var baseUrl: String { get }
    var path : String { get }
}

extension Endpoint {
    
    var urlComponentes : URLComponents {
        var components = URLComponents(string: baseUrl)!
        components.path = path
        return components
    }
    
    var requestGet : URLRequest {
        var urlRequest = URLRequest(url: urlComponentes.url!)
        urlRequest.httpMethod = "GET"
        return urlRequest
    }
    
    var requestPost : URLRequest {
        var urlRequest = URLRequest(url: urlComponentes.url!)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        return urlRequest
    }
    
}
