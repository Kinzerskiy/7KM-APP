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
    var refOfClient: [DocumentReference] = []
    
    
    func getRefOfClient(completion: @escaping () -> Void) {
        
        let db = Firestore.firestore()
        
        let orderRef = db.collection("Order")
        orderRef.getDocuments { [weak self] data, error in
            if let error = error {
                print(error)
            }
            
            guard let data = data else { return }
            
            for document in data.documents {
                let orderData = document.data()
                
                
                if let client = orderData["client"] as? DocumentReference {
                    let clientRef = client
                    self?.refOfClient.append(clientRef)
                }
            }
            completion()
        }
    }
    
    
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
            self?.orders.removeAll()
            
            let myGroup = DispatchGroup()
            
            for document in data.documents {
                let orderData = document.data()
                myGroup.enter()
                
                if let orderId = orderData["orderId"] as? String,
                   let clientReference = orderData["client"] as? DocumentReference,
                   let articleId = orderData["articleId"] as? String {
                    let paymentDate = orderData["paymentDate"] as? String
                    let city = orderData["city"] as? String
                    let postNumber = orderData["postNumber"] as? String
                    
                    self?.getClient(by: clientReference) { client in
                        self?.getArticle(by: articleId) { article in
                            let order = Order.init(article: article, client: client, orderId: orderId, paymentDate: paymentDate, city: city, postNumber: postNumber)
                            self?.orders.append(order)
                            myGroup.leave()
                        }
                        myGroup.notify(queue: .main) {
                            completion()
                        }
                    }
                }
            }
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
        
        
        let documentRef = db.collection("Articles").document(id)
        
        documentRef.getDocument { [weak self ] document, error in
            if let error = error {
                print(error)
            }
            
            guard let document = document, let articletData = document.data() else { return }
            
            let articleName = articletData["articleName"] as! String
            let articleId = articletData["articleId"] as! String
            
            
            self?.getArticle(by: articleId) { article in
                let article = Article(articleName: articleName, articleId: articleId)
                completion(article)
            }
        }
    }
}

