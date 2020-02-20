//
//  HealthyDataStruct.swift
//  Healthy
//
//  Created by Andreas Großauer on 16.02.20.
//  Copyright © 2020 Andreas Großauer. All rights reserved.
//

import SwiftUI


// : Hashable, Codable, Identifiable
struct HealthyDataStruct: Hashable, Codable, Identifiable  {
    
    var id: Int
    var stationID:String
//    var timestamp:Double
//    var stationName:String
    
}



//    var id: String = ""
//    var timestamp_creation: Double = 0
//    var timestamp_done: Double = 0
//    var timestamp_last_change: Double = 0
//    var title: String = ""
//    var note: String = ""
//    var sticky: Bool  = false // Nur Notes
//    var done: Bool = false
//    var type: TType = .none
//    var parent_id: String = ""
//    fileprivate var imageName: String = ""
//    var priority: PPriority = .low
//    var flagged: Bool = false

    

//extension TNTDataStruct {
//    var image: Image {
//        ImageStore.shared.image(name: imageName)
//    }
//}
