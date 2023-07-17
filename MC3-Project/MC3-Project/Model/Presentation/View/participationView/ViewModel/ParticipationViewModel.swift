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
                            NSLocalizedDescriptionKey: "Unable to retrieve like from snapshot \(Document)"
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
}
