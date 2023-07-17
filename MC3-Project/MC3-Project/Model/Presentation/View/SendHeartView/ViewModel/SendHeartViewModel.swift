//
//  SendHeartViewModel.swift
//  MC3-Project
//
//  Created by 송기원 on 2023/07/14.
//

//import Foundation
//import Firebase
//
//class SendHeartViewModel: ObservableObject {
//    @Published var documents: [QueryDocumentSnapshot] = []
//
//    // 모든 사람들의 정보를 firebase에서 가져오기
//    func fetchAllDocuments() {
//        firebaseDB.collection("users").getDocuments { snapshot, error in
//            if let error = error {
//                print("Error fetching documents: \(error)")
//                return
//            }
//            
//            guard let documents = snapshot?.documents else {
//                print("No documents")
//                return
//            }
//            
//            self.documents = documents
//        }
//    } // fetchAllDocuments
//    
//    
//    // 내가 원하는 사람("userUUID")에게 하트 보내기
//    func sendHeartToYou(myID: String, targetID: String) {
//        let washingtonRef = firebaseDB.collection("users").document("\(myID)")
//        
//        // Set the "capital" field of the city 'DC'
//        washingtonRef.updateData([
//            "target": targetID
//        ]) { err in
//            if let err = err {
//                print("Error updating document: \(err)")
//            } else {
//                print("Document successfully updated")
//            }
//        }
//    } // sendHeartToYou
//    
//    func checkMatching(groupNum: Int){
//        //        List(documents, id: \.documentID) { document in
//        //            let documentID = document.documentID
//        //            let data = document.data()
//        //            Text("Document ID: \(documentID), Data: \(convertDataToString(data: data))")
//        //        } // List
//        
//    }
//}
