//
//  UserEndpoint.swift
//  RegresRx
//
//  Created by Gustavo Henrique on 04/01/19.
//  Copyright © 2019 Gustavo Henrique. All rights reserved.
//

import UIKit

enum UserEndpoint  {
    case listUsers
}

extension UserEndpoint : Endpoint {
    var baseUrl: String {
        return "https://reqres.in/"
    }
    
    var path: String {
        switch self {
         case .listUsers:
            return "/api/users"
        }
    }

}

