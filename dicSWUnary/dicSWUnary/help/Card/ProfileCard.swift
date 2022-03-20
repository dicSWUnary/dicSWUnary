//
//  ProfileCard.swift
//  dicSWUnary
//
//  Created by 이규빈 on 2022/03/21.
//

import SwiftUI

struct ProfileCard: View {
    var body: some View {
        HStack(spacing: 20){
            Circle()
                .fill(Color("darkgray"))
                .frame(width: 100, height: 100)
            VStack(alignment: .leading, spacing: 0){
                Divider().opacity(0)
                Text("User_name")
                    .fontWeight(.semibold)
                    .font(.system(size: 24))
                Text("Status")
                    .foregroundColor(Color("darkgray"))
                    .fontWeight(.semibold)
                    .font(.system(size: 18))
            }
        }
    }
}

struct ProfileCard_Previews: PreviewProvider {
    static var previews: some View {
        ProfileCard()
    }
}
