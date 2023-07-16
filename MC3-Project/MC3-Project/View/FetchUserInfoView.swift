//
//  FetchUserInfoView.swift
//  FirebaseTest
//
//  Created by Bokyung on 2023/07/12.
//

import SwiftUI

struct FetchUserInfoView: View {
//    @ObservedObject var viewModel = FetchUserInfoViewModel()
    @Binding var userInfo: [User]
    
    var body: some View {
        VStack {
            List(userInfo, id: \.userID) { document in
                Text("Document ID: \(document.userID), email: \(document.email), gender: \(document.gender), group: \(document.group), target: \(document.target), userName: \(document.userName)")
            }
        }
    }
}
