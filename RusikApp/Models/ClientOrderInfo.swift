//
//  ClientOrderInfo.swift
//  RusikApp
//
//  Created by ANTON on 19.01.2023.
//

import Foundation

struct ClientOrderInfo: Codable {
    let uuid: String
    let name: String?
    let phoneNumber: String?
    let articleModel: String?
    let city: String?
    let postNumber: String?
    let paymentDate: String?
}
