//
//  OrderViewController.swift
//  RusikApp
//
//  Created by ANTON on 19.01.2023.
//

import UIKit

class OrderViewController: UIViewController {

    @IBOutlet weak var orderNumberLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var postLabel: UILabel!
    @IBOutlet weak var paymentDateLabel: UILabel!
    
    @IBOutlet weak var articleTableView: UITableView!
    
    let clientManager = ClientManager()
    let articleManager = OrderManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func prepareTableView() {
        articleTableView.delegate = self
        articleTableView.dataSource = self
        
        self.articleTableView.register(.init(nibName: "ArticleTableViewCell", bundle: nil), forCellReuseIdentifier: "ArticleTableViewCell")
    }
    
    
    
    func fill()  {
//        let clients = ClientManager.shared.getClient(by: <#T##Int#>)
    }
}

extension OrderViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        OrderManager.shared.getNumberOfArticles()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as! ArticleTableViewCell
        
        let articles = OrderManager.shared.getArticle(by: indexPath.row)
        
        cell.fill(with: articles)
        return cell
    }
}
