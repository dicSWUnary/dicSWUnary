//
//  reusableBtnFrame.swift
//  dicSWUnary
//
//  Created by JUEUN KIM on 2022/03/23.
//

import UIKit
import SnapKit
import Then

class reusableBtnView: UIView {
    
    let BtnImage = UIButton()
//        .then{
//        $0.isUserInteractionEnabled = true
//    }
    
    let BtnLabel = UILabel().then{
        $0.font = UIFont(name: "tway_sky", size: 14)
    }
    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//        BtnViewLayout()
//    }
    
    func adds(view: UIView){
        view.addSubview(BtnImage)
        view.addSubview(BtnLabel)
    }
    
    func BtnViewLayout(){
        self.adds(view: self)
        
        BtnImage.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.trailing.leading.equalToSuperview()
        }
        
        BtnLabel.snp.makeConstraints{
            $0.centerX.equalTo(BtnImage)
            $0.top.equalTo(BtnImage.snp.bottom).offset(16)
            $0.trailing.leading.equalToSuperview()
        }
    }
        
    
    
    

}
