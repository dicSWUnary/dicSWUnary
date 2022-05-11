//
//  SubmitViewController.swift
//  dicSWUnary
//
//  Created by JUEUN KIM on 2022/04/06.
//

import UIKit
import SnapKit
import Then
import Vision
import CoreML


class SubmitViewController: UIViewController {
    let model = dicSWUnary()
//    var matchDict = ["front_logo":
    var matchDict = ["front_logo" : 0, "insa_kiosk" : 1, "gs25" : 2, "lib_kiosk" : 3 ,"lib_science" : 4, "gusia" : 5 , "post_office" : 6, "job" : 7]
    var complete = true
    var now = Int()
    var dbData = [missions]()
    var submittedImage = UIImage()
    let submittedImageView = UIImageView()
    let submitBtn = UIButton().then{
        $0.titleLabel?.font = UIFont(name: "NeoDunggeunmoCode-Regular", size: 23)
        $0.setTitleColor(UIColor(named: "vcYellow"), for: .normal)
        $0.setTitle(">> 제출하기", for: .normal)
        $0.addTarget(self, action: #selector(submitBtnTapped), for: .touchUpInside)
    }
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage? {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(origin: .zero, size: newSize)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    func modelFunc(){
        let dicSWUnaryInput = submittedImage
        guard let dicSWUnaryOutput = try? model.prediction(conv2d_166_input: resizeImage(image: submittedImage, targetSize: CGSize(width: 64, height: 64))!.convertToBuffer()!)else {
            fatalError("Unexpected runtime error.")
        }
        let resultSpot = dicSWUnaryOutput.classLabel
        print("resultSpot is ",resultSpot)
        
        determineComplete(complete: now == matchDict[resultSpot]!)
        complete = (now == matchDict[resultSpot]!)
    }
    var imageLength = Int()
    
    @objc func gotoNextVC(){
        goToFirstViewController(complete: complete)
        self.navigationController?.popViewController(animated: true)
    }

    func goToFirstViewController(complete : Bool) {
        let a = self.navigationController!.viewControllers[1] as! MissionViewController
        if complete == true {
            a.completeList.append(dbData[now])
            a.completeCheck.append(now)
            a.now = now + 1
        }
        a.dbData = dbData
    }
    
    
//    func completeOrNot(result_idx : Int){
//        if now == result_idx {
//            determineComplete(complete: true)
//            complete = true
//        }else {
//            determineComplete(complete: false)
//            complete = false
//        }
//    }
    
    func determineComplete(complete: Bool){
        if complete == true {
            dbData[now].succes_check = true
            CoreDataManager.shared.updateMission(index: now, newData: dbData[now])
            if now == 7 {
                showAlert(style: .alert, title: "Stage Clear", text: "모든 미션을 완료하였습니다. 어플을 다시 실행해주세요")
            }
            else {
            showAlert(style: .alert, title: "성공", text: "미션성공 다음 단계로!")
            }
        } else {
            dbData[now].succes_check = false
            showAlert(style: .alert, title: "실패", text: "미션실패 다시 도전해주세요!")
        }
    }
    
    @objc func submitBtnTapped(){
        
        modelFunc()
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
