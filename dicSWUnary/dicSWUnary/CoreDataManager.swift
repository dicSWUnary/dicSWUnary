//
//  CoreDataManager.swift
//  dicSWUnary
//
//  Created by 이규빈 on 2022/04/06.
//

import UIKit
import CoreData

class CoreDataManager {
    static let shared: CoreDataManager = CoreDataManager()
    
    let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
    lazy var context = appDelegate?.persistentContainer.viewContext
    
    let modelName: String = "Quests"
    
    func getMissions(ascending: Bool = false) -> [Quests] {
        var models: [Quests] = [Quests]()
        
        if let context = context {
            let indexSort: NSSortDescriptor = NSSortDescriptor(key: "index", ascending: ascending)
            let fetchRequest: NSFetchRequest<NSManagedObject>
                = NSFetchRequest<NSManagedObject>(entityName: modelName)
            fetchRequest.sortDescriptors = [indexSort]
            
            do {
                if let fetchResult: [Quests] = try context.fetch(fetchRequest) as? [Quests] {
                    models = fetchResult
                }
            } catch let error as NSError {
                print("Could not fetch🥺: \(error), \(error.userInfo)")
            }
        }
        return models
    }
    func retrieveData() -> [missions]{ guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
        else { return [missions]() }
        var newDB = [missions(advise: "정문에 위치한 서울여대의 마크! 졸업 사진 스팟이에요!", building_name: "정문", floor: "건물 외부", guide_image: "guide0", hint: "정문을 통해서 50주년으로 가볼까요?", index: 0, location_image: "location_0", spot_name: "학교 마크", succes_check: true),
                     missions(advise: "토익, 등본, 발표자료 등 프린트가 필요하다면 카피웍스를 이용해보세요.", building_name: "50주년 기념관", floor: "지하 1층", guide_image: "guide1", hint: "계단 옆 연못 옆을 볼까요?", index: 1, location_image: "location_1", spot_name: "카피웍스", succes_check: true),
                     missions(advise: "50주년 기념관 1층에서는 빠르게 식사를 해결할 수 있어요. 또 제공되는 테이블에서 과제 등을 해도 괜찮아요.", building_name: "50주년 기념관", floor: "1층", guide_image: "guide_2", hint: "빵 냄새를 따라가다보면 만날 수 있을지도?", index: 2, location_image: "location_2", spot_name: "CU 편의점", succes_check: false),
                     missions(advise: "재학증명서, 장학금 수혜증명서 등 다양한 증명서 출력이 저렴한 가격에 가능해요!", building_name: "인문사회관", floor: "1층", guide_image: "guide_3", hint: "인문사회관 내부에서 땅콩계단 방향을 바라보세요", index: 3, location_image: "location_3", spot_name: "키오스크", succes_check: false),
                     missions(advise: "유일한 좌식 좌석. 온돌이 깔려있어서 뜨뜻하게 공부할 수 있어요.", building_name: "도서관", floor: "1층", guide_image: "guide_4", hint: "좌석번호 178-181를 찾아보세요.", index: 4, location_image: "location_4", spot_name: "슈니마루", succes_check: false),
                     missions(advise: "학기 초에 한 학기 대여를 신청하면, 책 값을 아낄 수 있어요.", building_name: "도서관", floor: "4층", guide_image: "guide_5", hint: "엘리베이터는 비상계단 앞에 있어요! 그걸 타고 올라가볼까요?", index: 5, location_image: "location_5", spot_name: "자연과학 자료실", succes_check: false),
                     missions(advise: "편지나 서류를 보내고 싶다면 서울여대 우체국을 이용해보세요", building_name: "학생누리관", floor: "1층", guide_image: "guide_6", hint: "누리관에서 우리은행을 지나 쭉 들어와보세요.", index: 6, location_image: "location_6", spot_name: "우체국", succes_check: false),
                     missions(advise: "1학년부터 4학년 모두를 위한 취업 프로그램이 준비되어있으니, 저학년일 때부터 많이 이용해보세요.", building_name: "학생누리관", floor: "2층", guide_image: "guide_7", hint: "누리관 1층에 들어가자마자 오른쪽으로 꺾어보세요. 처음보는 비상계단이 나올거에요.", index: 7, location_image: "location_7", spot_name: "취업경력개발팀", succes_check: false)]
        var idx = 0
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Quests")
        do { let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject]{
                newDB[idx].advise = data.value(forKey: "advise") as! String
                newDB[idx].floor = data.value(forKey: "floor") as! String
                newDB[idx].index = data.value(forKey: "index") as! Int
                newDB[idx].building_name = data.value(forKey: "buildingName") as! String
                newDB[idx].spot_name = data.value(forKey: "spotName") as! String
                newDB[idx].guide_image = data.value(forKey: "guideImage") as! String
                newDB[idx].hint = data.value(forKey: "hint") as! String
                newDB[idx].location_image = data.value(forKey: "locationImage") as! String
                newDB[idx].succes_check = data.value(forKey: "complete") as! Bool
            }
        }
        catch {
            print("error")
        }
        return newDB
    }


    func updateMission(index : Int, newData : missions) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Quests")
        fetchRequest.predicate = NSPredicate(format: "index = %d", index)
        
        do {
            let test = try managedContext.fetch(fetchRequest)
            let objectUpdate = test[0] as! NSManagedObject
            objectUpdate.setValue(true, forKey: "complete")
            do {
                try managedContext.save()
            } catch {
                print(error)
            }
        } catch {
            print(error)
        }
    }

//    func fetchMission() -> [missions] {
//            do {
//                let request = Bookmark.fetchRequest()
//                let results = try context.fetch(request)
//                return results
//            } catch {
//                print(error.localizedDescription)
//            }
//            return []
//        }
//
//    func updateMission(mission : missions) {
//            let fetchResults = fetchBookmarks()
//            for result in fetchResults {
//                if result.url == notice.url {
//                    result.title = "업데이트한 제목"
//                }
//            }
//            saveToContext()
//        }
//
    
    func saveMission(index: Int16, buildingName: String,
                  spotName: String, floor: String, guideImage: String, hint: String,
                  locationImage : String, advise : String, complete : Bool, onSuccess: @escaping ((Bool) -> Void)) {
        if let context = context,
            let entity: NSEntityDescription
            = NSEntityDescription.entity(forEntityName: modelName, in: context) {
            
            if let mission: Quests = NSManagedObject(entity: entity, insertInto: context) as? Quests {
                mission.index = index
                mission.buildingName = buildingName
                mission.spotName = spotName
                mission.floor = floor
                mission.guideImage = guideImage
                mission.hint = hint
                mission.locationImage = locationImage
                mission.advise = advise
                mission.complete = complete
                
                contextSave { success in
                    onSuccess(success)
                }
            }
        }
    }
    
    
}

extension CoreDataManager {
    fileprivate func filteredRequest(index: Int64) -> NSFetchRequest<NSFetchRequestResult> {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult>
            = NSFetchRequest<NSFetchRequestResult>(entityName: modelName)
        fetchRequest.predicate = NSPredicate(format: "index = %@", NSNumber(value: index))
        return fetchRequest
    }
    
    fileprivate func contextSave(onSuccess: ((Bool) -> Void)) {
        do {
            try context?.save()
            onSuccess(true)
        } catch let error as NSError {
            print("Could not save🥶: \(error), \(error.userInfo)")
            onSuccess(false)
        }
    }
}
