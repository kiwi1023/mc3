//
//  ParticipationView.swift
//  MC3-Project
//
//  Created by 송기원 on 2023/07/14.
//

import SwiftUI
import FirebaseFirestore

struct ParticipationView: View {
    @ObservedObject var viewModel = ParticipationViewModel()
    
    var body: some View {
        VStack {
            Button(action: {
                viewModel.fetchCurrentUserGroup()
                viewModel.participateEvent()
            }) {
                Text("참여")
                    .padding()
                    .frame(width: 150, height: 50) // 버튼 크기 지정
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            
            Button(action: {
                // "미참여" 버튼을 눌렀을 때 수행할 동작
            }) {
                Text("미참여")
                    .padding()
                    .frame(width: 150, height: 50) // 버튼 크기 지정
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        
        NavigationLink("SendHeartView", isActive: $viewModel.isActive) {
            SendHeartView(userInfo: $viewModel.userInfo)
        }
    }
}
