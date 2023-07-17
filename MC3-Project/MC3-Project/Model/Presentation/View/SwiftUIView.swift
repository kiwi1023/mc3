//
//  SwiftUIView.swift
//  MC3-Project
//
//  Created by Kiwon Song on 2023/07/17.
//

import SwiftUI

struct SwiftUIView: View {
    @Binding var userName: String
    
    var body: some View {
        Text("\(userName)에게 하트를 보냈습니다!")
    }
}

