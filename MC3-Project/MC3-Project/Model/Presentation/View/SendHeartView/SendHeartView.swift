//
//  SendHeartView.swift
//  MC3-Project
//
//  Created by 송기원 on 2023/07/12.
//

import SwiftUI


struct SendHeartView: View {
    var body: some View {
        HStack(spacing: 20) {
            Button(action: {
                // 버튼을 클릭했을 때 수행할 액션
            }) {
                VStack {
                    Text("Label")
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
                // 버튼을 클릭했을 때 수행할 액션
            }) {
                VStack {
                    Text("Label")
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
    }
}

