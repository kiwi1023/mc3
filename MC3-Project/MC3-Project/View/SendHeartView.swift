//
//  SendHeartView.swift
//  FirebaseTest
//
//  Created by Bokyung on 2023/07/12.
//

import SwiftUI


struct SendHeartView: View {
    @Binding var userInfo: [User]
    
    var body: some View {
        // 문서 업데이트 - 전체 문서를 덮어쓰지 않고 문서의 일부 필드를 업데이트하려면 다음과 같은 언어별 update() 메서드를 사용합니다.
        VStack {
            Text("하트 보내기~")
//            Button("퍼피가 루나에게 하트 보내기") {
//                sendHeartToYou(myID: userInfo[0].target = userInfo[2].userID, targetID: lunaID)
//            }
//            Button("키위가 히무에게 하트 보내기") {
//                sendHeartToYou(myID: kiwiID, targetID: heemooID)
//            }
//            Button("루나가 퍼피에게 하트 보내기") {
//                sendHeartToYou(myID: lunaID, targetID: puppyID)
//            }
//            Button("히무가 퍼피에게 하트 보내기") {
//                sendHeartToYou(myID: heemooID, targetID: puppyID)
//            }
//
//            Divider()
//            Button("매칭 결과 확인해보기👻") {
//                fetchAllDocuments()
//
//            }
            
        } // VStack
    }
    
    
}

//struct SendHeartView_Previews: PreviewProvider {
//    static var previews: some View {
//        SendHeartView()
//    }
//}
