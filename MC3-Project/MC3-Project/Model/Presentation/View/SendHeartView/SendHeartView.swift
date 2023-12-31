//
//  SendHeartView.swift
//  MC3-Project
//
//  Created by 송기원 on 2023/07/12.
//

import SwiftUI


struct SendHeartView: View {
    @ObservedObject var viewModel = SendHeartViewModel()
    @Binding var userInfo: [User]
    
    var body: some View {
        VStack(spacing: 50){
            HStack(spacing: 20) {
                Button(action: {
                    viewModel.sendHeart(targetUserId: userInfo[0].userID)
                    viewModel.userIndex = 0
                    viewModel.isActive = true
                }) {
                    VStack {
                        Text(userInfo[0].userName)
                            .font(.headline)
                        Image(systemName: "heart.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.red)
                    }
                    .frame(width: 100, height: 100)
                    .padding(20)
                    .background(Color.white)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                }
                
                Button(action: {
                    viewModel.sendHeart(targetUserId: userInfo[1].userID)
                    viewModel.userIndex = 1
                    viewModel.isActive = true
                }) {
                    VStack {
                        Text(userInfo[1].userName)
                            .font(.headline)
                        Image(systemName: "heart.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.red)
                    }
                    .frame(width: 100, height: 100)
                    .padding(20)
                    .background(Color.white)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                }
                
            }
            
            NavigationLink("SwiftUIView", isActive: $viewModel.isActive) {
                SwiftUIView(userName: $userInfo[viewModel.userIndex].userName)
            }
        }
    }
}
