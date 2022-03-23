//
//  MissionViewController.swift
//  dicSWUnary
//
//  Created by 이규빈 on 2022/03/16.
//

import UIKit

class MissionViewController: UIViewController, UITableViewDelegate {

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
    
    let bottomBtnsStackView = UIStackView().then{
        $0.distribution = .equalSpacing
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Mission view load")
        self.view.backgroundColor = .green
        subViews(thisView: self.view)
        addArrangedSubView()
        determineDegree(completeCnt: 1)
        determineMissionImage(questNum: 1)
        suggestLocation(questNum: 1)
        allLayout()
        questTableView.delegate = self
        questTableView.dataSource = self
    }

    func addArrangedSubView(){
        bottomBtnsStackView.addArrangedSubview(hintBtn)
        bottomBtnsStackView.addArrangedSubview(locationBtn)
        bottomBtnsStackView.addArrangedSubview(photoSubmitBtn)
        
    }
    
    func determineMissionImage(questNum: Int){
        missionImage.image = UIImage(named: "missionImage")
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
        thisView.addSubview(bottomBtnsStackView)
    }
    func allLayout(){
        print(#function)
        
        degreeLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(16)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(16)
        }
        questTableView.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(16)
            $0.top.equalTo(degreeLabel.snp.bottom).offset(16)
        }
        locationLabel.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(questTableView.snp.bottom).offset(16)
        }
        missionImage.snp.makeConstraints{
            $0.top.equalTo(locationLabel.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        bottomBtnsStackView.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(missionImage.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(40)
            $0.trailing.equalToSuperview().offset(-40)
        }
    }
}


extension MissionViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reusableTableViewCell") as! reusableTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

}
