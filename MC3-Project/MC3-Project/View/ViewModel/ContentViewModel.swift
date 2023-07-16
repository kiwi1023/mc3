//
//  ContentViewModel.swift
//  MC3-Project
//
//  Created by 송기원 on 2023/07/14.
//

import Foundation
import Firebase

class ContentViewModel: ObservableObject {
    @Published var userInfo: [User] = []
 
    func fetchAllDocuments() {
        firebaseDB.collection("users").getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching documents: \(error)")
                return
            }
            
            guard let documents = snapshot?.documents else {
                print("No documents")
                return
            }
            
            self.userInfo = documents.map {
                return User(userName: $0["userName"] as? String ?? "", userID: $0.documentID, gender: $0["gender"] as? String ?? "", email: $0["email"] as? String ?? "", group: $0["group"] as? Int ?? 0, target: $0["target"] as? String ?? "")
            }
        }
    }
}
