//
//  Verified+CoreDataProperties.swift
//  
//
//  Created by 이규빈 on 2022/05/04.
//
//

import Foundation
import CoreData


extension Verified {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Verified> {
        return NSFetchRequest<Verified>(entityName: "Verified")
    }

    @NSManaged public var emailVerified: Bool

}

extension Verified : Identifiable {

}
