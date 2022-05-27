//
//  ViewController.swift
//  dicSWUnary
//
//  Created by JUEUN KIM on 2022/03/16.
//

import UIKit
import SnapKit
import Then


class ViewController: UIViewController{
    
    let displayView = UIView().then{
        $0.setRounded(radius: 15)
        $0.backgroundColor = UIColor(red: 38/256, green: 38/256, blue: 38/256, alpha: 1)
    }
//    wndms9810@swu.ac.kr
    var initData = [missions(advise: "정문에 위치한 서울여대의 마크! 졸업 사진 스팟이에요!", building_name: "정문", floor: "건물 외부", guide_image: "guide_0", hint: "정문을 통해서 50주년으로 가볼까요?", index: 0, location_image: "location_0", spot_name: "학교 마크", succes_check: false),
                    
                    missions(advise: "재학증명서, 장학금 수혜증명서 등 다양한 증명서 출력이 저렴한 가격에 가능해요!", building_name: "인문사회관", floor: "1층", guide_image: "guide_1", hint: "인문사회관 내부에서 땅콩계단 방향을 바라보세요" , index: 1, location_image: "location_1", spot_name: "키오스크", succes_check: false),
                    
                    missions(advise: "쉬는 시간에 빠르게 한 끼를 해결할 수 있어요" , building_name: "인문사회관" , floor: "1층", guide_image: "guide_2", hint: "땅콩계단에서 인사관을 바라보면 보일거에요", index: 2, location_image: "location_2", spot_name: "GS25", succes_check: false),
                    
                    missions(advise: "좌석확정이 필요한 경우 이 키오스크를 사용해보세요.", building_name: "도서관", floor: "1층", guide_image: "guide_3", hint: "큰 계단바로 옆에 위치해있어요!", index: 3, location_image: "location_3", spot_name: "도서관 키오스크", succes_check: false),
                    
                    missions(advise: "학기 초에 한 학기 대여를 신청하면, 책 값을 아낄 수 있어요.", building_name: "도서관", floor: "4층", guide_image: "guide_4", hint: "엘리베이터는 비상계단 앞에 있어요! 그걸 타고 올라가볼까요?", index: 4, location_image: "location_4", spot_name: "자연과학 자료실", succes_check: false),
                    
                    missions(advise: "우리학교 식당들이 모여있는 곳, 많은 슈니들의 최애는 크림돈까스" , building_name: "학생누리관", floor: "지하 1층", guide_image: "guide5", hint: "도서관에서 누리관으로 이동한다면 금방 도착할 수 있어요.", index: 5, location_image: "location_5", spot_name: "구시아", succes_check:false),
                    
                    missions(advise: "편지나 서류를 보내고 싶다면 서울여대 우체국을 이용해보세요", building_name: "학생누리관", floor: "1층", guide_image: "guide_6", hint: "누리관에서 우리은행을 지나 쭉 들어와보세요.", index: 6, location_image: "location_6", spot_name: "우체국", succes_check: false),
                    
                    missions(advise: "1학년부터 4학년 모두를 위한 취업 프로그램이 준비되어있으니, 저학년일 때부터 많이 이용해보세요.", building_name: "학생누리관", floor: "2층", guide_image: "guide_7", hint: "누리관 1층에 들어가자마자 오른쪽으로 꺾어보세요. 처음보는 비상계단이 나올거에요.", index: 7, location_image: "location_7", spot_name: "취업경력개발팀", succes_check: false)]
    
    var dbData = [missions]()
    var completeList = [missions]()
    var completeCheck = [Int]()
    var now = 0
    
    //MARK: - Profile
    let welcomeName = UILabel().then{
        $0.text = ">>슈니, 반가워요!🐥"
        $0.font = UIFont(name: "NeoDunggeunmoCode-Regular", size: 35)
        $0.textColor = .white
    }
    
    //MARK: - Status
    //재학상태
    
    let statusTitle = UILabel().then{
        $0.textColor = .white
        $0.text = ">>재학 상태"
        $0.font = UIFont(name: "NeoDunggeunmoCode-Regular", size: 20)
    }
    
    var statusImage = UIImageView().then{
        $0.image = UIImage(named: "group6")
    }
    
    let statusView = UIView().then{
        $0.backgroundColor = UIColor(red: 38/256, green: 38/256, blue: 38/256, alpha: 1)
        $0.layer.cornerRadius = 4
    }
    let nowLevel = UILabel().then{
        $0.text = "🐥\n새내기"
        $0.textColor = .white
        $0.font = UIFont(name: "NeoDunggeunmoCode-Regular", size: 18)
        $0.lineBreakMode = .byWordWrapping
        $0.numberOfLines = 0
        $0.textAlignment = .center
    }
    let nextLevel = UILabel().then{
        $0.text = "🎓\n박사"
        $0.textColor = .white
        $0.font = UIFont(name: "NeoDunggeunmoCode-Regular", size: 18)
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
//        $0.text = "3"
        $0.textColor = UIColor(named: "progressBlue")
        $0.font = UIFont.systemFont(ofSize: 12.0)
    }
    let totalMission = UILabel().then{
        $0.text = "/8"
        $0.textColor = .white
        $0.font = UIFont(name: "NeoDunggeunmoCode-Regular", size: 14)
    }
    
    
    //MARK: - Activity
    let activityTitle = UILabel().then{
        $0.textColor = .white
        $0.text = ">>대외 활동"
        $0.font = UIFont(name: "NeoDunggeunmoCode-Regular", size: 20)
    }
    let activityView = UIView().then{
        UIColor(red: 38/256, green: 38/256, blue: 38/256, alpha: 1)
        $0.layer.cornerRadius = 4
    }
    let activityImage = UIImageView().then{
        $0.image = UIImage(named: "group8")
    }
    let activityKind = UILabel().then{
        $0.textColor = .white
        $0.text = "🔥완료한 미션"
        $0.font = UIFont(name: "NeoDunggeunmoCode-Regular", size: 18)
    }
    
    //collection view
    let cellID = "Cell"

    let completeMissionCollectionView: UICollectionView = {
        let flowlayout = UICollectionViewFlowLayout()
        let  cv = UICollectionView(frame: .zero, collectionViewLayout: flowlayout)
        flowlayout.scrollDirection = .horizontal
        cv.isScrollEnabled = true
        cv.backgroundColor = UIColor(red: 38/256, green: 38/256, blue: 38/256, alpha: 1)
        return cv
    }()
    
    //MARK: - Footer
    let goToMissionButton = UIButton().then{
        $0.isUserInteractionEnabled = true
        $0.isEnabled = true
        $0.setTitle(">>미션하러 가기", for: .normal)
        $0.titleLabel?.font = UIFont(name: "NeoDunggeunmoCode-Regular", size: 35)
        $0.setTitleColor(UIColor(named: "vcYellow"), for: .normal)
        $0.addTarget(self, action: #selector(MissionBtnTapped), for: .touchUpInside)
    }
    
    let stickBackground = UIImageView().then{
        $0.image = UIImage(named: "stickBackground")
    }
    
    let vcStick = UIButton().then{
        $0.setImage(UIImage(named: "vcStick"), for: .normal)
    }

    let vcButton = UIButton().then{
        $0.setImage(UIImage(named: "vcButton"), for: .normal)
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        now = 8
            if now == 8 {
                let childVC = CertificationViewController()
                childVC.modalPresentationStyle = .fullScreen
                self.present(childVC, animated: false, completion: nil)
            }
        getAllMission()
        var tempCompleteList = [missions]()
        var tempCompleteCheck = [Int]()
        tempCompleteList = dbData.filter{$0.succes_check == true}
        
        for i in tempCompleteList{
            tempCompleteCheck.append(i.index)
        }
        
        completeList = tempCompleteList
        completeCheck = tempCompleteCheck
        now = completeCheck.count

        determineProgress()
        completeMissionCollectionView.reloadInputViews()
        completeMissionCollectionView.reloadData()
    }
    
    let defaults = UserDefaults.standard
    
    //MARK: -LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        dbData = initData
        checkFirstOrnot()
        getAllMission()
        navigationItem.title = ""
        self.view.backgroundColor = UIColor(red: 147/256, green: 123/256, blue: 167/256, alpha: 1)
        
        //makeList
        self.completeList = dbData.filter{$0.succes_check == true}
        
        for i in completeList{
            completeCheck.append(i.index)
        }
        now = completeCheck.count
        
        determineProgress()


        //Layout
        addView()
        mainLayout()
        statusLayout()
        activityLayout()
        footerLayout()

        
        //collection view 권한 부여
        self.completeMissionCollectionView.dataSource = self
        self.completeMissionCollectionView.delegate = self
        self.completeMissionCollectionView.translatesAutoresizingMaskIntoConstraints = false
        self.completeMissionCollectionView.register(ActivityCell.self, forCellWithReuseIdentifier: cellID)
    }
    
//MARK: - HELPER
    func checkFirstOrnot(){
        if defaults.bool(forKey: "dbDownLoad") == true {
            print("Second+")
            defaults.set(true, forKey: "dbDownLoad")
        } else {
            print("here is init init ", initData)
            
            for i in initData{
                saveNewMission(Int16(i.index), buildingName: i.building_name, spotName: i.spot_name, floor: i.floor, guideImage: i.guide_image, hint: i.hint, locationImage: i.location_image, advise: i.advise, complete: i.succes_check)
            }
            
            print("dbDownLoad")
            defaults.set(true, forKey: "dbDownLoad")
        }
    }
    
//    func checkDBDownload(){
//        if defaults.bool(forKey: "db Down") == true {
//            print("Second+")
//            defaults.set(true, forKey: "db Down")
//        } else {
//            print("here is init init ", initData)
//
//            for i in initData{
//                print("saved 했어 했었!!!!!")
//                saveNewMission(Int16(i.index), buildingName: i.building_name, spotName: i.spot_name, floor: i.floor, guideImage: i.guide_image, hint: i.hint, locationImage: i.location_image, advise: i.advise, complete: i.succes_check)
//            }
//
//            print("First")
//            defaults.set(true, forKey: "db Down")
//        }
//    }
    
    
    //Btn tapped
    @objc func MissionBtnTapped(){
        print("I am tapped")
        let missionVC = MissionViewController()
        missionVC.dbData = dbData.reversed()
        missionVC.now = now
        print("now is ", now)
        missionVC.completeCheck = completeCheck
        missionVC.completeList = completeList
        
//        self.navigationController?.pushViewController(<#T##viewController: UIViewController##UIViewController#>, animated: <#T##Bool#>)
//        nowNavi.viewControllers  = [missionVC]
//        nowNavi.pushViewController(missionVC, animated: false)

        self.navigationController?.pushViewController(missionVC, animated: true)
        
    }
    
    func addView(){
        view.addSubview(displayView)
        view.addSubview(welcomeName)
        view.addSubview(goToMissionButton)
        
        view.addSubview(statusView)
        view.addSubview(statusImage)
        view.addSubview(statusTitle)
        statusView.addSubview(nowLevel)
        statusView.addSubview(statusProgress)
        statusView.addSubview(succesMission)
        statusView.addSubview(totalMission)
        statusView.addSubview(nextLevel)
        
        view.addSubview(activityTitle)
        view.addSubview(activityView)
        activityView.addSubview(completeMissionCollectionView)
        activityView.addSubview(activityImage)
        activityView.addSubview(activityKind)
        
        view.addSubview(stickBackground)
        stickBackground.addSubview(vcStick)
        stickBackground.addSubview(vcButton)
    }
    
    func determineProgress(){
        succesMission.text = String(now)
        statusProgress.progress = Float(now)/8
    }


    
    func mainLayout(){
        displayView.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview().offset(-140)
            $0.leading.equalToSuperview().offset(7)
            $0.trailing.equalToSuperview().offset(-7)
        }
        
        welcomeName.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.centerX.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(1.0 / 10.0)
        }
    }
    
    func statusLayout(){
        
        statusTitle.snp.makeConstraints{
            $0.top.equalTo(statusImage.snp.top).offset(10)
            $0.leading.equalToSuperview().offset(25)
        }
        
        statusImage.snp.makeConstraints{
            $0.top.equalTo(welcomeName.snp.bottom).offset(30)
            $0.leading.equalToSuperview().offset(15)
            $0.trailing.equalToSuperview().offset(-15)
            $0.height.equalToSuperview().multipliedBy(1.0 / 7.0)
        }
        
        statusView.snp.makeConstraints{
            $0.top.equalTo(statusTitle.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(15)
            $0.trailing.equalToSuperview().offset(-15)
            $0.height.equalToSuperview().multipliedBy(1.0 / 10.0)
        }
        nowLevel.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(10)
            
        }
        statusProgress.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(nowLevel.snp.trailing).offset(10)
            $0.trailing.equalTo(nextLevel.snp.leading).offset(-10)
            $0.height.equalToSuperview().multipliedBy(1.0/5.0)
            
            
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
            $0.leading.equalToSuperview().offset(25)
            $0.bottom.equalTo(activityView.snp.top).offset(-10)
        }
        
        activityImage.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(5)
            $0.bottom.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-5)
            
        }
        activityView.snp.makeConstraints{
            $0.top.equalTo(activityTitle.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().offset(-10)
            $0.height.equalToSuperview().multipliedBy(1.0 / 5.0)
        }
        activityKind.snp.makeConstraints{
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().offset(25)
        }
        
        completeMissionCollectionView.snp.makeConstraints{
            $0.top.equalTo(activityKind.snp.bottom).offset(0)
            $0.leading.equalToSuperview().offset(25)
            $0.bottom.equalToSuperview().offset(-20)
            $0.trailing.equalToSuperview().offset(-25)
        }
    }
    
    
    func footerLayout(){
        
        goToMissionButton.snp.makeConstraints{
            $0.top.equalTo(activityView.snp.bottom).offset(60)
            $0.leading.equalToSuperview().offset(20)
            $0.bottom.equalTo(displayView.snp.bottom).offset(-70)
            $0.trailing.equalToSuperview().offset(-20)
            $0.centerX.equalToSuperview()
        }
        
        stickBackground.snp.makeConstraints{
            $0.top.equalTo(displayView.snp.bottom).offset(20)
            $0.leading.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        vcStick.snp.makeConstraints{
            $0.top.equalTo(goToMissionButton.snp.bottom).offset(50)
            $0.leading.equalToSuperview().offset(76)
            $0.bottom.equalToSuperview().offset(-50)
            $0.trailing.equalTo(vcButton.snp.leading).offset(-50)
        }
        vcButton.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.leading.equalTo(vcStick.snp.trailing).offset(50)
            $0.bottom.equalToSuperview().offset(-20)
            $0.trailing.equalToSuperview().offset(-50)
        }
    }
    
    // 새로운 유저 등록
    fileprivate func saveNewMission(_ index: Int16, buildingName: String,spotName: String, floor: String, guideImage: String, hint: String, locationImage : String, advise : String, complete : Bool) {
        CoreDataManager.shared.saveMission(index: index, buildingName: buildingName, spotName: spotName, floor: floor, guideImage: guideImage, hint: hint, locationImage: locationImage, advise: advise, complete: complete){
        onSuccess in print("saved = \(onSuccess)")
            }
        }
    
    fileprivate func getAllMission() {
        let missions: [Quests] = CoreDataManager.shared.getMissions()
        for i in 0...7 {
            dbData[i].advise = missions[i].advise!
            dbData[i].floor = missions[i].floor!
            dbData[i].index = Int(missions[i].index)
            dbData[i].building_name = missions[i].buildingName!
            dbData[i].spot_name = missions[i].spotName!
            dbData[i].guide_image = missions[i].guideImage!
            dbData[i].hint = missions[i].hint!
            dbData[i].location_image = missions[i].locationImage!
            dbData[i].succes_check = missions[i].complete
//            dbData[i].advise = missions[i].advise
        }
        let missionIndex: [Int16] = missions.map({$0.index})
        let missionBuilding: String? = missions.filter({$0.index == 0}).first?.buildingName
//        print("allMission = \(missionIndex)")
//        print("Building Name = \(missionBuilding)")
        print("allData")

        }
    
    
}

//MARK: -- Extension
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return completeList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! ActivityCell
        if (completeCheck.contains(indexPath.row)) {
            cell.backgroundView = UIImageView(image: UIImage(named: String(format: "guideImage%d", indexPath.row)))
            cell.backgroundView?.setRounded(radius: 15)
        }
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
