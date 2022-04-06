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
    var dbData = [missions]()

    var completeList = [missions]() //미션 완료 목록
    var completeCheck = [Int]()
    var now = 5
    var imageLength = 0
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
    
    let locationLabel = UILabel().then{
        $0.font = UIFont(name: "tway_sky", size: 25)
    }
    
    let detailLocationLabel = UILabel().then{
        $0.font = UIFont(name: "tway_sky", size: 18)
    }
    
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
        $0.allowsEditing = true
    }

    //MARK: - LifeCycle : viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        print("Mission view loaded")
//        readData()
//    advise: "졸업 사진 스팟", building_name: "정문", floor: "X", guide_image: "guide0", hint: "서울여대의 얼굴", index: 0, location_image: "location_0", spot_name: "학교 마크", succes_check: true
        saveNewMission(0, buildingName: "정문", spotName: "학교 마크", floor: "0", guideImage: "guide0", hint: "서울여대의 얼굴", locationImage: "location_0", advise: "졸업 사진 스팟", complete: false)
        getAllMission()

        
        imageLength = Int((self.view.safeAreaLayoutGuide.layoutFrame.width) - 100)
        self.view.backgroundColor = .black
        
        subViews(thisView: self.view)
        determineDegree(completeCnt: completeCheck.count)
        determineMission(questNum: now)
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
    

    //MARK: - Firebase 연동
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
    
    func determineMission(questNum: Int){
        missionImage.image  = UIImage(named: String(format: "guideImage%d", questNum))
        locationLabel.text = dbData[questNum].building_name
        detailLocationLabel.text = dbData[questNum].spot_name
    }
    
    func determineDegree(completeCnt : Int) {
        degreeLabel.font = UIFont(name: "tway_sky", size: 15)
        if completeCnt <= 3{
            degreeLabel.text = "삐약삐약 새내기🐥"
        } else if completeCnt <= 5{
            degreeLabel.text = "에헴! 나도 이제 학사🎓"
        } else if completeCnt <= 7{
            degreeLabel.text = "척척석사🧑🏻‍🎓"
        } else if completeCnt == 8{
            degreeLabel.text = "서울여대 박사🧑🏻‍⚕️"
        }
    }
    
    func subViews(thisView : UIView){
        thisView.addSubview(degreeLabel)
        thisView.addSubview(questCollectionView)
        thisView.addSubview(locationLabel)
        thisView.addSubview(detailLocationLabel)
        thisView.addSubview(missionImage)
        thisView.addSubview(bottomCollectionView)
//        thisView.addSubview(bottomContentView)
    }
    
    func allLayout(){
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
        detailLocationLabel.snp.makeConstraints{
            $0.centerX.equalTo(locationLabel)
            $0.top.equalTo(locationLabel.snp.bottom).offset(8)
        }
        missionImage.snp.makeConstraints{
            $0.top.equalTo(detailLocationLabel.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
//            $0.leading.equalToSuperview().offset(8)
//            $0.trailing.equalToSuperview().offset(-16)
            $0.width.equalTo(imageLength)
            $0.height.equalTo(imageLength)
        }
        
        bottomCollectionView.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(missionImage.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(40)
            $0.trailing.equalToSuperview().offset(-40)
            $0.height.equalTo(self.view.safeAreaLayoutGuide.layoutFrame.height / 10)
        }
//        bottomContentView.snp.makeConstraints{
//            $0.leading.equalToSuperview().offset(16)
//            $0.trailing.equalToSuperview().offset(-16)
//            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
//            $0.top.equalTo(bottomCollectionView.snp.bottom).offset(10)
//            $0.width.equalTo(imageLength)
//            $0.height.equalTo(imageLength)
//        }
    }
}


extension MissionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func questCell(cell: reusableCollectionViewCell, index : Int){
        cell.allFuncs()
        cell.stepBtn.tag = index
//        cell.testFunc(inp : cell.touchedItem)
        cell.stepLabel.text = String(index + 1)
        if completeCheck.contains(index){
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
        if collectionView == questCollectionView {
            if completeCheck.contains(indexPath.row) || indexPath.row == now {
                missionImage.image  = UIImage(named: String(format: "guideImage%d", indexPath.row))
                locationLabel.text = dbData[indexPath.row].building_name
                detailLocationLabel.text = dbData[indexPath.row].spot_name
            }
            else {
                showAlert(style: .alert, title: "Caution", text: "차례로 미션을 수행해주세요")
            }
        }
        else if collectionView == bottomCollectionView {
            if indexPath.row == 0{
                showAlert(style: .alert, title: "Hint",text: dbData[now].hint)
//                bottomContentView.image = UIImage(named: dbData[indexPath.row].guide_image)
            }
            if indexPath.row == 1{
                showAlert(style: .alert, title: "Location", text: dbData[now].floor + "에 위치하고 있어요.")
//                bottomContentView.image = UIImage(named: "location0")
                
            }
            if indexPath.row == 2{
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
        
        guard let image = info[.editedImage] as? UIImage else {
            print("No image found")
            return
        }
        let nextVC = SubmitViewController()
        nextVC.submittedImage = image
        nextVC.imageLength = imageLength
        self.navigationController?.pushViewController(nextVC, animated: true)

    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}
