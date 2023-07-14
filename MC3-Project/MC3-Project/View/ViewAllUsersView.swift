//
//  ViewAllUsersView.swift
//  FirebaseTest
//
//  Created by Bokyung on 2023/07/12.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore

struct ViewAllUsersView: View {
    @State var documents: [QueryDocumentSnapshot] = []
    @State var userInfo: [User] = []

    var body: some View {
        VStack {
            Button("사용자 데이터 불러오기") {
                fetchAllDocuments()
            }
            
            List(userInfo, id: \.userID) { document in
                let documentID = document.userID
                Text("Document ID: \(documentID), email: \(document.email), gender: \(document.gender), group: \(document.group), target: \(document.target), userName: \(document.userName)")
            } // List

        } // VStack
    }
    
    // firebase의 users에 저장되어 있는 모든 정보 불러오기
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
    } // fetchAllDocuments
    
    // data를 string으로 바꿔줌
    func convertDataToString(data: [String: Any]) -> String {
        var result = ""
        for (key, value) in data {
            let valueString = "\(value)"
            result += "\(key): \(valueString), "
        }
        if result.hasSuffix(", ") {
            result = String(result.dropLast(2))
        }
        return result
    }
    

}

struct ViewAllUsersView_Previews: PreviewProvider {
    static var previews: some View {
        ViewAllUsersView()
    }
}
