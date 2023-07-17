//
//  ParticipationViewModel.swift
//  MC3-Project
//
//  Created by 송기원 on 2023/07/14.
//

import Foundation
import Firebase

class ParticipationViewModel: ObservableObject {
    let firebaseDB = Firestore.firestore()
    let currentUser = Auth.auth().currentUser
    @Published var isActive = false
    @Published var userInfo: [User] = []
    var currentUserInfo: User?
    
    func participateEvent() {
        let ref = firebaseDB.collection("users").document(currentUser?.uid ?? "")
        firebaseDB.runTransaction({ (transaction, errorPointer) -> Any? in
            let Document: DocumentSnapshot
            do {
                try Document = transaction.getDocument(ref)
            } catch let fetchError as NSError {
                errorPointer?.pointee = fetchError
                return nil
            }
            guard Document.data()?["isParticipated"] is Bool else {
                let error = NSError(
                    domain: "AppErrorDomain",
                    code: -1,
                    userInfo: [
                        NSLocalizedDescriptionKey: "Unable to retrieve isParticipated from snapshot \(Document)"
                    ]
                )
                errorPointer?.pointee = error
                return nil
            }
            transaction.updateData(["isParticipated": true], forDocument: ref)
            return nil
        }) { (object, error) in
            if let error = error {
                //실패했을때
                print("Transaction failed: \(error)")
            } else {
                //성공했을 때 출력
                print("Transaction successfully committed!")
            }
        }
    }
    
    func fetchCurrentUserGroup() {
        firebaseDB.collection("users").document(currentUser?.uid ?? "").getDocument { (snapshot, error) in
            
            if let error = error {
                // 문서 가져오기 실패
                print("Error getting user document: \(error)")
                return
            }
            
            guard let document = snapshot, document.exists else {
                // 문서가 존재하지 않음
                return
            }
            
            // 필드 데이터에 접근
            if document.data() != nil {
                self.currentUserInfo = User(userName: document["userName"] as? String ?? "",
                                            userID: document.documentID,
                                            gender: document["gender"] as? String ?? "",
                                            email: document["email"] as? String ?? "",
                                            group: document["group"] as? Int ?? 0,
                                            userSignal: document["userSignal"] as? String ?? "",
                                            isParticipated: document["isParticipated"] as? Bool ?? false)
                
                DispatchQueue.global().async { [weak self] in
                    guard let self = self else { return }
                    
                    self.firebaseDB.collection("users")
                        .whereField("group", isEqualTo: self.currentUserInfo?.group as Any)
                        .whereField("gender", isNotEqualTo: self.currentUserInfo?.gender as Any)
                        .getDocuments { [weak self] snapshot, error in
                            guard let self = self else { return }
                            
                            if let error = error {
                                print("Error fetching documents: \(error)")
                                return
                            }
                            
                            guard let documents = snapshot?.documents else {
                                print("No documents")
                                return
                            }
                            
                            self.userInfo = documents.map {
                                return User(userName: $0["userName"] as? String ?? "",
                                            userID: $0.documentID,
                                            gender: $0["gender"] as? String ?? "",
                                            email: $0["email"] as? String ?? "",
                                            group: $0["group"] as? Int ?? 0,
                                            userSignal: $0["userSignal"] as? String ?? "",
                                            isParticipated: $0["isPartivipated"] as? Bool ?? false)
                            }
                            
                            DispatchQueue.main.async {
                                self.isActive = true
                            }
                        }
                }
            }
        }
    }
}

