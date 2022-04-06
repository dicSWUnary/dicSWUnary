//
//  Structs.swift
//  dicSWUnary
//
//  Created by JUEUN KIM on 2022/04/05.
//

import Foundation
import CodableFirebase

struct missions : Codable {
    var advise: String
    var building_name : String
    var floor, guide_image, hint: String
    var index: Int
    var location_image: String
    var spot_name: String
    var succes_check: Bool
    
//    enum CodingKeys: String, CodingKey {
//        case building_name = "BUILDING_NAME"
//        case advise = "ADVISE"
//        case floor = "FLOOR"
//        case guide_image = "GUIDE_IMAGE"
//        case hint = "HINT"
//        case index = "INDEX"
//        case location_image = "LOCATION"
//        case spot_name = "SPOT_NAME"
//        case succes_check = "SUCwCES_CHECK"
//    }
    
}
