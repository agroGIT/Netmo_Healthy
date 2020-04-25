//
//  GlobalStates.swift
//  Netmo
//
//  Created by Andreas Großauer on 01.03.17.
//  Copyright © 2017 Andreas Großauer. All rights reserved.
//

import Foundation





class GlobalStates {

    var deviceData = [HealthyDataStruct]()
    var currentStation:Int = -1
    var menuBarStationNr:Int = 1    // Nr der Station die in der Menüleiste angezeigt wird.
    
    var refreshToken:String = ""

    var separatorSymbol = " / "
    
    // Preferences
    var globalSettings = GlobalSettings()
    
    
    var isCelsius:Bool = true // Wird durch die Systemeinstellungen gesetzt. Keine User-Einstellung!!!
    var tempUnit:String = "°C"
    
    
    static let sharedInstance: GlobalStates = {
        
        let instance = GlobalStates()
        
        return instance
    }()
    private init(){}
    
}

extension GlobalStates {
    
    func loadUserDefs() {
        
        globalSettings.loadUserDefaults()
        
    }
    
    
}
