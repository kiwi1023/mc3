//
//  AuthViewModel.swift
//  MC3-Project
//
//  Created by 송기원 on 2023/07/14.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore

class AuthViewModel: ObservableObject {
    let firestore: Firestore
    @Published var email = ""
    @Published var password = ""
    @Published var gender = ""
    @Published var userName = ""
    @Published var currentUser: Firebase.User?
    @Published var isActive = false
    
    init() {
        currentUser = Auth.auth().currentUser
        self.firestore = Firestore.firestore()
    }
    
    func login() {
        Auth.auth().signIn(withEmail: self.email, password: self.password) { result, error in
            if let error = error {
                print("Error : \(error.localizedDescription)")
                return
            }
            self.currentUser = result?.user
            self.isActive = true
        }
    }
    
    func logout() {
        currentUser = nil
        try? Auth.auth().signOut()
    }
    
    // Firestore에 남자 정보 저장
    func registerMaleUser() {
        Auth.auth().createUser(withEmail: self.email, password: self.password) { result, error in
            if let error = error {
                print("Error : \(error.localizedDescription)")
                return
            }
            guard let user = result?.user else { return }
            print(user.uid)
            
            let userInfo: [String: Any] = [
                "userName": self.userName,
                "userID": user.uid,
                "gender": "male",
                "email": self.email,
                "group": 0,
                "userSignal": "",
                "isParticipated": false
                ]
            
            self.firestore.collection("users").document(user.uid).setData(userInfo) { error in
                if let error = error {
                    print("Error storing gender in Firestore: \(error.localizedDescription)")
                } else {
                    print("Gender stored in Firestore")
                }
            }
            
        }
    }
    
    // Firestore에 여자 정보 저장
    func registerFemaleUser() {
        Auth.auth().createUser(withEmail: self.email, password: self.password) { result, error in
            if let error = error {
                print("Error : \(error.localizedDescription)")
                return
            }
            guard let user = result?.user else { return }
            print(user.uid)
            
            let userInfo: [String: Any] = [
                "userName": self.userName,
                "userID": user.uid,
                "gender": "female",
                "email": self.email,
                "group": 0,
                "userSignal": "",
                "isParticipated": false
                ]
            
             
            self.firestore.collection("users").document(user.uid).setData(userInfo) { error in
                if let error = error {
                    print("Error storing gender in Firestore: \(error.localizedDescription)")
                } else {
                    print("Gender stored in Firestore")
                }
            }
        }
    }
}
