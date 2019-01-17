//
//  UserClient.swift
//  RegresRx
//
//  Created by Gustavo Henrique on 04/01/19.
//  Copyright © 2019 Gustavo Henrique. All rights reserved.
//

import UIKit

class UserClient: APIClient {

    public let session : URLSession
    
    public init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    public convenience init() {
        self.init(configuration: .default)
    }
    
    
    public func fetchUsers(with userEndpoint: UserEndpoint,
                           completion: @escaping(Result<UserResponse?,APIError>) -> Void ) {
        
        
        let endpoint = userEndpoint
        let request = endpoint.requestGet
        
        fetch(with: request, decode: { (json) -> UserResponse? in
            guard let userResult = json as? UserResponse else {
                return nil
            }
            return userResult
        }, completionHandler: completion)
        
    }
   
    
}
