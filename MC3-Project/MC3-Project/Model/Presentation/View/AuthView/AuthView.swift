//
//  ContentView.swift
//  MC3-Project
//
//  Created by 송기원 on 2023/07/13.
//

import SwiftUI

struct AuthView: View {
    @ObservedObject var viewModel = AuthViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Email", text: $viewModel.email)
                    .autocapitalization(.none)
                SecureField("PW", text: $viewModel.password)
                TextField("UserName을 입력해주세요.", text: $viewModel.userName)
                    .autocapitalization(.none)
                Picker("성별", selection: $viewModel.gender) {
                    Text("남성").tag("male")
                    Text("여성").tag("female")
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                HStack {
                    Button {
                        if viewModel.gender == "male" {
                            viewModel.registerMaleUser()
                        } else {
                            viewModel.registerFemaleUser()
                        }
                    } label: {
                        Text("등록")
                    }
                    
                    Button {
                        viewModel.login()
                    } label: {
                        Text("로그인")
                    }
                    
                    Button {
                        viewModel.logout()
                    } label: {
                        Text("로그아웃")
                    }
                }
                
                Text(viewModel.currentUser?.uid ?? "비로그인")
                    .padding()
             
                NavigationLink("ParticipationView", isActive: $viewModel.isActive) {
                    ParticipationView()
                }
            }
        }
    }
}
