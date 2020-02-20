//
//  GlobalStates.swift
//  Netmo
//
//  Created by Andreas Großauer on 01.03.17.
//  Copyright © 2017 Andreas Großauer. All rights reserved.
//

import Foundation


class GlobalStates {


    
    
    
    static let sharedInstance: GlobalStates = {
        
        let instance = GlobalStates()
        
        return instance
    }()
    private init(){}
    
    
    
}
