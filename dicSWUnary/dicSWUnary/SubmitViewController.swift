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
    var complete = Bool()
    
    var submittedImage = UIImage()
    let submittedImageView = UIImageView()
    let submitBtn = myButton().then{
        $0.setTitle("제출하기", for: .normal)
        $0.addTarget(self, action: #selector(submitBtnTapped), for: .touchUpInside)
    }
    var imageLength = Int()
    
    @objc func gotoNextVC(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func testFunc(complete: Bool){
        if complete {
            showAlert(style: .alert, title: "성공", text: "미션성공 다음 단계로!")
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