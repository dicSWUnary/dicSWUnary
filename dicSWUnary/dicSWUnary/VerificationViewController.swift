//
//  VerificationViewController.swift
//  dicSWUnary
//
//  Created by JUEUN KIM on 2022/03/19.
//

import UIKit
import FirebaseAuth


class VerificationViewController: UIViewController {

    private let authorizedDomain: String = "ENTER AUTHORIZED DOMAIN"
    
    let displayView = UIView().then{
        $0.setRounded(radius: 20)
        $0.backgroundColor = UIColor(red: 38/256, green: 38/256, blue: 38/256, alpha: 1)
    }
    
    let welcomeLabel = UILabel().then{
        $0.text  = "슈니 반가워요"
        $0.font = UIFont(name: "NeoDunggeunmoCode-Regular", size: 28)
        $0.textColor = .white
    }
    
    let innerLineView = UIView().then{
        $0.setRounded(radius: 20)
        $0.backgroundColor = .none
        $0.setBorder(borderColor:  UIColor(red: 0, green: 43.92/100, blue: 75.29/100, alpha: 1), borderWidth: 1)
    }
    
    let dictionaryImage = UIImageView().then{
        $0.image = UIImage(named: "dictionaryImage")
    }
    
    let emailCaution = UILabel().then{
        $0.text = "⚠️서울여자대학교 웹메일로만 인증이 가능합니다."
        $0.font = UIFont(name: "NeoDunggeunmoCode-Regular", size: 12)
        $0.textColor = .lightGray
    }
    
    let emailTextField = UITextField().then{
        $0.allowsEditingTextAttributes = true
        $0.borderStyle = .none
        $0.font = UIFont(name: "NeoDunggeunmoCode-Regular", size: 20)
        $0.attributedPlaceholder = NSAttributedString(
            string: "웹 메일 주소를 입력하세요.",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
    }
    let underbar = UIView().then{
        $0.backgroundColor = UIColor(red: 0, green: 43.92/100, blue: 75.29/100, alpha: 1)
    }
    
    let sendButton = UIButton().then{
        $0.setTitle(">>인증 링크 받기 :)", for: .normal)
//

//        FirebaseDatabase.send
        $0.titleLabel?.font = UIFont(name: "NeoDunggeunmoCode-Regular", size: 25)
        $0.setTitleColor(UIColor(named: "vcYellow"), for: .normal)
    }

    let checkLabel = UILabel().then{
        $0.font = UIFont(name: "NeoDunggeunmoCode-Regular", size: 15)
        $0.text = "💌입력하신 주소의 메일함을 확인해주세요."
        $0.textColor = .white
    }
    
    let verifyButton = UIButton().then{
        $0.setTitle(">> 인증완료:) ", for: .normal)
        $0.titleLabel?.font = UIFont(name: "NeoDunggeunmoCode-Regular", size: 30)
        $0.setTitleColor(UIColor(named: "vcYellow"), for: .normal)
        $0.addTarget(self, action: #selector(verifyButtonTapped), for: .touchUpInside)
    }
    
    private func sendSignInLink(to email: String) {
      let actionCodeSettings = ActionCodeSettings()
      let stringURL = "https://\(authorizedDomain).firebaseapp.com/login?email=\(email)"
      actionCodeSettings.url = URL(string: stringURL)
      // The sign-in operation must be completed in the app.
      actionCodeSettings.handleCodeInApp = true
      actionCodeSettings.setIOSBundleID(Bundle.main.bundleIdentifier!)

      Auth.auth().sendSignInLink(toEmail: email, actionCodeSettings: actionCodeSettings) { error in
        guard error == nil else { return self.displayError(error) }

        // Set `email` property as it will be used to complete sign in after opening email link
        self.email = email
      }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 147/256, green: 123/256, blue: 167/256, alpha: 1)
        loadComponents(me: self.view)
        allLayout()
    }

    
    @objc func verifyButtonTapped(){
        let navi = UINavigationController(rootViewController: ViewController())
        navi.modalPresentationStyle = .fullScreen
        self.present(navi, animated: true, completion: nil)

//        let childVC = ViewController()
//        childVC.modalPresentationStyle = .fullScreen
//        self.present(childVC, animated: true, completion: nil)
    }
    
    func loadComponents(me : UIView){
        
        me.addSubview(displayView)
        displayView.addSubview(welcomeLabel)
        displayView.addSubview(innerLineView)
        innerLineView.addSubview((dictionaryImage))
        innerLineView.addSubview(emailCaution)
        innerLineView.addSubview(emailTextField)
        innerLineView.addSubview(underbar)
        innerLineView.addSubview(sendButton)
        innerLineView.addSubview(checkLabel)
        innerLineView.addSubview(verifyButton)
        
    }
    
    func allLayout(){
        emailLayout()
    }
    
    func emailLayout(){
        displayView.snp.makeConstraints{
            
            $0.leading.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            
            $0.trailing.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
        welcomeLabel.snp.makeConstraints{
            $0.top.equalTo(displayView.snp.top).offset(45)
            $0.centerX.equalToSuperview()
        }
        innerLineView.snp.makeConstraints{
            $0.top.equalTo(welcomeLabel.snp.bottom).offset(20)
//            $0.bottom.equalToSuperview().offset(-30)
            $0.leading.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().offset(-10)
        }

//        }
        dictionaryImage.snp.makeConstraints{
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalToSuperview().offset(8)
            $0.trailing.equalToSuperview().offset(-8)
        }
//
        emailCaution.snp.makeConstraints{
            $0.top.equalTo(dictionaryImage.snp.bottom).offset(50)
            $0.leading.equalTo(innerLineView).offset(16)
            $0.trailing.equalTo(innerLineView).offset(-16)
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
            $0.top.equalTo(emailTextField.snp.bottom).offset(25)
            $0.leading.equalToSuperview().offset(30)
            $0.trailing.equalToSuperview().offset(-30)
            $0.width.equalTo(100)
        }
        checkLabel.snp.makeConstraints{
            $0.top.equalTo(sendButton.snp.bottom).offset(50)
            $0.centerX.equalToSuperview()
        }

        verifyButton.snp.makeConstraints{
            $0.top.equalTo(checkLabel.snp.bottom).offset(30)
            $0.leading.equalToSuperview().offset(30)
            $0.trailing.equalToSuperview().offset(-30)
            $0.width.equalTo(100)
            $0.bottom.equalTo(innerLineView).offset(-50)

        }
    }
}
