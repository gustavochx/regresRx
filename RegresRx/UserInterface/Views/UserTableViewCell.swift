//
//  UserTableViewCell.swift
//  RegresRx
//
//  Created by Gustavo Henrique on 08/01/19.
//  Copyright © 2019 Gustavo Henrique. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var userAvatarImageView: UIImageView!
    @IBOutlet weak var userFirstNameLabel: UILabel!
    @IBOutlet weak var userLastNameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
