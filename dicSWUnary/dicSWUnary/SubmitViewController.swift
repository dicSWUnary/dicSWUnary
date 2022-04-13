//
//  SubmitViewController.swift
//  dicSWUnary
//
//  Created by JUEUN KIM on 2022/04/06.
//

import UIKit
import SnapKit
import Then
import CoreML

class SubmitViewController: UIViewController {
    var complete = true
    var now = Int()
    var dbData = [missions]()
    var submittedImage = UIImage()
    let submittedImageView = UIImageView()
    let submitBtn = UIButton().then{
        $0.titleLabel?.font = UIFont(name: "NeoDunggeunmoCode-Regular", size: 23)
        $0.setTitleColor(.yellow, for: .normal)
        $0.setTitle("제출하기", for: .normal)
        $0.addTarget(self, action: #selector(submitBtnTapped), for: .touchUpInside)
    }
    
    var imageLength = Int()
    
    @objc func gotoNextVC(){
        goToFirstViewController()
        self.navigationController?.popViewController(animated: true)
    }

    func goToFirstViewController() {
        let a = self.navigationController!.viewControllers[1] as! MissionViewController
        
//        self.perform(#selector(update), with: nil , afterDelay: 3)
        a.completeList.append(dbData[now])
        a.completeCheck.append(now)
        a.now = now + 1
        a.dbData = dbData
    }
    
    func testFunc(complete: Bool){
        if complete {
            dbData[now].succes_check = true
            CoreDataManager.shared.updateMission(index: now, newData: dbData[now])
            if now == 7 {
                showAlert(style: .alert, title: "Stage Clear", text: "모든 미션을 완료하였습니다. 어플을 다시 실행해주세요")
            }
            else {
            showAlert(style: .alert, title: "성공", text: "미션성공 다음 단계로!")
            }
        } else {
            showAlert(style: .alert, title: "실패", text: "미션실패 다시 도전해주세요!")
        }
    }
    
    @objc func submitBtnTapped(){
        testFunc(complete: complete)
        self.perform(#selector(gotoNextVC), with: nil , afterDelay: 1)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(submittedImageView)
        self.view.addSubview(submitBtn)
        submittedImageView.image = submittedImage
        thisViewLayout()
    }

    func thisViewLayout(){
        submittedImageView.snp.makeConstraints{
            $0.center.equalToSuperview()
            $0.width.height.equalTo(imageLength)
        }
        submitBtn.snp.makeConstraints{
            $0.top.equalTo(submittedImageView.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().offset(50)
            $0.trailing.equalToSuperview().offset(-50)
        }
    }
}
