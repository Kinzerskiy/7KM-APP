//
//  Order.swift
//  RusikApp
//
//  Created by ANTON on 19.01.2023.
//

import Foundation

struct Order: Codable {
    var clientUid: Client
    var articleModel: String
}

