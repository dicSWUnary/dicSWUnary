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
    
    let stepBtn = UIButton().then{
        $0.addTarget(self, action: #selector(stackBtnTapped), for: .touchUpInside)
    }
    
    @objc func stackBtnTapped(){
        print("I am tapped")
//        present(self.imagePickerController, animated: true, completion: nil)
    }
    
    func adds(view: UIView){
        view.addSubview(stepLabel)
        view.addSubview(stepBtn)
    }
    
    func stackCellLayout(stackViewCell: UIView){
        stepLabel.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(8)
        }
        stepBtn.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(stepLabel.snp.bottom).offset(8)
        }
                            
    }
    
    func allFuncs(){
        adds(view: self)
        stackCellLayout(stackViewCell: self)
    }
}
