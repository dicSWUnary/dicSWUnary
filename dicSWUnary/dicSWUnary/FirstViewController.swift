//
//  FirstViewController.swift
//  dicSWUnary
//
//  Created by JUEUN KIM on 2022/03/16.
//

import UIKit
import SnapKit
import Then
import Lottie

class FirstViewController: UIViewController {
    
    var verified = false // 인증여부확인
    
    let dictionaryImage = UIImageView().then{
        $0.image = UIImage(named: "dictionaryImage")
    }

    let webMailBtn = UIButton().then{
        $0.setTitleColor(.white, for: .normal)
        $0.setTitle("웹메일 인증으로 시작하기", for: .normal)
        $0.titleLabel?.font = UIFont(name: "NeoDunggeunmoCode-Regular", size: 23)
        $0.addTarget(self, action: #selector(webMailBtnTapped), for: .touchUpInside)
        $0.setUnderline()
    }
    
    let animation: AnimationView = {
        let animationView = Lottie.AnimationView(name: "data")

        animationView.frame = CGRect(x:0, y:200, width:400, height:400)
        animationView.contentMode = .scaleAspectFill
        animationView.isUserInteractionEnabled = false
        
        return animationView
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor =  UIColor(red: 147/256, green: 123/256, blue: 167/256, alpha: 1)
        self.view.addSubview(animation)
        animation.play{ (finished) in
            self.animation.removeFromSuperview()
            
            //lottie 끝나고 뷰 실행
            
            self.view.addSubview(self.dictionaryImage)
            self.view.addSubview(self.webMailBtn)
            self.allLayout()
        }
//        self.view.backgroundColor =  UIColor(red: 147/256, green: 123/256, blue: 167/256, alpha: 1)
//        view.addSubview(dictionaryImage)
//        view.addSubview(webMailBtn)
//        allLayout()
        
        
        
    }
    
    @objc func webMailBtnTapped(){
        var childVC = VerificationViewController()
        childVC.modalPresentationStyle = .fullScreen
        self.present(childVC, animated: true, completion: nil)
    }
    
    func allLayout(){
        dictionaryLayout()
        webMailBtnLayout()
    }
    
    func dictionaryLayout(){
        dictionaryImage.snp.makeConstraints{
            $0.center.equalToSuperview()
        }
    }
    func webMailBtnLayout(){
        webMailBtn.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(dictionaryImage.snp.bottom).offset(100)
        }
    }
}

