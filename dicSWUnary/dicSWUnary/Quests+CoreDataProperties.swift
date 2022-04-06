//
//  Quests+CoreDataProperties.swift
//  dicSWUnary
//
//  Created by 이규빈 on 2022/04/06.
//
//

import Foundation
import CoreData


extension Quests {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Quests> {
        return NSFetchRequest<Quests>(entityName: "Quests")
    }

    @NSManaged public var advise: String?
    @NSManaged public var buildingName: String?
    @NSManaged public var complete: Bool
    @NSManaged public var spotName: String?
    @NSManaged public var locationImage: String?
    @NSManaged public var guideImage: String?
    @NSManaged public var index: Int16
    @NSManaged public var hint: String?
    @NSManaged public var floor: String?

}

extension Quests : Identifiable {

}
