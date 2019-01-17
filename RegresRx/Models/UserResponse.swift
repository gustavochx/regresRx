//
//  UserResponse.swift
//  RegresRx
//
//  Created by Gustavo Henrique on 15/01/19.
//  Copyright © 2019 Gustavo Henrique. All rights reserved.
//

import UIKit

struct UserResponse: Codable {

    let data : [User]?
    
    init(newTestUser: [User]) {
        self.data = newTestUser
    }
    
    enum CodingKeys : String, CodingKey {
        case data = "data"
    }
    
    public init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.data  = try container.decode([User].self, forKey: .data)
        
    }
    
    func encode() -> Data? {
        do {
            let jsonData = try JSONEncoder().encode(self)
            return jsonData
        }catch {
            return nil
        }
    }
    
    
}
