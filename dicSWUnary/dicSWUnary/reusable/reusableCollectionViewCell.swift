//
//  reusableTableViewCell.swift
//  dicSWUnary
//
//  Created by JUEUN KIM on 2022/03/23.
//

import UIKit

class reusableCollectionViewCell: UICollectionViewCell {
    var touchedItem = Int()
    
    var backGroundImage = UIImage()
    
    let stepLabel = UILabel().then{
        $0.textColor = .lightGray
    }
    
    let stepBtn = UIButton().then{
        $0.isUserInteractionEnabled = false
    }
    
    func adds(view: UIView){
        view.addSubview(stepLabel)
        view.addSubview(stepBtn)
    }
    
    func stackCellLayout(stackViewCell: UIView){
        stepLabel.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(3)
        }
        stepBtn.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-8)
        }
                            
    }
    
    func allFuncs(){
        adds(view: self)
        stackCellLayout(stackViewCell: self)
    }
    
    override func awakeFromNib() {
        allFuncs()
        super.awakeFromNib()
    }



}
