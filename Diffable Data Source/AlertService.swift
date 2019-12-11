//
//  AlertService.swift
//  Diffable Data Source
//
//  Created by Sachin Dumal on 11/12/19.
//  Copyright © 2019 Sachin Dumal. All rights reserved.
//

import UIKit

struct AlertService {
    func createUserAlert(completion: @escaping (String) -> Void) -> UIAlertController {
        let alert = UIAlertController(title: "Create User", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Enter user's name"
        }
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
            let action = alert.textFields?.first?.text ?? ""
            completion(action)
        }
        alert.addAction(saveAction)
        return alert
    }
}
