//
//  MissionViewController.swift
//  dicSWUnary
//
//  Created by 김주은 on 2022/03/16.
//

import UIKit
import Firebase
import FirebaseDatabase
import CodableFirebase
import CoreData

class MissionViewController: UIViewController{
    private let ref: DatabaseReference! = Database.database().reference()
//    var dbData = [missions]()
//    var dbData = [missions(advise: "졸업 사진 스팟", building_name: "정문", floor: "X", guide_image: "guide0", hint: "서울여대의 얼굴", index: 0, location_image: "location_0", spot_name: "학교 마크", succes_check: true),
//                  missions(advise: "수업 전 강의 자료 출력은 필수!", building_name: "building1", floor: "B1", guide_image: "guide1", hint: "연못 옆에 문 있어요", index: 1, location_image: "location_1", spot_name: "spot1", succes_check: true),
//                  missions(advise: "불닭 드실?", building_name: "50주년 기념관", floor: "1층", guide_image: "guide_2", hint: "어디서 맛있는 냄새 나요", index: 2, location_image: "location_2", spot_name: "CU 편의점", succes_check: true),
//                  missions(advise: "재학증명서 출력이 가능해요!", building_name: "인사관", floor: "1층", guide_image: "guide_3", hint: "주문하는 거에요?", index: 3, location_image: "location_3", spot_name: "키오스크", succes_check: false),
//                  missions(advise: "zoom 강의 들을 수 있어요!", building_name: "도서관", floor: "1층", guide_image: "guide_4", hint: "신발 벗어야 돼요?", index: 4, location_image: "location_4", spot_name: "슈니마루", succes_check: true),
//                  missions(advise: "전공 서적을 찾아 보세요!", building_name: "도서관", floor: "4층", guide_image: "guide_5", hint: "전공 책 꼭 사야돼?", index: 5, location_image: "location_5", spot_name: "자연과학 자료실", succes_check: false),
//                  missions(advise: "갑자기 편지를 쓰고 싶다거나..?", building_name: "누리관", floor: "1층", guide_image: "guide_6", hint: "박스 사러 더 많이 갈 듯?", index: 6, location_image: "location_6", spot_name: "우체국", succes_check: false),
//                  missions(advise: "졸업하려면 한 번은 가야 합니다!", building_name: "누리관", floor: "2층", guide_image: "guide_7", hint: "@swu_career", index: 7, location_image: "location_7", spot_name: "취경팀", succes_check: false)]

    let completeList = [0,1,2,3,4] //미션 완료 목록
    var now = 5
    
    let degreeLabel = UILabel()
    
    let questCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .horizontal
        
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .none
        cv.isScrollEnabled = false
        return cv
    }()
    
    let locationLabel = UILabel()
    
    let detailLocationLabel = UILabel()
    
    let missionImage = UIImageView()
    
    let bottomCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .horizontal
        
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .none
        cv.isScrollEnabled = false
        return cv
    }()
    
    let hintBtn = reusableBtnView().then{
        $0.BtnViewLayout()
        $0.BtnImage.setImage(UIImage(named: "hintBtnImage"), for: .normal)
        $0.BtnLabel.text = "Hint"
    }
    
    let locationBtn = reusableBtnView().then{
        $0.BtnViewLayout()
        $0.BtnImage.setImage(UIImage(named: "locationBtnImage"), for: .normal)
        $0.BtnLabel.text = "Location"
    }
    
    let photoSubmitBtn = reusableBtnView().then{
        $0.BtnViewLayout()
        $0.isUserInteractionEnabled = true
        $0.BtnImage.setImage(UIImage(named: "photoBtnImage"), for: .normal)
        $0.BtnLabel.text = "Photo"
    }
    
    let imagePickerController = UIImagePickerController().then{
        $0.sourceType = .camera
    }
    
    let bottomContentView = UIImageView()
    
    let submitImage = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Mission view loaded")
//        readData()
//    advise: "졸업 사진 스팟", building_name: "정문", floor: "X", guide_image: "guide0", hint: "서울여대의 얼굴", index: 0, location_image: "location_0", spot_name: "학교 마크", succes_check: true
        saveNewMission(0, buildingName: "정문", spotName: "학교 마크", floor: "0", guideImage: "guide0", hint: "서울여대의 얼굴", locationImage: "location_0", advise: "졸업 사진 스팟", complete: false)
        getAllMission()
       
        
//        updateLabel()
        self.view.backgroundColor = .black
        
//        self.questCollectionView.isUserInteractionEnabled = true
        subViews(thisView: self.view)
        determineDegree(completeCnt: 1)
        determineMissionImage(questNum: 1)
        suggestLocation(questNum: 1)
        allLayout()
        self.bottomCollectionView.isUserInteractionEnabled = true
        self.bottomCollectionView.register(BottomCollectionViewCell.self, forCellWithReuseIdentifier: "BottomCollectionViewCell")
        self.questCollectionView.register(reusableCollectionViewCell.self,
                                          forCellWithReuseIdentifier: "reusableCollectionViewCell")
        self.imagePickerController.delegate = self
        
        self.bottomCollectionView.delegate = self
        self.bottomCollectionView.dataSource = self
        self.questCollectionView.delegate = self
        self.questCollectionView.dataSource = self

    }
    
//    func readData(){
//            self.ref.getData { [self](error, snapshot) in
//                if let error = error {
//                    print("Error getting data \(error)")
//                }
//                else if snapshot.exists() {
//                    //                        print("Got data \(snapshot.value!)")
//                    //                        print("ttt \(type(of: snapshot.value!))")
//                    guard let value = snapshot.value else {return}
//                    do {
//                        let missions = try FirebaseDecoder().decode([missions].self, from: value)
//                        self.dbData = missions
//                        print(dbData)
//
//                    } catch let err {
//                        print (err)
//                    }
//                }
//                else {
//                    print("No data available")
//                }
//            } 
//    }
    
    fileprivate func getAllMission() {
        let missions: [Quests] = CoreDataManager.shared.getMissions()
        let missionIndex: [Int16] = missions.map({$0.index})
        let missionBuilding: String? = missions.filter({$0.index == 0}).first?.buildingName
        print("allMission = \(missionIndex)")
        print("Building Name = \(missionBuilding)")
        }
    // 새로운 유저 등록
    fileprivate func saveNewMission(_ index: Int16, buildingName: String,spotName: String, floor: String, guideImage: String, hint: String, locationImage : String, advise : String, complete : Bool) {
        CoreDataManager.shared.saveMission(index: index, buildingName: buildingName, spotName: spotName, floor: floor, guideImage: guideImage, hint: hint, locationImage: locationImage, advise: advise, complete: complete){
        onSuccess in print("saved = \(onSuccess)")
            }
        }
    
    func determineMissionImage(questNum: Int){
        missionImage.image = UIImage(named: "missionImage")
    }
    
    func determineDegree(completeCnt : Int) {
        degreeLabel.font = UIFont(name: "tway_sky", size: 15)
        if completeCnt == 0{
            degreeLabel.text = "삐약삐약 새내기🐥"
        }else if completeCnt <= 3{
            degreeLabel.text = "에헴! 나도 이제 학사🎓"
        }else if completeCnt <= 6{
            degreeLabel.text = "척척석사🧑🏻‍🎓"
        } else {
            degreeLabel.text = "서울여대 박사🧑🏻‍⚕️"
        }
    }
    
    
    func suggestLocation(questNum : Int){
        locationLabel.font = UIFont(name: "tway_sky", size: 25)
        locationLabel.text = "중앙도서관"
    }
    
    func subViews(thisView : UIView){
        thisView.addSubview(degreeLabel)
        thisView.addSubview(questCollectionView)
        thisView.addSubview(locationLabel)
        thisView.addSubview(detailLocationLabel)
        thisView.addSubview(missionImage)
        thisView.addSubview(bottomCollectionView)
        thisView.addSubview(bottomContentView)
    }
    
    func allLayout(){
        print(#function)
        
        degreeLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(16)
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(self.view.safeAreaLayoutGuide.layoutFrame.height / 25)
        }
        questCollectionView.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.top.equalTo(degreeLabel.snp.bottom).offset(16)
            $0.height.equalTo(90)
            $0.height.equalTo(self.view.safeAreaLayoutGuide.layoutFrame.height / 10)
        }
        locationLabel.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(questCollectionView.snp.bottom).offset(8)
            $0.height.equalTo(self.view.safeAreaLayoutGuide.layoutFrame.height / 23)
        }
        missionImage.snp.makeConstraints{
            $0.top.equalTo(locationLabel.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().offset(8)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(self.view.safeAreaLayoutGuide.layoutFrame.height / 4.3)
        }
        
        bottomCollectionView.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(missionImage.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(40)
            $0.trailing.equalToSuperview().offset(-40)
            $0.height.equalTo(150)
            $0.height.equalTo(self.view.safeAreaLayoutGuide.layoutFrame.height / 10)
        }
        bottomContentView.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            $0.top.equalTo(bottomCollectionView.snp.bottom).offset(10)
            $0.height.equalTo(missionImage.snp.height)
        }
    }
}


extension MissionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func questCell(cell: reusableCollectionViewCell, index : Int){
        cell.allFuncs()
        cell.stepBtn.tag = index
//        cell.testFunc(inp : cell.touchedItem)
        cell.stepLabel.text = String(index + 1)
        if completeList.contains(index){
            cell.stepBtn.setImage(UIImage(named: "completeImage"), for: .normal)
        }
        else {
            cell.stepBtn.setImage(UIImage(named: "notYetImage"), for: .normal)
        }
        if now == index  {
            cell.backgroundView = UIImageView(image: UIImage(named: "nowImage"))
            //            cell.backGroundImage = UIImage(named: "nowImage")!
        }
    }
    
    func bottomCell(cell: BottomCollectionViewCell, index: Int){
        let btnLabelList = ["Hint", "Location", "Photo"]
        let btnImageList = ["hintBtnImage", "locationBtnImage", "photoBtnImage"]
        
        cell.allFuncs()
        cell.bottomBtn.setBackgroundImage(UIImage(named: btnImageList[index]), for: .normal)
        cell.bottomBtnLabel.text = btnLabelList[index]
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    // 옆 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        var interItem = CGFloat(0)
        if collectionView == questCollectionView{
            interItem = CGFloat(1)
        }
        else {
            interItem = CGFloat(130)
        }
        return interItem
    }
    
    // cell 사이즈( 옆 라인을 고려하여 설정 )
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var size = CGSize(width: 0, height: 0)
        
        if collectionView == questCollectionView{
            let width = collectionView.frame.width / 9 - 1
            let height = collectionView.frame.height - 20
            size = CGSize(width: width, height: height)
        }
        
        if collectionView == bottomCollectionView{
            let width = collectionView.frame.width / 3 - 1
            let height = collectionView.frame.height
            size = CGSize(width: width, height: height)
        }
        
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var cellNum = 0
        if collectionView == bottomCollectionView{
            cellNum = 3
        }
        
        if collectionView == questCollectionView{
            cellNum = 8
        }
        return cellNum
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if collectionView == questCollectionView {
//            missionImage.image = UIImage(named: dbData[indexPath.row].guide_image)
//        }
        if collectionView == bottomCollectionView {
            if indexPath.row == 0{
                print("hint")
//                bottomContentView.image = UIImage(named: dbData[indexPath.row].guide_image)
            }
            if indexPath.row == 1{
                print("location")
                bottomContentView.image = UIImage(named: "location0")
                
            }
            if indexPath.row == 2{
                print("photo")
                present(self.imagePickerController, animated: true, completion: nil)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        
        if collectionView == questCollectionView {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reusableCollectionViewCell", for: indexPath) as! reusableCollectionViewCell
            questCell(cell: cell as! reusableCollectionViewCell, index: indexPath.row)

        }
        
        if collectionView == bottomCollectionView {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BottomCollectionViewCell", for: indexPath) as! BottomCollectionViewCell
            bottomCell(cell: cell as! BottomCollectionViewCell, index: indexPath.row)
        }
        
        return cell
    }
}

extension MissionViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        guard let image = info[.originalImage] as? UIImage else {
            print("No image found")
            return
        }
        
        // print out the image size as a test
        bottomContentView.image = image
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}
