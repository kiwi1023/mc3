//
//  ContentView.swift
//  MC3-Project
//
//  Created by 송기원 on 2023/07/13.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore

class AuthViewModel: ObservableObject {
    let firestore: Firestore
    
    @Published var currentUser: Firebase.User?
    
    init() {
        currentUser = Auth.auth().currentUser
        self.firestore = Firestore.firestore()
    }
    
    func login(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Error : \(error.localizedDescription)")
                return
            }
            self.currentUser = result?.user
        }
    }
    
    func logout() {
        currentUser = nil
        try? Auth.auth().signOut()
    }
    
    
    // Firestore에 남자 정보 저장
    func registerMaleUser(email: String, password: String, gender: String, nickname:String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Error : \(error.localizedDescription)")
                return
            }
            guard let user = result?.user else { return }
            print(user.uid)
            
            let userInfo: [String: Any] = [
                "uid": user.uid,
                "email": email,
                "nickname": nickname,
                "isGrouped": false
                ]
            
            self.firestore.collection("male").document(user.uid).setData(userInfo) { error in
                if let error = error {
                    print("Error storing gender in Firestore: \(error.localizedDescription)")
                } else {
                    print("Gender stored in Firestore")
                }
            }
            
        }
    }
    
    // Firestore에 여자 정보 저장
    func registerFemaleUser(email: String, password: String, gender: String, nickname:String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Error : \(error.localizedDescription)")
                return
            }
            guard let user = result?.user else { return }
            print(user.uid)
            
            let userInfo: [String: Any] = [
                "uid": user.uid,
                "email": email,
                "nickname": nickname,
                "isGrouped": false
                ]
            
             
            self.firestore.collection("female").document(user.uid).setData(userInfo) { error in
                if let error = error {
                    print("Error storing gender in Firestore: \(error.localizedDescription)")
                } else {
                    print("Gender stored in Firestore")
                }
            }
        }
    }
    
    // 그룹에 속하지 않은 유저 가져오기
    func groupMatchingUser(uid: String) {
        
        let docRef = self.firestore.collection("male").document(uid)

        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                print("Document data: \(dataDescription)")
            } else {
                print("Document does not exist")
            }
        }
    }
}

struct AuthView: View {
    
    @State var email = ""
    @State var pw = ""
    @State var gender = ""
    @State var nickname = ""
    @ObservedObject var viewModel = AuthViewModel()
    
    var body: some View {
        
        VStack {
            TextField("Email", text: $email)
                .autocapitalization(.none)
            SecureField("PW", text: $pw)
            TextField("Nickname을 입력해주세요.", text: $nickname)
                .autocapitalization(.none)
            Picker("성별", selection: $gender) {
                        Text("남성").tag("male")
                        Text("여성").tag("female")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                .padding()
            HStack {
                Button {
                    if gender == "male" {
                        viewModel.registerMaleUser(email: email, password: pw, gender: gender, nickname: nickname)
                    } else {
                        viewModel.registerFemaleUser(email: email, password: pw, gender: gender, nickname: nickname)
                    }
                } label: {
                    Text("등록")
                }
                
                Button {
                    viewModel.login(email: email, password: pw)
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
            
            
            Button {
                viewModel.groupMatchingUser(uid: viewModel.currentUser?.uid ?? "비로그인")
            } label: {
                Text("그룹매핑유저")
            }
            
            }
        }
    }
