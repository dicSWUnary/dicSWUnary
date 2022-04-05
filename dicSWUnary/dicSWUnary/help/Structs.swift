//
//  Structs.swift
//  dicSWUnary
//
//  Created by JUEUN KIM on 2022/04/05.
//

import Foundation
import CodableFirebase

struct missions : Codable {
    let advise: String
    let building_name : String
    let floor, guide_image, hint: String
    let index: Double
    let location_image: String
    let spot_name: String
    let succes_check: Bool
    
//    enum CodingKeys: String, CodingKey {
//        case building_name = "BUILDING_NAME"
//        case advise = "ADVISE"
//        case floor = "FLOOR"
//        case guide_image = "GUIDE_IMAGE"
//        case hint = "HINT"
//        case index = "INDEX"
//        case location_image = "LOCATION"
//        case spot_name = "SPOT_NAME"
//        case succes_check = "SUCCES_CHECK"
//    }
    
}
