//
//  BottomCollectionViewCell.swift
//  dicSWUnary
//
//  Created by JUEUN KIM on 2022/04/03.
//

import UIKit

class BottomCollectionViewCell: UICollectionViewCell {
  
    let bottomBtnLabel = UILabel().then{
        $0.font = UIFont(name: "tway_sky", size: 12)
        $0.textColor = .darkGray
    }
    
    let bottomBtn = UIButton().then{
        $0.isUserInteractionEnabled = false
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
            $0.bottom.equalToSuperview().offset(-8)
        }
                            
    }
    
    func allFuncs(){
        self.backgroundColor = .init(white: 1, alpha: 0.5)
        self.setRounded(radius: 10)
        self.setBorder(borderColor: .lightGray, borderWidth: 1)
        adds(view: self)
        bottomCollectionViewLayout(collectionViewCell: self)
    }
    
    override func awakeFromNib() {
        allFuncs()
        super.awakeFromNib()
    }
}
