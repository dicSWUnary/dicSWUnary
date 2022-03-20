//
//  MissionCard.swift
//  dicSWUnary
//
//  Created by 이규빈 on 2022/03/21.
//

import SwiftUI

struct MissionCard: View {
    var body: some View {
        VStack(alignment: .leading){
            Rectangle().frame(height:0)
            Text("🔥 도전! 미션 10개")
                .fontWeight(.medium)
                .font(.system(size: 18))
            HStack{
                
                Rectangle().frame(width: 75, height: 75)
                    .frame(maxWidth: .infinity)
                Rectangle().frame(width: 75, height: 75)
                    .frame(maxWidth: .infinity)
                Rectangle().frame(width: 75, height: 75)
                    .frame(maxWidth: .infinity)
                
                Rectangle().frame(width: 75, height: 75)
                    .frame(maxWidth: .infinity)
            }
        }
        .padding(10)
        .background(Color.white)
        .cornerRadius(10)
    }
}

struct MissionCard_Previews: PreviewProvider {
    static var previews: some View {
        MissionCard()
    }
}
