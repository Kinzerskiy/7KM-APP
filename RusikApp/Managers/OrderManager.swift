//
//  OrderManager.swift
//  RusikApp
//
//  Created by ANTON on 19.01.2023.
//

import Foundation
import FirebaseFirestore

class OrderManager {
    
    var orders: [Order] = []
    
    
    func getNumberOfOrders() -> Int {
        return orders.count
    }
    
    func getOrder(by index: Int) -> Order {
        orders[index]
    }
    
    func getOrders(completion: @escaping () -> Void) {
        
        let db = Firestore.firestore()
        let docRef = db.collection("Order")
        
        docRef.getDocuments { [weak self] data, error in
            if let error = error {
                print(error)
            }
            
            guard let data = data else { return }
            
            
            let myGroup = DispatchGroup()
            
            
            for document in data.documents {
                let orderData = document.data()
                
                if let orderId = orderData["orderId"] as? String,
                   let clientReference = orderData["client"] as? DocumentReference {
                    let paymentDate = orderData["paymentDate"] as? String
                    let articleIds = orderData["articles"] as! [String]
                    let city = orderData["city"] as? String
                    let postNumber = orderData["postNumber"] as? String
                    var order = Order.init(articleIds: articleIds, orderId: orderId, paymentDate: paymentDate, city: city, postNumber: postNumber)
                    
                    myGroup.enter()
                    self?.getClient(by: clientReference) { client in
                        order.client = client
                        self?.orders.append(order)
                        myGroup.leave()
                    }
                }
            }
            myGroup.notify(queue: .main) {
                self?.fillOrdersByArticles(completion: completion)
            }
        }
    }

    func fillOrdersByArticles(completion: @escaping () -> Void) {
        let myGroup = DispatchGroup()
        for (index, order) in orders.enumerated() {
            if let articleIds = order.articleIds {
                for articleId in articleIds {
                    myGroup.enter()
                    self.getArticle(by: articleId) { article in
                        self.orders[index].article?.append(article)
                        myGroup.leave()
                    }
                }
            }
        }
            myGroup.notify(queue: .main) {
                completion()
            }
        }
    
    func getClient(by reference: DocumentReference, completion: @escaping (Client) -> Void) {
        reference.getDocument { document, error in
            if let error = error {
                print(error)
            }
            
            guard let document = document, let clientData = document.data() else { return }
            
            if let clientName = clientData["name"] as? String {
                let phoneNumber = clientData["phoneNumber"] as? String
                
                let client = Client(uuid: document.documentID, name: clientName, phoneNumber: phoneNumber)
                completion(client)
            }
            
        }
    }
    
    func getArticle(by id: String, completion: @escaping (Article) -> Void) {
        let db = Firestore.firestore()
        
        
        let documentRef = db.collection("Article").document(id)
        
        documentRef.getDocument { document, error in
            if let error = error {
                print(error)
            }
            
            guard let document = document, let articletData = document.data() else { return }
            
            if let articleName = articletData["articleName"] as? String,
               let articleId = articletData["articleId"] as? String {
                
                let article = Article.init(articleName: articleName, articleId: articleId)
                
                completion(article)
            }
            
        }
    }
}

