//
//  MissionViewController.swift
//  dicSWUnary
//
//  Created by 이규빈 on 2022/03/16.
//

import UIKit
import Firebase
import FirebaseDatabase


class MissionViewController: UIViewController{


    let db = Database.database().reference()
    
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
    
    let locationLabel = UILabel()
    
    let detailLocationLabel = UILabel()
    
    let missionImage = UIImageView()
    
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
    
    let bottomBtnsStackView = UIStackView().then{
        $0.distribution = .equalSpacing
        $0.isUserInteractionEnabled = false
    }
    
    let imagePickerController = UIImagePickerController().then{
        $0.sourceType = .camera
    }
    
    let thisView = UIView()
    
    let submitImage = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()


        updateLabel()
        
        self.questCollectionView.isUserInteractionEnabled = true
        self.view.backgroundColor = .white
        subViews(thisView: self.view)
        addArrangedSubView()
        determineDegree(completeCnt: 1)
        determineMissionImage(questNum: 1)
        suggestLocation(questNum: 1)
        allLayout()
        
        self.questCollectionView.register(reusableCollectionViewCell.self,
                                          forCellWithReuseIdentifier: "reusableCollectionViewCell")
//        self.questCollectionView.setCollectionViewLayout(layout, animated: true)
        self.imagePickerController.delegate = self
        self.questCollectionView.delegate = self
        self.questCollectionView.dataSource = self
        

    }
    
    func updateLabel(){
            db.child("1").observeSingleEvent(of: .value) {snapshot in
                print("---> \(snapshot)")
                let value = snapshot.value as? String ?? "" //2번째 줄
                DispatchQueue.main.async {
                    print(value)
                }
            }
        }
    
                                     
//    @objc func dismissSelf() {
//        dismiss(animated: true, completion: nil)
//    }

    func addArrangedSubView(){
        bottomBtnsStackView.addArrangedSubview(hintBtn)
        bottomBtnsStackView.addArrangedSubview(locationBtn)
        bottomBtnsStackView.addArrangedSubview(photoSubmitBtn)
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
        locationLabel.text = "중앙도서관"
    }
    
    func subViews(thisView : UIView){
        thisView.addSubview(degreeLabel)
        thisView.addSubview(questCollectionView)
        thisView.addSubview(locationLabel)
        thisView.addSubview(detailLocationLabel)
        thisView.addSubview(missionImage)
        thisView.addSubview(bottomBtnsStackView)
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
        
        bottomBtnsStackView.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(missionImage.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(40)
            $0.trailing.equalToSuperview().offset(-40)
        }
    }
}


extension MissionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return UICollectionViewFlowLayout.automaticSize
//    }
    // 위 아래 간격
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 1
        }

        // 옆 간격
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 1
        }

        // cell 사이즈( 옆 라인을 고려하여 설정 )
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

            let width = collectionView.frame.width / 9 - 1
            let height = collectionView.frame.height - 20
            let size = CGSize(width: width, height: height)
            return size
        }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reusableCollectionViewCell", for: indexPath) as! reusableCollectionViewCell
        cell.allFuncs()
        cell.stepLabel.text = String(indexPath.row + 1)
        if completeList.contains(indexPath.row){
            cell.stepBtn.setImage(UIImage(named: "completeImage"), for: .normal)
        }
        else {
            cell.stepBtn.setImage(UIImage(named: "notYetImage"), for: .normal)
        }
        if now == indexPath.row  {
            cell.backgroundView = UIImageView(image: UIImage(named: "nowImage"))
//            cell.backGroundImage = UIImage(named: "nowImage")!
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
