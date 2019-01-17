//
//  User.swift
//  RegresRx
//
//  Created by Gustavo Henrique on 03/01/19.
//  Copyright © 2019 Gustavo Henrique. All rights reserved.
//

import UIKit

public struct User: Codable {
    
    let id : Int?
    let firstName : String?
    let lastName : String?
    let avatar: String?
    
    
    init(newId: Int, newFirstName: String, newLastName: String, newAvatar: String) {
        self.id = newId
        self.firstName = newFirstName
        self.lastName = newLastName
        self.avatar = newAvatar
    }
    
    enum CodingKeys : String, CodingKey {
        
        case id = "id"
        case firstName = "first_name"
        case lastName = "last_name"
        case avatar = "avatar"
        
    }
    
    public init(from decoder: Decoder) throws {
        
        let data = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try data.decode(Int.self, forKey: .id)
        self.firstName = try data.decode(String.self, forKey: .firstName)
        self.lastName = try data.decode(String.self, forKey: .lastName)
        self.avatar = try data.decode(String.self, forKey: .avatar)
        
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
