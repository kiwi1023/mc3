//
//  User.swift
//  MC3-Project
//
//  Created by 송기원 on 2023/07/11.
//

import Foundation


struct User: Identifiable {
    var id: UUID = UUID()
    var userName: String
    var userID: String
    var gender: String
    var email: String
    var group: Int
    var userSignal: String
    var isParticipated: Bool
}
