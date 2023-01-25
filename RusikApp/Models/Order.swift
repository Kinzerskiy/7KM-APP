//
//  Order.swift
//  RusikApp
//
//  Created by ANTON on 19.01.2023.
//

import Foundation

struct Order: Codable {
    var article: [Article]?
    var articleIds: [String]?
    var client: Client?
    
    var orderId: String
    let paymentDate: String?
    let city: String?
    let postNumber: String?
}
