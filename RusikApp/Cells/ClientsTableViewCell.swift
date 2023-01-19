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

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func fill(with model: Client)  {
        orderNumberLabel.text = model.orderNumber
        nameLabel.text = model.name
        phoneLabel.text = model.phoneNumber
    }
    

    
}
