//
//  ViewController.swift
//  dicSWUnary
//
//  Created by JUEUN KIM on 2022/03/16.
//

import UIKit
import SnapKit
import Then



//MARK: -- Header

class ViewController: UIViewController{
    
    var dbData = [missions(advise: "정문에 위치한 서울여대의 마크! 졸업 사진 스팟이에요!", building_name: "정문", floor: "건물 외부", guide_image: "guide0", hint: "정문을 통해서 50주년으로 가볼까요?", index: 0, location_image: "location_0", spot_name: "학교 마크", succes_check: true),
                  missions(advise: "토익, 등본, 발표자료 등 프린트가 필요하다면 카피웍스를 이용해보세요.", building_name: "50주년 기념관", floor: "지하 1층", guide_image: "guide1", hint: "계단 옆 연못 옆을 볼까요?", index: 1, location_image: "location_1", spot_name: "카피웍스", succes_check: true),
                  missions(advise: "50주년 기념관 1층에서는 빠르게 식사를 해결할 수 있어요. 또 제공되는 테이블에서 과제 등을 해도 괜찮아요.", building_name: "50주년 기념관", floor: "1층", guide_image: "guide_2", hint: "빵 냄새를 따라가다보면 만날 수 있을지도?", index: 2, location_image: "location_2", spot_name: "CU 편의점", succes_check: false),
                  missions(advise: "재학증명서, 장학금 수혜증명서 등 다양한 증명서 출력이 저렴한 가격에 가능해요!", building_name: "인문사회관", floor: "1층", guide_image: "guide_3", hint: "인문사회관 내부에서 땅콩계단 방향을 바라보세요", index: 3, location_image: "location_3", spot_name: "키오스크", succes_check: false),
                  missions(advise: "유일한 좌식 좌석. 온돌이 깔려있어서 뜨뜻하게 공부할 수 있어요.", building_name: "도서관", floor: "1층", guide_image: "guide_4", hint: "좌석번호 178-181를 찾아보세요.", index: 4, location_image: "location_4", spot_name: "슈니마루", succes_check: false),
                  missions(advise: "학기 초에 한 학기 대여를 신청하면, 책 값을 아낄 수 있어요.", building_name: "도서관", floor: "4층", guide_image: "guide_5", hint: "엘리베이터는 비상계단 앞에 있어요! 그걸 타고 올라가볼까요?", index: 5, location_image: "location_5", spot_name: "자연과학 자료실", succes_check: false),
                  missions(advise: "편지나 서류를 보내고 싶다면 서울여대 우체국을 이용해보세요", building_name: "학생누리관", floor: "1층", guide_image: "guide_6", hint: "누리관에서 우리은행을 지나 쭉 들어와보세요.", index: 6, location_image: "location_6", spot_name: "우체국", succes_check: false),
                  missions(advise: "1학년부터 4학년 모두를 위한 취업 프로그램이 준비되어있으니, 저학년일 때부터 많이 이용해보세요.", building_name: "학생누리관", floor: "2층", guide_image: "guide_7", hint: "누리관 1층에 들어가자마자 오른쪽으로 꺾어보세요. 처음보는 비상계단이 나올거에요.", index: 7, location_image: "location_7", spot_name: "취업경력개발팀", succes_check: false)]
    
    var completeList = [missions]()
    var completeCheck = [Int]()
    var now = 0
    
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
        $0.text = "슈니, 안녕하세요!"
        $0.font = UIFont.systemFont(ofSize: 30.0, weight: .bold)
    }
    
    //MARK: -- Profile
    let profileImage = UIImageView().then{
        $0.image = UIImage(named: "swunie")
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
    
    
    let goToMissionButton = myButton().then{
        $0.setTitle("미션하러 가기", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 18.0)
        $0.setTitleColor(.darkGray, for: .normal)
        $0.backgroundColor = .white
        $0.addTarget(self, action: #selector(MissionBtnTapped), for: .touchUpInside)
    }
    
    
    //MARK: -- Status
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
    
    
    //MARK: -- Activity
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
    
    //collection view
    let cellID = "Cell"

    let completeMissionCollectionView: UICollectionView = {
        let flowlayout = UICollectionViewFlowLayout()
        let  cv = UICollectionView(frame: .zero, collectionViewLayout: flowlayout)
        
        return cv
    }()
    
    //MARK: -- Footer
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
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = ""
        view.backgroundColor = UIColor(named: "graybackground")
        
        //makeList
        self.completeList = dbData.filter{$0.succes_check == true}
        
        for i in completeList{
            completeCheck.append(i.index)
        }
        now = completeCheck.max()! + 1
        
        view.addSubview(headerView)
        headerView.addSubview(welcomeLevel)
        headerView.addSubview(welcomeName)
        
        
        view.addSubview(profileImage)
        view.addSubview(profileName)
        view.addSubview(profileStatus)
        view.addSubview(goToMissionButton)
        
        view.addSubview(statusTitle)
        view.addSubview(statusView)
        statusView.addSubview(nowLevel)
        statusView.addSubview(statusProgress)
        statusView.addSubview(succesMission)
        statusView.addSubview(totalMission)
        statusView.addSubview(nextLevel)
        
        activityView.addSubview(activityKind)
        activityView.addSubview(completeMissionCollectionView)
        view.addSubview(activityTitle)
        view.addSubview(activityView)
        
        
        //collection view 권한 부여
        self.completeMissionCollectionView.dataSource = self
        self.completeMissionCollectionView.delegate = self
        self.completeMissionCollectionView.translatesAutoresizingMaskIntoConstraints = false
        self.completeMissionCollectionView.register(ActivityCell.self, forCellWithReuseIdentifier: cellID)
        
        view.addSubview(footerView)
        footerView.addSubview(logoutButton)
        footerView.addSubview(exitButton)
        
        headerLayout()
        mainLayout()
        statusLayout()
        activityLayout()
        footerLayout()
    }
    
    //Btn tapped
    @objc func MissionBtnTapped(){
        let missionVC = MissionViewController()
        missionVC.dbData = dbData
        missionVC.now = now
        missionVC.completeCheck = completeCheck
        missionVC.completeList = completeList
        self.navigationController?.pushViewController(missionVC, animated: true)
        
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
            $0.bottom.equalToSuperview().offset(-25)            
        }
    }
    
    func mainLayout(){
        profileImage.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalTo(headerView.snp.bottom).offset(20)
            $0.width.equalTo(80)
            $0.height.equalTo(80)
            
        }
        profileName.snp.makeConstraints{
            $0.centerY.equalTo(profileImage).offset(-10)
            $0.leading.equalTo(profileImage.snp.trailing).offset(20)
            
        }
        profileStatus.snp.makeConstraints{
            $0.top.equalTo(profileName.snp.bottom).offset(10)
            $0.leading.equalTo(profileImage.snp.trailing).offset(20)
        }
        goToMissionButton.snp.makeConstraints{
            $0.top.equalTo(profileImage.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.centerX.equalToSuperview()
        }
        
    }
    
    func statusLayout(){
        
        statusTitle.snp.makeConstraints{
            $0.top.equalTo(goToMissionButton.snp.bottom).offset(20)
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
        
        completeMissionCollectionView.snp.makeConstraints{
            $0.top.equalTo(activityKind.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(10)
            $0.bottom.equalToSuperview().offset(-10)
            $0.trailing.equalToSuperview().offset(-10)
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

//MARK: -- Extension
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! ActivityCell
        //        cell.backgroundColor = .red
        cell.backgroundView = UIImageView(image: UIImage(named: "activityImage"))
        return cell
    }
    
    
}

extension ViewController: UICollectionViewDelegate {
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width-30) / 4, height: (collectionView.frame.width-30) / 4)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
