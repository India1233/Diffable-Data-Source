//
//  DiffableTableVC.swift
//  Diffable Data Source
//
//  Created by Sachin Dumal on 11/12/19.
//  Copyright © 2019 Sachin Dumal. All rights reserved.
//

import UIKit

fileprivate typealias UserDataSource = UITableViewDiffableDataSource<DiffableTableVC.Section, User>

fileprivate typealias UserSnapshot = NSDiffableDataSourceSnapshot<DiffableTableVC.Section, User>


class DiffableTableVC: UITableViewController {
    private let identifier = "cell"
    private let alertService = AlertService()
    private var users = [User]()
    private var dataSource:UserDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        configureDataSource()
    }
    
    private func configureDataSource() {
        dataSource  = UserDataSource(tableView: tableView, cellProvider: { (tableView, indexPath, user) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: self.identifier, for: indexPath)
            cell.textLabel?.text = user.name
            return cell
        })
    }
    
    @IBAction func addUser(_ sender: Any) {
        let alert = alertService.createUserAlert { (name) in
            self.addNewuser(name)
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    private func addNewuser(_ name: String) {
        let user = User(name: name)
        users.append(user)
        createSnapshot(from: users)
    }
    
    
    private func createSnapshot(from users: [User]) {
        var snapshot = UserSnapshot()
        snapshot.appendSections([.one])
        snapshot.appendItems(users)
        dataSource.apply(snapshot)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let user = dataSource.itemIdentifier(for: indexPath) else { return}
        print(user)
    }
}



extension DiffableTableVC {
fileprivate enum Section {
        case one
    }
}
