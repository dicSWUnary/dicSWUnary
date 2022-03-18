//
//  FirstViewController.swift
//  dicSWUnary
//
//  Created by JUEUN KIM on 2022/03/16.
//

import UIKit
import SnapKit
import Then

class FirstViewController: UIViewController {
    
    let dictionaryImage = UIImageView().then{
        $0.image = UIImage(named: "dictionaryImage")
    }

    let webMailBtn = UIButton().then{
        $0.setTitleColor(.black, for: .normal)
        $0.setTitle("웹메일 인증으로 시작하기", for: .normal)
        $0.titleLabel?.textColor = .black
        $0.addTarget(self, action: #selector(webMailBtnTapped), for: .touchUpInside)
        $0.setUnderline()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(dictionaryImage)
        self.view.addSubview(webMailBtn)
        allLayout()
    }
    
    @objc func webMailBtnTapped(){
        print("toNextView")
        
        let childVC =  MissionViewController()
    
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

extension UIButton {
    func setUnderline() {
        guard let title = title(for: .normal) else { return }
        let attributedString = NSMutableAttributedString(string: title)
        attributedString.addAttribute(.underlineStyle,
                                      value: NSUnderlineStyle.single.rawValue,
                                      range: NSRange(location: 0, length: title.count)
        )
        setAttributedTitle(attributedString, for: .normal)
    }
}
