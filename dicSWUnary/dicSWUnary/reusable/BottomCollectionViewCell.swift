//
//  BottomCollectionViewCell.swift
//  dicSWUnary
//
//  Created by JUEUN KIM on 2022/04/03.
//

import UIKit

class BottomCollectionViewCell: UICollectionViewCell {
  
    let bottomBtnLabel = UILabel()
    
    let bottomBtn = UIButton().then{
        $0.isUserInteractionEnabled = false
        $0.addTarget(self, action: #selector(stackBtnTapped), for: .touchUpInside)
    }
    
    @objc func stackBtnTapped(){
        print("I am tapped")

    }
    
    func adds(view: UIView){
        view.addSubview(bottomBtnLabel)
        view.addSubview(bottomBtn)
    }
    
    func bottomCollectionViewLayout(collectionViewCell: UIView){
        
        bottomBtn.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(8)
        }
        bottomBtnLabel.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(bottomBtn.snp.bottom).offset(8)
            $0.bottom.equalToSuperview()
        }
                            
    }
    
    func allFuncs(){
        adds(view: self)
        bottomCollectionViewLayout(collectionViewCell: self)
    }
    
    override func awakeFromNib() {
        
        allFuncs()
        super.awakeFromNib()
    }
}
