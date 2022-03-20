//
//  StatusCard.swift
//  dicSWUnary
//
//  Created by 이규빈 on 2022/03/21.
//

import SwiftUI

struct StatusCard: View {
    @State private var downloadAmount = 30.0
    var body: some View {
        HStack(){
            VStack{
                Text("🐥")
                    .font(.system(size: 18))
                Text("새내기")
                    .font(.system(size: 14))
            }
            
            ProgressView(value: downloadAmount, total: 100)
            VStack{
                Text("🎓")
                    .font(.system(size: 18))
                Text("학사")
                    .font(.system(size: 14))
            }
        }
        .padding(10)
        .background(Color.white)
        .cornerRadius(10)
    }
}

struct StatusCard_Previews: PreviewProvider {
    static var previews: some View {
        StatusCard()
    }
}
