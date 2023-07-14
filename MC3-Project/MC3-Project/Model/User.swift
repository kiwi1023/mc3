//
//  User.swift
//  FirebaseTest
//
//  Created by Kiwi on 2023/07/11.
//

import Foundation


struct User: Identifiable {
    var id: UUID = UUID()
    var userName: String
    var userID: String
    var gender: String
    var email: String
    var group: Int
    var target: String
}
