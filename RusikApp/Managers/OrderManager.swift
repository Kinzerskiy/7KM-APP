//
//  OrderManager.swift
//  RusikApp
//
//  Created by ANTON on 19.01.2023.
//

import Foundation
import FirebaseFirestore

class OrderManager {
    
    var models: [ClientOrderInfo] = []
    
    func getOrders(completion: @escaping () -> Void) {
        let db = Firestore.firestore()
        let docRef = db.collection("Orders")
        
        docRef.getDocuments { [weak self] data, error in
            if let error = error {
                print(error)
            }
            guard let data = data else { return }
            self?.models.removeAll()
            
            for document in data.documents {
                let orderData = document.data()
                
                if let phoneNumber = phoneNumberData["price"] as? String,
                   let articleModel = articleModelData["articleModel"] as? String,
                   let city = cityData["city"] as? String,
                let postNumber = postNumberData["post"] as? String,
                   let paymentDate = paymentDateData["date"] as? String, {
                    let uuid = document.documentID
                    
                let order = ClientOrderInfo(uuid: uuid, name: name, phoneNumber: phoneNumber, articleModel: articleModel, city: city, postNumber: postNumber, paymentDate: paymentDate)
                    self?.models.append(order)
                }
            }
            completion()
        }
    }
}

