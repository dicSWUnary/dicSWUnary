//
//  ViewController.swift
//  dicSWUnary
//
//  Created by JUEUN KIM on 2022/03/16.
//

import UIKit
import SnapKit

class ViewController: UIViewController{
    
    //헤더 뷰
    let headerView = UIView().then{
        $0.backgroundColor = .white
    }
    
    let welcomeLevel = UILabel().then{
        $0.textColor = .black
        $0.text = "삐약삐약 새내기 🐥"
        $0.font = UIFont.systemFont(ofSize: 30.0, weight: .bold)
    }
    let welcomeName = UILabel().then{
        $0.text = "은빈님, 안녕하세요!"
        $0.font = UIFont.systemFont(ofSize: 30.0, weight: .bold)
    }
    
    //프로필
    let profileImage = UIImageView().then{
        $0.image = UIImage(named: "profileImage")
    }
    
    let profileName = UILabel().then{
        $0.text = "은빈"
        $0.font = UIFont.systemFont(ofSize: 24.0, weight: .semibold)
    }
    
    let profileStatus = UILabel().then{
        $0.text = "새내기"
        $0.font = UIFont.systemFont(ofSize: 18.0, weight: .semibold)
        $0.textColor = UIColor.lightGray
    }
    
    let editProfileButton = myButton().then{
        $0.setTitle("미션하러 가기", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 18.0)
        $0.setTitleColor(.darkGray, for: .normal)
        $0.backgroundColor = .white
        $0.addTarget(self, action: #selector(goToMission), for: .touchUpInside)
    }
    
    //재학상태
    let statusTitle = UILabel().then{
        $0.textColor = .black
        $0.text = "재학 상태"
        $0.font = UIFont.systemFont(ofSize: 18.0, weight: .semibold)
    }
    
    let statusView = UIView().then{
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 4
    }
    let nowLevel = UILabel().then{
        $0.text = "🐥\n새내기"
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 16.0)
        $0.lineBreakMode = .byWordWrapping
        $0.numberOfLines = 0
        $0.textAlignment = .center
    }
    let nextLevel = UILabel().then{
        $0.text = "🎓\n학사"
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 16.0)
        $0.lineBreakMode = .byWordWrapping
        $0.numberOfLines = 0
        $0.textAlignment = .center
    }
    //progress view
    let statusProgress = UIProgressView().then{
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
        $0.progressTintColor = UIColor(named: "progressBlue")
        $0.layer.sublayers![1].cornerRadius = 10
        $0.subviews[1].clipsToBounds = true
        $0.progress = 0.3

    }
    let succesMission = UILabel().then{
        $0.text = "3"
        $0.textColor = UIColor(named: "progressBlue")
        $0.font = UIFont.systemFont(ofSize: 12.0)
    }
    let totalMission = UILabel().then{
        $0.text = "/8"
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 12.0)
    }


    //대외활동
    let activityTitle = UILabel().then{
        $0.textColor = .black

        $0.text = "대외 활동"
        $0.font = UIFont.systemFont(ofSize: 18.0, weight: .semibold)
    }
    let activityView = UIView().then{
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 4
    }
    let activityKind = UILabel().then{
        $0.textColor = .black
        $0.text = "🔥 완료한 미션"
        $0.font = UIFont.systemFont(ofSize: 14.0, weight: .medium)
    }
    let activityImage1 = UIImageView().then{
        $0.image = UIImage(named: "activityImage")
    }
    let activityImage2 = UIImageView().then{
        $0.image = UIImage(named: "activityImage")
    }
    let activityImage3 = UIImageView().then{
        $0.image = UIImage(named: "activityImage")
    }
    let activityImage4 = UIImageView().then{
        $0.image = UIImage(named: "activityImage")
    }
    
    //하단 뷰
    let footerView = UIView().then{
        $0.backgroundColor = .white
    }
    
    let logoutButton = myButton().then{
        $0.setTitle("로그아웃", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 18.0)
        $0.setTitleColor(.darkGray, for: .normal)
        $0.backgroundColor = .white
    }
    
    let exitButton = UIButton().then{
        $0.setTitleColor(.darkGray, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 18.0)
        $0.setTitle("회원탈퇴", for: .normal)
        $0.setUnderline()
    }
    
    //navi : 여기서 MissionViewController()으로 이동
    @objc func goToMission(){
        print("toMissionView")
        let childVC = MissionViewController()
        childVC.modalPresentationStyle = .fullScreen
        self.present(childVC, animated: true, completion: nil)
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
        statusView.addSubview(succesMission)
        statusView.addSubview(totalMission)
        statusView.addSubview(nextLevel)
        
        view.addSubview(activityTitle)
        view.addSubview(activityView)
        activityView.addSubview(activityKind)
        activityView.addSubview(activityImage1)
        activityView.addSubview(activityImage2)
        activityView.addSubview(activityImage3)
        activityView.addSubview(activityImage4)
        
        view.addSubview(footerView)
        footerView.addSubview(logoutButton)
        footerView.addSubview(exitButton)
        
        mainLayout()
        statusLayout()
        activityLayout()
        footerLayout()
        // Do any additional setup after loading the view.
    }
    
    func headerLayout(){
        
        headerView.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(1.0 / 4.5) 
        }
        
        welcomeLevel.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(20)
            $0.bottom.equalTo(welcomeName.snp.top).offset(-5)
        }
        
        welcomeName.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(20)
//            $0.top.equalTo(welcomeLevel.snp.bottom).offset(10)
            $0.bottom.equalToSuperview().offset(-25)
            
        }
    }
    
    func mainLayout(){
        profileImage.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalTo(headerView.snp.bottom).offset(20)
        }
        profileName.snp.makeConstraints{
            $0.centerY.equalTo(profileImage).offset(-10)
            $0.leading.equalTo(profileImage.snp.trailing).offset(20)
            
        }
        profileStatus.snp.makeConstraints{
            $0.top.equalTo(profileName.snp.bottom).offset(10)
            $0.leading.equalTo(profileImage.snp.trailing).offset(20)
        }
        editProfileButton.snp.makeConstraints{
            $0.top.equalTo(profileImage.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
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
            $0.height.equalToSuperview().multipliedBy(1.0 / 13.0)
        }
        nowLevel.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(10)
//            $0.width.equalTo(100)
//            $0.height.equalTo(100)
        }
        statusProgress.snp.makeConstraints{
            $0.top.equalToSuperview().offset(15)
            $0.leading.equalTo(nowLevel.snp.trailing).offset(10)
            $0.trailing.equalTo(nextLevel.snp.leading).offset(-10)
            $0.height.equalToSuperview().multipliedBy(1.0/3.5)
            
            
        }
        succesMission.snp.makeConstraints{
            $0.top.equalTo(statusProgress.snp.bottom).offset(5)
            $0.bottom.equalToSuperview().offset(-15)
            $0.trailing.equalTo(totalMission.snp.leading).offset(-1)
        }
        totalMission.snp.makeConstraints{
            $0.top.equalTo(statusProgress.snp.bottom).offset(5)
            $0.bottom.equalToSuperview().offset(-15)
            $0.trailing.equalTo(nextLevel.snp.leading).offset(-10)
        }
        nextLevel.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-10)
        }
    }
    
    func activityLayout(){
        activityTitle.snp.makeConstraints{
            $0.top.equalTo(statusView.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(10)
        }
        activityView.snp.makeConstraints{
            $0.top.equalTo(activityTitle.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().offset(-10)
            $0.height.equalToSuperview().multipliedBy(1.0 / 7.0)
        }
        activityKind.snp.makeConstraints{
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalToSuperview().offset(10)
        }
        activityImage1.snp.makeConstraints{
            $0.top.equalTo(activityKind.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(10)
//            $0.bottom.equalToSuperview().offset(-10)
        }
        activityImage2.snp.makeConstraints{
            $0.top.equalTo(activityKind.snp.bottom).offset(10)
            $0.leading.equalTo(activityImage1.snp.trailing).offset(15)
        }
        activityImage3.snp.makeConstraints{
            $0.top.equalTo(activityKind.snp.bottom).offset(10)
            $0.leading.equalTo(activityImage2.snp.trailing).offset(15)
        }
        activityImage4.snp.makeConstraints{
            $0.top.equalTo(activityKind.snp.bottom).offset(10)
            $0.leading.equalTo(activityImage3.snp.trailing).offset(15)
        }
    }
    
    
    func footerLayout(){
        
        footerView.snp.makeConstraints{
            $0.bottom.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(view.snp.height).multipliedBy(1.0 / 6.5)
        }
        
        logoutButton.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(70)
            $0.trailing.equalToSuperview().offset(-70)
            $0.top.equalToSuperview().offset(20)
            $0.centerX.equalToSuperview()

        }
        exitButton.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(40)
            $0.trailing.equalToSuperview().offset(-40)
            $0.top.equalTo(logoutButton.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
    }
    


}

