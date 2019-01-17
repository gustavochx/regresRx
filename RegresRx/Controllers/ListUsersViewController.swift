//
//  ListUsersViewController.swift
//  RegresRx
//
//  Created by Gustavo Henrique on 04/01/19.
//  Copyright © 2019 Gustavo Henrique. All rights reserved.
//

import UIKit

class ListUsersViewController: UIViewController {

    var userClient : UserClient = UserClient()
    
    @IBOutlet weak var tableView: UITableView!
    
    
    private var viewModel : UsersViewModel = UsersViewModel()  {
        
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.loadUsers()
    }
    
    
    private func loadUsers() {
        
        userClient.fetchUsers(with: .listUsers) { (result) in
            
            switch result {
            case . sucess(let users):
              
                
                let usersViewModel = users?.data!.map { user in
                    return UserViewModel(newUser: user)
                }
                
                self.viewModel = UsersViewModel(newUsers: usersViewModel!)
               
            case .failed(let error):
                print(error)
            }
            
        }
        
        
    }
    
    
    @IBAction func addUser(_ sender: Any) {
        
        
    }

}

extension ListUsersViewController : UITableViewDelegate, UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.users.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as! UserTableViewCell
        
        let userViewModel = self.viewModel.users[indexPath.row]
        
        cell.userFirstNameLabel.text = userViewModel.firstName
        cell.userLastNameLabel.text = userViewModel.lastName
        cell.userAvatarImageView.image = userViewModel.returnUserAvatar()
        
        return cell
    }
}


