//
//  MainView.swift
//  dicSWUnary
//
//  Created by 이규빈 on 2022/03/21.
//

import SwiftUI
import SnapKit

struct MainView: View {
    var body: some View {
        VStack(alignment: .leading){
            
            WelcomeCard()
                
            ScrollView{
                VStack(alignment:.leading, spacing:20){
                    ProfileCard()
                    Button(action: {
                        print("Edit Profile")
                    }) {
                        Text("프로필 편집")
                            .fontWeight(.semibold)
                            .font(.system(size: 20))
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding(8)
                    .foregroundColor(Color("darkgray"))
                    .background(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                        .stroke(Color("darkgray"), lineWidth: 2)
                    )
                    Text("재학상태")
                        .fontWeight(.semibold)
                        .font(.system(size: 20))
                    StatusCard()

                    Text("대외활동")
                        .fontWeight(.semibold)
                        .font(.system(size: 20))
                    MissionCard()
                    MissionCard()
                }
                .padding(10)
            }
            
            
        }
        
        .background(Color("graybackground"))
    }
    
}
    



struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
