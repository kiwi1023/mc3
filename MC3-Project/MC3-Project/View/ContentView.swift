//
//  ContentView.swift
//  MC3-Project
//
//  Created by 송기원 on 2023/07/14.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore

// singleton Database
let firebaseDB = ContentView().db

struct ContentView: View {
    var db = Firestore.firestore()
    @ObservedObject var viewModel = ContentViewModel()
    @State var selectedIndex: Int = 0
    
    var body: some View {
        // 16명(4명*4그룹) 매칭되어 있는 상태
        // 16명의 Data를 Firebase에 데이터를 추가해놓음
        TabView(selection: $selectedIndex) {
            // user 정보 불러오기
            FetchUserInfoView(userInfo: $viewModel.userInfo)
                .tabItem {
                    Image(systemName: "heart.fill")
                    Text("사용자 정보 보기")
                }
                .tag(0)
         
            SendHeartView(userInfo: $viewModel.userInfo)
                .tabItem {
                    Image(systemName: "heart.fill")
                    Text("하트보내기")
                }
                .tag(1)
        } // TabView
        .onAppear{
            viewModel.fetchAllDocuments()
        }
    }
}
