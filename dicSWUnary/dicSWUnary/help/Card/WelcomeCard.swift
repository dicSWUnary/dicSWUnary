//
//  WelcomeCard.swift
//  dicSWUnary
//
//  Created by 이규빈 on 2022/03/21.
//

import SwiftUI

struct WelcomeCard: View {
    var body: some View {
        VStack(alignment: .leading){
            Rectangle().frame(height:0)
            Text("삐약삐약 새내기🐥")
                .font(.system(size: 30))
                .fontWeight(.bold)
                .padding(.top,25)
                .padding(.leading,10)
            Text("은빈님, 안녕하세요!")
                .font(.system(size: 30))
                .fontWeight(.bold)
                .padding(.bottom, 30)
                .padding(.leading,10)
        }
        .background(Color.white)
        
    }
}

struct WelcomeCard_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeCard()
    }
}
