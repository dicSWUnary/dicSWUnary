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
    func retrieveData() { guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
        else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Quests")
        do { let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject]
            { print(data.value(forKey: "complete") as! Bool) } }
        catch {
            print("error")
        }
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
