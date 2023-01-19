//
//  OrdersViewController.swift
//  RusikApp
//
//  Created by ANTON on 14.01.2023.
//

import UIKit

class OrdersViewController: UIViewController {
    
    @IBOutlet weak var ordersTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


}

extension OrdersViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
//        BasketManager.shared.getNumberOfProducts()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BasketTableViewCell", for: indexPath) as! BasketTableViewCell
        
        let product = BasketManager.shared.getProduct(by: indexPath.row)
        
        cell.fill(with: product)
        
        cell.addCompletion = {
            BasketManager.shared.plusProduct(by: indexPath.row)
            tableView.reloadData()
            self.updateButton()
        }
        
        cell.removeCompletion = {
            BasketManager.shared.minusProduct(by: indexPath.row)
            tableView.reloadData()
            self.updateButton()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteProduct = UIContextualAction(style: .destructive, title: "Delete") { [weak self] ( contextualAction,
            view, boolValue) in
            
            BasketManager.shared.removeProduct(at: indexPath.row)
            tableView.reloadData()
            self?.updateButton()
        }
        deleteProduct.backgroundColor = .red
        deleteProduct.image = UIImage(systemName: "trash.fill")
        
        let swipeActions = UISwipeActionsConfiguration(actions: [deleteProduct])
        return swipeActions
        }
    }

