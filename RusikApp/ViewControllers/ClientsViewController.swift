//
//  ClientsViewController.swift
//  RusikApp
//
//  Created by ANTON on 14.01.2023.
//

import UIKit

class ClientsViewController: UIViewController {
    
    
    @IBOutlet weak var clientsTableView: UITableView!
    
    let orderManager = OrderManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareTableView()
        getData()
        
    }
    
    func getData() {
        orderManager.getOrders {
            self.clientsTableView.reloadData()
        }
        }
    
    
    
    func prepareTableView() {
        clientsTableView.delegate = self
        clientsTableView.dataSource = self
        
        self.clientsTableView.register(.init(nibName: "ClientsTableViewCell", bundle: nil), forCellReuseIdentifier: "ClientsTableViewCell")
    }
    
    @IBAction func addButtonAction(_ sender: Any) {
        return
    }

}

extension ClientsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        orderManager.getNumberOfOrders()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClientsTableViewCell", for: indexPath) as! ClientsTableViewCell
        
        let order = orderManager.getOrder(by: indexPath.row)
        
        cell.fill(with: order)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClientsTableViewCell", for: indexPath) as! ClientsTableViewCell
        tableView.deselectRow(at: indexPath, animated: true)

        performSegue(withIdentifier: "fromClientToOrder", sender: cell)
    }
    
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let deleteProduct = UIContextualAction(style: .destructive, title: "Delete") { [weak self] ( contextualAction,
//            view, boolValue) in
//
//            BasketManager.shared.removeProduct(at: indexPath.row)
//            tableView.reloadData()
//            self?.updateButton()
//        }
//        deleteProduct.backgroundColor = .red
//        deleteProduct.image = UIImage(systemName: "trash.fill")
//
//        let swipeActions = UISwipeActionsConfiguration(actions: [deleteProduct])
//        return swipeActions
        }

