//
//  MissionViewController.swift
//  dicSWUnary
//
//  Created by 이규빈 on 2022/03/16.
//

import UIKit

class MissionViewController: UIViewController {

    let degreeLabel = UILabel()
    
    let questTableView = UITableView()

    let locationLabel = UILabel()
    
    let detailLocationLabel = UILabel()
    
    let missionImage = UIImageView()
    
    let hintBtn = reusableBtnView().then{
        $0.BtnViewLayout()
        $0.BtnImage.setImage(UIImage(named: "hintBtnImage"), for: .normal)
        $0.BtnLabel.text = "Hint"
        
    }
    
    let locationBtn = reusableBtnView().then{
        $0.BtnViewLayout()
        $0.BtnImage.setImage(UIImage(named: "locationBtnImage"), for: .normal)
        $0.BtnLabel.text = "Location"
    }
    
    
    let photoSubmitBtn = reusableBtnView().then{
        $0.BtnViewLayout()
        $0.BtnImage.setImage(UIImage(named: "photoBtnImage"), for: .normal)
        $0.BtnLabel.text = "Photo"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Mission view load")
        self.view.backgroundColor = .green
        subViews(thisView: self.view)
        determineDegree(completeCnt: 1)
        suggestLocation(questNum: 1)
        allLayout()
    }

    func determineDegree(completeCnt : Int) {
        if completeCnt == 0{
            degreeLabel.text = "삐약삐약 새내기"
        }else if completeCnt <= 3{
            degreeLabel.text = "에헴!나도 이제 학사"
        }else if completeCnt <= 6{
            degreeLabel.text = "척척석사"
        } else {
            degreeLabel.text = "서울여대 박사"
        }
    }
    
    func suggestLocation(questNum : Int){
        locationLabel.text = "중앙도서관"
    }

    func subViews(thisView : UIView){
        thisView.addSubview(degreeLabel)
        thisView.addSubview(questTableView)
        thisView.addSubview(locationLabel)
        thisView.addSubview(detailLocationLabel)
        thisView.addSubview(missionImage)
        thisView.addSubview(hintBtn)
        thisView.addSubview(locationBtn)
        thisView.addSubview(photoSubmitBtn)
    }
    func allLayout(){
        print(#function)
        
        degreeLabel.snp.makeConstraints{
            $0.leading.top.equalToSuperview()
        }
        hintBtn.snp.makeConstraints{
            $0.center.equalToSuperview()
        }
    }
    
    
}

