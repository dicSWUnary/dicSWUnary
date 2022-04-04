//
//  MissionViewController.swift
//  dicSWUnary
//
//  Created by 이규빈 on 2022/03/16.
//

import UIKit

class MissionViewController: UIViewController{
    
    let completeList = [0,1,2,3,4] //미션 완료 목록
    var now = 5
    
    let degreeLabel = UILabel()
    //        .then{
    //        $0.font = UIFont(name: "twayair", size: 20)
    //    }
    
    //    var questCollectionView = UICollectionView()
    
    let questCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .horizontal
        
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .none
        cv.isScrollEnabled = false
        return cv
    }()
    
//    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MissionViewController.dismissKeyboard))
//
//    @objc func dismissKeyboard() {
//        view.endEditing(true)
//    }
    
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
        self.view.backgroundColor = .black
        self.questCollectionView.isUserInteractionEnabled = true
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
    
    func determineMissionImage(questNum: Int){
        missionImage.image = UIImage(named: "missionImage")
    }
    
    func determineDegree(completeCnt : Int) {
        //        for i in UIFont.familyNames{
        //            print(i)
        //        }
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
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(16)
        }
        questCollectionView.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.top.equalTo(degreeLabel.snp.bottom).offset(16)
            $0.height.equalTo(90)
        }
        locationLabel.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(questCollectionView.snp.bottom).offset(16)
        }
        missionImage.snp.makeConstraints{
            $0.top.equalTo(locationLabel.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        bottomCollectionView.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(missionImage.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(40)
            $0.trailing.equalToSuperview().offset(-40)
            $0.height.equalTo(150)
        }
    }
}


extension MissionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func questCell(cell: reusableCollectionViewCell, index : Int){
        cell.allFuncs()
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
            let height = collectionView.frame.height - 20
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
//    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
//        return false
//    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        collectionView.delaysContentTouches = false
        if collectionView == bottomCollectionView {
            if indexPath.row == 0{
                print("hint")
            }
            if indexPath.row == 1{
                print("location")
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
//            if indexPath.row == 2{
//                present(self.imagePickerController, animated: true, completion: nil)
//            }
        }
        
        return cell
    }
}

extension MissionViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {submitImage.image = image }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}
