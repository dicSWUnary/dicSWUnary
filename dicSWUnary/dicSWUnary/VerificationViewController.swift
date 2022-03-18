//
//  VerificationViewController.swift
//  dicSWUnary
//
//  Created by JUEUN KIM on 2022/03/19.
//

import UIKit

class VerificationViewController: UIViewController {

    let dictionaryImage = UIImageView().then{
        $0.image = UIImage(named: "dictionaryImage")
    }

    
    let emailTitle = UILabel().then{
        $0.text = "웹메일"
//        $0.font = UIFont.systemFont(ofSize: 20.0)
    }
    let emailTextField = UITextField().then{
        $0.allowsEditingTextAttributes = true
        $0.borderStyle = .roundedRect
//            .textFieldStyle(RoundedBorderTextFieldStyle())
//        $0.backgroundColor = .black
    }
    
    let emailCaution = UILabel().then{
        $0.text = "서울여자대학교 웹메일로만 인증이 가능합니다."
        $0.font = UIFont.systemFont(ofSize: 13.0)
        $0.textColor = .lightGray
    }
    
    let sendButton = UIButton().then{
        $0.setTitle("인증 링크 받기", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 10.0)
        $0.setTitleColor(.black, for: .normal)
        $0.backgroundColor = .white
    }
    
    let verifyNumberTitle = UILabel().then{
        $0.text = "입력하신 주소의 메일함을 확인해주세요."
    }
    
    let verifyButton = UIButton().then{
        $0.setTitle("인증하기", for: .normal)
        $0.sizeToFit()
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 10.0)
        $0.setTitleColor(.black, for: .normal)
        $0.backgroundColor = .white
        $0.addTarget(self, action: #selector(verifyButtonTapped), for: .touchUpInside)
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = .yellow
        loadComponents(me: self.view)
        allLayout()
    }

    
    @objc func verifyButtonTapped(){
        print("toNextView")
        let childVC = ViewController()
        
        childVC.modalPresentationStyle = .fullScreen
        self.present(childVC, animated: true, completion: nil)
    }
    
    func loadComponents(me : UIView){
        //email Component
        me.addSubview(emailTitle)
        me.addSubview(emailTextField)
        me.addSubview(emailCaution)
        
        me.addSubview(sendButton)
        
        me.addSubview(verifyNumberTitle)
        me.addSubview(verifyButton)
    }
    
    func allLayout(){
        emailLayout()
        verifyLayout()
    }
    
    func emailLayout(){
        
        emailTitle.snp.makeConstraints{
            $0.centerY.equalToSuperview().offset(-50)
            $0.leading.equalToSuperview().offset(30)

        }
        emailTextField.snp.makeConstraints{
            $0.top.equalTo(emailTitle.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(30)
        }
        
        emailCaution.snp.makeConstraints{
            $0.top.equalTo(emailTextField.snp.bottom).offset(8)
            $0.leading.equalTo(emailTextField.snp.leading).offset(10)
        }
        
        sendButton.snp.makeConstraints{
            $0.centerY.equalTo(emailTextField.snp.centerY)
            $0.leading.equalTo(emailTextField.snp.trailing).offset(10)
            $0.trailing.equalToSuperview().offset(-30)
            $0.width.equalTo(100)
        }
    }
    
    func verifyLayout(){
        
        verifyNumberTitle.snp.makeConstraints{
            $0.top.equalTo(emailCaution.snp.bottom).offset(20)
            $0.leading.equalTo(emailTitle)
        }
        
        
        verifyButton.snp.makeConstraints{
            $0.top.equalTo(verifyNumberTitle.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(30)
            $0.trailing.equalToSuperview().offset(-30)
//            $0.width.equalTo(100)
        }
        
        
        
    }


}
