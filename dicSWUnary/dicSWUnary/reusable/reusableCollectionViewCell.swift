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
    
    let stepLabel = UILabel()
    
    let stepBtn = UIButton().then{
        $0.addTarget(self, action: #selector(stepBtnTapped), for: .touchUpInside)
    }
    func testFunc(inp: Int) -> String{
        if inp == 0 {
            print("done")
            
        }
        return "done"
    }
    @objc func stepBtnTapped(sender: UIButton)-> Int{
        print(sender.tag)
//        testFunc(inp : sender.tag)
        touchedItem  = sender.tag
        
        return sender.tag
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
