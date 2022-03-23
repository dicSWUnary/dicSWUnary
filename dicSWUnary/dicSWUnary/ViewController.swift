//
//  ViewController.swift
//  dicSWUnary
//
//  Created by JUEUN KIM on 2022/03/16.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let headerView = UIView().then{
        $0.backgroundColor = .white
    }
    
    let welcomeLevel = UILabel().then{
        $0.text = "삐약삐약 새내기🐥"
//        $0.font = UIFont.systemFont(ofSize: 20.0)
    }
    let welcomeName = UILabel().then{
        $0.text = "은빈님, 안녕하세요!"
    }
    
    let profileImage = UIImageView().then{
        $0.image = UIImage(named: "profileImage")
    }
    
    let profileName = UILabel().then{
        $0.text = "은빈"
    }
    
    let profileStatus = UILabel().then{
        $0.text = "새내기"
    }
    
    let editProfileButton = UIButton().then{
//        $0.titleLabel.text = "sibal"
        $0.setTitle("프로필 편집", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 10.0)
        $0.setTitleColor(.darkGray, for: .normal)
        $0.backgroundColor = .white
    }
    
    let statusTitle = UILabel().then{
        $0.text = "재학 상태"
    }
    
    let statusView = UIView().then{
        $0.backgroundColor = .white
    }
    let nowLevel = UILabel().then{
        $0.text = "🐥\n새내기"
        $0.lineBreakMode = .byWordWrapping
        $0.numberOfLines = 0
        $0.textAlignment = .center
    }
    let nextLevel = UILabel().then{
        $0.text = "🎓\n학사"
        $0.textAlignment = .center
    }
    let statusProgress = UIProgressView()

    let activityTitle = UILabel().then{
        $0.text = "대외 활동"
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "graybackground")
        view.addSubview(headerView)
        headerView.addSubview(welcomeLevel)
        headerView.addSubview(welcomeName)
        
        headerLayout()
        
        view.addSubview(profileImage)
        view.addSubview(profileName)
        view.addSubview(profileStatus)
        view.addSubview(editProfileButton)
        
        view.addSubview(statusTitle)
        view.addSubview(statusView)
        statusView.addSubview(nowLevel)
        statusView.addSubview(statusProgress)
        statusView.addSubview(nextLevel)
        
        mainLayout()
        statusLayout()
        // Do any additional setup after loading the view.
    }
    
    func headerLayout(){
        
        headerView.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(200) // 이렇게 높이로 하지 말고, safearea의 height 가져와서 몇분의 몇 이렇게 넣기.
        }
        
        welcomeName.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(20)
            $0.bottom.equalTo(welcomeLevel.snp.top).offset(-10)

        }
        welcomeLevel.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(20)
//            $0.top.equalTo(welcomeName.snp.bottom).offset(10)
            $0.bottom.equalToSuperview().offset(-20)
        }
    }
    
    func mainLayout(){
        profileImage.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(30)
            $0.top.equalTo(headerView.snp.bottom).offset(20)
        }
        profileName.snp.makeConstraints{
            $0.centerY.equalTo(profileImage).offset(-10)
            $0.leading.equalTo(profileImage.snp.trailing).offset(10)
            
        }
        profileStatus.snp.makeConstraints{
//            $0.centerY.equalTo(profileImage).offset(10)
            $0.top.equalTo(profileName.snp.bottom).offset(10)
            $0.leading.equalTo(profileImage.snp.trailing).offset(10)
        }
        editProfileButton.snp.makeConstraints{
            $0.top.equalTo(profileImage.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().offset(-10)
            $0.centerX.equalToSuperview()
        }
        
    }
    
    func statusLayout(){
        
        statusTitle.snp.makeConstraints{
            $0.top.equalTo(editProfileButton.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(10)
        }
        
        statusView.snp.makeConstraints{
            $0.top.equalTo(statusTitle.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().offset(-10)
//            $0.height.equalTo(100) superview에 대한 비율로 표시해보기
        }
        nowLevel.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(10)
//            $0.width.equalTo(100)
//            $0.height.equalTo(100)
        }
        statusProgress.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(nowLevel.snp.trailing).offset(10)
            $0.trailing.equalTo(nextLevel.snp.leading).offset(-10)
        }
        nextLevel.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-10)
        }
    }
    
    


}

