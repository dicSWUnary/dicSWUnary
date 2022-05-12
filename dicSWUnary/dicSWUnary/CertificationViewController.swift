//
//  CertificationViewController.swift
//  dicSWUnary
//
//  Created by JUEUN KIM on 2022/04/13.
//

import UIKit

class CertificationViewController: UIViewController {

    let certificaitonImage = UIImageView().then{
        $0.image = UIImage(named: "graduate")
    }
    let email = UILabel().then{
        $0.text = UserDefaults.standard.string(forKey: "Email")
        $0.textColor = .black
    }
//    UserDefaults.standard.
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(certificaitonImage)
        view.addSubview(email)
        print("email.text : ",email.text)
        makeLayout()
        // Do any additional setup after loading the view.
    }
    func makeLayout(){
        certificaitonImage.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview()
            $0.top.equalToSuperview().offset(200)
            $0.bottom.equalToSuperview().offset(-200)
        }
        
        email.snp.makeConstraints{
            $0.centerX.equalTo(certificaitonImage)
            $0.bottom.equalToSuperview().offset(-10)
//            $0.top.equalTo(certificaitonImage.snp.bottom)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
