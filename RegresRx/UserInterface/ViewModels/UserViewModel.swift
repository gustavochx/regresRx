//
//  UserViewModel.swift
//  RegresRx
//
//  Created by Gustavo Henrique on 03/01/19.
//  Copyright © 2019 Gustavo Henrique. All rights reserved.
//

import UIKit

struct UserViewModel {

    var firstName : String
    var lastName : String
    var avatar : String
    
}

extension UserViewModel {
    
    init(newUser : User) {
        self.firstName = newUser.firstName!
        self.lastName = newUser.lastName!
        self.avatar = newUser.avatar!
    }
    
    
    func returnUserAvatar() -> UIImage? {

        do {

            let imageData = try UIImage(data: Data(contentsOf: URL(fileURLWithPath: self.avatar)))
            return imageData

        } catch {

            return nil

        }
        
    }
}
