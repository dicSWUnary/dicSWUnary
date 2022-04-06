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
