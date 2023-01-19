//
//  ClientManager.swift
//  RusikApp
//
//  Created by ANTON on 19.01.2023.
//

import Foundation
import FirebaseFirestore

class ClientManager {
    
    let db = Firestore.firestore()
    
    static let shared = ClientManager()
    var clients: [Client] = []
    
    func getNumberOfClients() -> Int {
        return clients.count
    }
    
    func getClient(by index: Int) -> Client {
        clients[index]
    }
    
    func getClients(completion: @escaping () -> Void) {
        let db = Firestore.firestore()
        let docRef = db.collection("Clients")
        
        docRef.getDocuments { [weak self] data, error in
            if let error = error {
                print(error)
            }
            
            //Что делает эта строка?
            guard let data = data else { return }
            self?.clients.removeAll()
            
            for document in data.documents {
                let clientData = document.data()
                
                if let orderNumber = clientData["orderNumber"] as? String,
                   let name = clientData["name"] as? String,
                   let phoneNumber = clientData["phoneNumber"] as? String,
                   let city = clientData["city"] as? String,
                   let postNumber = clientData["postNumber"] as? String,
                   let paymentDate = clientData["paymentDate"] as? String
                {
                    let uuid = document.documentID
                    let client = Client(uuid: uuid, orderNumber: orderNumber, name: name, phoneNumber: phoneNumber, city: city, postNumber: postNumber, paymentDate: paymentDate)
                    self?.clients.append(client)
                }
            }
            completion()
        }
    }
    
//    func addNewClient(client: Client) {
//        let index = clients.firstIndex { ClientManager in
//            clients.append(.init(client: Client)
//                           }
//                           }
//
//
//                           func saveClientFields(client: Client, completion: @escaping () -> Void) {
//                do {
//                    try db.collection("Clients").document(client.uuid).setData(from: client)
//                    completion()
//                } catch let error {
//                    print("Error writing client to Firestore: \(error)")
//                }
//            }
//
               
                           }
