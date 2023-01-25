//
//  OrdersTableViewCell.swift
//  RusikApp
//
//  Created by ANTON on 19.01.2023.
//

import UIKit

class ClientsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var orderNumberLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    var clientComplition: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func fill(with model: Order) {
        orderNumberLabel.text = model.orderId
        nameLabel.text = model.client?.name
        phoneLabel.text = model.client?.phoneNumber
    }
    

    
}
