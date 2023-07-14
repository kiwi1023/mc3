//
//  SendHeartView.swift
//  FirebaseTest
//
//  Created by Bokyung on 2023/07/12.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore

struct SendHeartView: View {
    @State var documents: [QueryDocumentSnapshot] = []
    
    var body: some View {
        // Group1이라고 가정
        let lunaID: String = "luna"
        let heemooID: String = "Heemoo"
        let kiwiID: String = "Kiwi"
        let puppyID: String = "Puppy"
        
        // 문서 업데이트 - 전체 문서를 덮어쓰지 않고 문서의 일부 필드를 업데이트하려면 다음과 같은 언어별 update() 메서드를 사용합니다.
        VStack {
            Text("하트 보내기~")
            Button("퍼피가 루나에게 하트 보내기") {
                sendHeartToYou(myID: puppyID, targetID: lunaID)
            }
            Button("키위가 히무에게 하트 보내기") {
                sendHeartToYou(myID: kiwiID, targetID: heemooID)
            }
            Button("루나가 퍼피에게 하트 보내기") {
                sendHeartToYou(myID: lunaID, targetID: puppyID)
            }
            Button("히무가 퍼피에게 하트 보내기") {
                sendHeartToYou(myID: heemooID, targetID: puppyID)
            }
            
            Divider()
            Button("매칭 결과 확인해보기👻") {
                fetchAllDocuments()
                
            }
            
        } // VStack
    }
    
    // 모든 사람들의 정보를 firebase에서 가져오기
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
            
            self.documents = documents
        }
    } // fetchAllDocuments
    
    
    // 내가 원하는 사람("userUUID")에게 하트 보내기
    func sendHeartToYou(myID: String, targetID: String) {
        let washingtonRef = firebaseDB.collection("users").document("\(myID)")

        // Set the "capital" field of the city 'DC'
        washingtonRef.updateData([
            "target": targetID
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
    } // sendHeartToYou
    
    func checkMatching(groupNum: Int){
//        List(documents, id: \.documentID) { document in
//            let documentID = document.documentID
//            let data = document.data()
//            Text("Document ID: \(documentID), Data: \(convertDataToString(data: data))")
//        } // List
        
    }
    
}

struct SendHeartView_Previews: PreviewProvider {
    static var previews: some View {
        SendHeartView()
    }
}
