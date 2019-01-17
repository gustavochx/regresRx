//
//  UsersViewModel.swift
//  RegresRx
//
//  Created by Gustavo Henrique on 03/01/19.
//  Copyright © 2019 Gustavo Henrique. All rights reserved.
//

import UIKit

struct UsersViewModel {
    
    var title : String = "Users"
    var users : [UserViewModel] = [UserViewModel]()

}

extension UsersViewModel {
    
    init(newUsers: [UserViewModel]) {
        self.users = newUsers
    }
    
    
}
