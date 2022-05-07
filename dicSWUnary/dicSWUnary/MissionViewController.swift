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
    
    var dbData =  [missions]()
    let displayView = UIView().then{
        $0.setRounded(radius: 15)
        $0.backgroundColor = UIColor(red: 38/256, green: 38/256, blue: 38/256, alpha: 1)
    }
    
    var completeList = [missions]() //미션 완료 목록
    var completeCheck = [Int]()
    var now = Int()
    var imageLength = Int()

    let degreeLabel = UILabel().then{
        $0.text = "ddddddddd"
        $0.textColor = .white
    }
    
    let questCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.init(white: 1, alpha: 0)
        cv.isScrollEnabled = false
        return cv
    }()
    
    let locationLabel = UILabel().then{
        $0.font = UIFont(name: "NeoDunggeunmoCode-Regular", size: 35)
        $0.textColor = .white
    }
    
    let detailLocationLabel = UILabel().then{
        $0.font = UIFont(name: "NeoDunggeunmoCode-Regular", size: 25)
        $0.textColor = .white
    }
    
    let missionBorderImage = UIImageView().then{
        $0.image = UIImage(named: "missionBorderImage")
    }
    
    let missionImage = UIImageView().then{
        $0.setRounded(radius: 23)
    }
    
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
    
    let stickBackground = UIImageView().then{
        $0.image = UIImage(named: "stickBackground")
    }
    
    let imagePickerController = UIImagePickerController().then{
        $0.sourceType = .camera
        $0.allowsEditing = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if now == 8 {
            exit(0)
        }
        print("here is completeCheck ", completeCheck)
        determineDegree(completeCnt: completeCheck.count)
        determineMission(questNum: now)
        questCollectionView.reloadData()
    }
    //MARK: - LifeCycle : viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 147/256, green: 123/256, blue: 167/256, alpha: 1)
        print("here is the data ", dbData)
        imageLength = Int((self.view.safeAreaLayoutGuide.layoutFrame.width) - 100)
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
    func determineMission(questNum: Int){
        missionImage.image  = UIImage(named: String(format: "guideImage%d", questNum))
        locationLabel.text = dbData[questNum].building_name
        detailLocationLabel.text = dbData[questNum].spot_name
    }
    
    func determineDegree(completeCnt : Int) {
        degreeLabel.font = UIFont(name: "NeoDunggeunmoCode-Regular", size: 30)
        if completeCnt <= 3{
            degreeLabel.text = "삐약삐약 새내기🐥"
        } else if completeCnt <= 5{
            degreeLabel.text = "에헴! 나도 이제 학사🎓"
        } else if completeCnt <= 7{
            degreeLabel.text = "척척석사🧑🏻‍🎓"
        } else{
            degreeLabel.text = "서울여대 박사🧑🏻‍⚕️"
        }
    }
    
    func subViews(thisView : UIView){
//        thisView.addSubview(backgroundImage)
        thisView.addSubview(displayView)
        thisView.addSubview(locationLabel)
        thisView.addSubview(detailLocationLabel)
        thisView.addSubview(missionImage)
        thisView.addSubview(missionBorderImage)
        thisView.addSubview(stickBackground)
        thisView.addSubview(bottomCollectionView)
    }
    
    func makeUpperView(){
        view.addSubview(degreeLabel)
        view.addSubview(questCollectionView)
        
        degreeLabel.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.height.equalTo(self.view.safeAreaLayoutGuide.layoutFrame.height / 25)
        }
        questCollectionView.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.width.equalTo(self.view.frame.width - 50)
            $0.top.equalTo(degreeLabel.snp.bottom).offset(16)
            $0.height.equalTo(self.view.safeAreaLayoutGuide.layoutFrame.height / 10)
        }
    }
    
    func allLayout(){
        
        displayView.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(missionBorderImage.snp.bottom)
            $0.leading.equalToSuperview().offset(7)
            $0.trailing.equalToSuperview().offset(-7)
        }
        makeUpperView()
        
        locationLabel.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(questCollectionView.snp.bottom).offset(15)
            $0.height.equalTo(self.view.safeAreaLayoutGuide.layoutFrame.height / 23)
        }
        
        detailLocationLabel.snp.makeConstraints{
            $0.centerX.equalTo(locationLabel)
            $0.top.equalTo(locationLabel.snp.bottom)
            $0.height.equalTo(self.view.safeAreaLayoutGuide.layoutFrame.height / 23)
        }
        
        missionBorderImage.snp.makeConstraints{
            $0.top.equalTo(questCollectionView.snp.bottom).offset(5)
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(bottomCollectionView.snp.top)
            $0.leading.equalToSuperview().offset(15)
            $0.trailing.equalToSuperview().offset(-15)
        }
        
        missionImage.snp.makeConstraints{
            $0.top.equalTo(detailLocationLabel.snp.bottom).offset(3)
            $0.leading.equalTo(missionBorderImage.snp.leading).offset(15)
            $0.bottom.equalTo(missionBorderImage.snp.bottom).offset(-56)
            $0.trailing.equalTo(missionBorderImage.snp.trailing).offset(-15)
            $0.centerX.equalToSuperview()
        }
        
        stickBackground.snp.makeConstraints{
            $0.top.equalTo(displayView.snp.bottom).offset(20)
            $0.leading.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        bottomCollectionView.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-20)
            $0.leading.equalToSuperview().offset(40)
            $0.trailing.equalToSuperview().offset(-40)
            $0.height.equalTo(self.view.safeAreaLayoutGuide.layoutFrame.height / 7)
        }
    }
}


extension MissionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == questCollectionView{
            return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        }
        else {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
    func questCell(cell: reusableCollectionViewCell, index : Int){
        cell.allFuncs()
        cell.stepLabel.text = String(index + 1)
        
        if completeCheck.contains(index){
            cell.stepBtn.setImage(UIImage(named: "completeImage"), for: .normal)
        }
        else {
            cell.stepBtn.setImage(UIImage(named: "notYetImage"), for: .normal)
        }
        
        if now == index {
            cell.stepBtn.setImage(UIImage(named: "nowIndex"), for: .normal)
        }
        else {
            cell.backgroundView = .none
        }
    }
    
    func bottomCell(cell: BottomCollectionViewCell, index: Int){
        let btnLabelList = ["", "", ""]
        let btnImageList = ["hintStick", "locationStick", "cameraStick"]
        
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
            let height = collectionView.frame.height - 10
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
                missionImage.image = UIImage(named: String(format: "guideImage%d", indexPath.row))
                locationLabel.text = dbData[indexPath.row].building_name
                detailLocationLabel.text = dbData[indexPath.row].spot_name
//                var selected_idx = indexPath.row
            }
            else {
                showAlert(style: .alert, title: "Caution", text: "차례로 미션을 수행해주세요")
            }
        }
        else if collectionView == bottomCollectionView {
            if indexPath.row == 0{
                showAlert(style: .alert, title: "Hint",text: dbData[now].hint)
            }
            if indexPath.row == 1{
                showAlert(style: .alert, title: "Location", text: dbData[now].floor + "에 위치하고 있어요.")
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
        let predictImage = image

//        let predictedSpot = dicSWUnaryOutput.Element
//        print(predictedSpot)

        nextVC.submittedImage = image
        nextVC.dbData = dbData
        nextVC.now = now
        nextVC.imageLength = imageLength
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

