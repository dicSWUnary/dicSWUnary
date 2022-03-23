//
//  reusableStackViewCell.swift
//  dicSWUnary
//
//  Created by JUEUN KIM on 2022/03/23.
//

import UIKit

class reusableStackViewCell: UIView {
    var backGroundImage = UIImage()
    
    let stepLabel = UILabel()
    
    let stepBtn = UIButton()
    
    func adds(view: UIView){
        view.addSubview(stepLabel)
        view.addSubview(stepBtn)
    }
    
    func whichStepAmIin(nowStep: Int){
        stepLabel.text = String(nowStep)
    }
    
    func stackCellLayout(stackViewCell: UIView){
        stepLabel.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(8)
        }
        stepBtn.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(stepLabel).offset(8)
        }
                            
    }
    
    func allFuncs(){
        adds(view: self)
        stackCellLayout(stackViewCell: self)
    }
}
