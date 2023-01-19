//
//  OrderManager.swift
//  RusikApp
//
//  Created by ANTON on 19.01.2023.
//

import Foundation
import FirebaseFirestore

class OrderManager {
    
    let db = Firestore.firestore()
    
    static let shared = OrderManager()
    var articles: [Order] = []
    
    func getNumberOfArticles() -> Int {
        return articles.count
    }
    
    func getArticle(by index: Int) -> Order {
        articles[index]
    }
    
    func getOrders(completion: @escaping () -> Void) {
        
        let db = Firestore.firestore()
        let docRef = db.collection("Orders")
        
        docRef.getDocuments { [weak self] data, error in
            if let error = error {
                print(error)
            }
            guard let data = data else { return }
            self?.articles.removeAll()
            
            for document in data.documents {
                let orderData = document.data()
                
                if let articleModel = orderData["articleModel"] as? String {
                    let article = Order(articleModel: articleModel)
                    self?.articles.append(article)
                }
            }
            completion()
        }
    }
}

