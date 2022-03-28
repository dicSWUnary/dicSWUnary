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
    
    let emailTextField = UITextField().then{
        $0.allowsEditingTextAttributes = true
        $0.borderStyle = .none
        $0.attributedPlaceholder = NSAttributedString(
            string: "웹 메일 주소를 입력하세요.",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
    }
    let underbar = UIView().then{
        $0.backgroundColor = .gray
    }
    
    let emailCaution = UILabel().then{
        $0.text = "⚠️서울여자대학교 웹메일로만 인증이 가능합니다."
        $0.font = UIFont.systemFont(ofSize: 13.0)
        $0.textColor = .lightGray
    }
    
    let sendButton = UIButton().then{
        $0.setBackgroundImage(UIImage(named: "buttonBackground"), for: .normal)
        $0.setTitle("인증 링크 받기", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 15.0)
        $0.setTitleColor(.black, for: .normal)
        $0.backgroundColor = .white
    }

    let checkLabel = UILabel().then{
        $0.text = "💌입력하신 주소의 메일함을 확인해주세요."
        $0.textColor = .darkGray
    }
    
    let verifyButton = UIButton().then{
        $0.setBackgroundImage(UIImage(named: "buttonBackground"), for: .normal)
        $0.setTitle("인증완료", for: .normal)
        $0.sizeToFit()
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 15.0)
        $0.setTitleColor(.black, for: .normal)
        $0.backgroundColor = .white
        $0.addTarget(self, action: #selector(verifyButtonTapped), for: .touchUpInside)
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = .white
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
        
        me.addSubview(dictionaryImage)
        
        //email Component
//        me.addSubview(emailTitle)
        me.addSubview(emailTextField)
        me.addSubview(underbar)
        me.addSubview(emailCaution)
        
        me.addSubview(sendButton)
        
        me.addSubview(checkLabel)
        me.addSubview(verifyButton)
    }
    
    func allLayout(){
        emailLayout()
    }
    
    func emailLayout(){
        dictionaryImage.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-200)
//            $0.top.equalToSuperview().offset(50)
        }
        
        emailCaution.snp.makeConstraints{
            $0.top.equalTo(dictionaryImage.snp.bottom).offset(50)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        emailTextField.snp.makeConstraints{
            $0.top.equalTo(emailCaution.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        }
        underbar.snp.makeConstraints{
            $0.top.equalTo(emailTextField.snp.bottom).offset(3)
            $0.leading.equalTo(emailTextField)
            $0.trailing.equalTo(emailTextField)
            $0.height.equalTo(1)
        }
        
        sendButton.snp.makeConstraints{
            $0.top.equalTo(emailTextField.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(30)
            $0.trailing.equalToSuperview().offset(-30)
            $0.width.equalTo(100)
        }
        checkLabel.snp.makeConstraints{
            $0.top.equalTo(sendButton.snp.bottom).offset(25)
            $0.centerX.equalToSuperview()
        }
        
        verifyButton.snp.makeConstraints{
            $0.top.equalTo(checkLabel.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(30)
            $0.trailing.equalToSuperview().offset(-30)
            $0.width.equalTo(100)
            
        }
    }
}
