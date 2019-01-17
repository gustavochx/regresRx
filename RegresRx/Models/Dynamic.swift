//
//  Dynamic.swift
//  RegresRx
//
//  Created by Gustavo Henrique on 07/01/19.
//  Copyright © 2019 Gustavo Henrique. All rights reserved.
//

import UIKit

class Dynamic<T> {

    var bind : (T) -> () = { _ in }
    
    var value : T? {
        didSet {
            bind(value!)
        }
    }
    
    init(_ v: T) {
        value = v
    }
    
}
