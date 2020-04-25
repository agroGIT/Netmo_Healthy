//
//  GlobalSettings.swift
//  Healthy
//
//  Created by Andreas Großauer on 24.04.20.
//  Copyright © 2020 Andreas Großauer. All rights reserved.
//

import Foundation
import Cocoa

class GlobalSettings:ObservableObject {
    
    @Published var showStationName:Bool { didSet{changed()} }
    @Published var showTemp:Bool        { didSet{changed()} }
    @Published var showHumidity:Bool    { didSet{changed()} }
    @Published var showCO2:Bool         { didSet{changed()} }
    @Published var showNoise:Bool       { didSet{changed()} }
    
    
    var dontSave = false;
    
    init () {
        showStationName = true
        showTemp = true
        showHumidity = true
        showCO2 = true
        showNoise = true
    }
    
    func changed() {
        if dontSave { return }
        print("Changed")
        let appDel: AppDelegate = (NSApplication.shared.delegate as! AppDelegate)
        self.saveUserDefaults()
        appDel.updateStatusBar()
        
        
    }
    
}


extension GlobalSettings {
    
    func saveUserDefaults() {
        print("Save Defs")
        let defaults = UserDefaults.standard
        defaults.set(showStationName, forKey: "showStationName")
        defaults.set(showTemp, forKey: "showTemp")
        defaults.set(showHumidity, forKey: "showHumidity")
        defaults.set(showCO2, forKey: "showCO2")
        defaults.set(showNoise, forKey: "showNoise")
        
    }
    
    func loadUserDefaults() {
        print("Load Defs")
        dontSave = true
        let defaults = UserDefaults.standard
        showStationName = Bool(defaults.bool(forKey: "showStationName"))
        showTemp = Bool(defaults.bool(forKey: "showTemp"))
        showHumidity = Bool(defaults.bool(forKey: "showHumidity"))
        showCO2 = Bool(defaults.bool(forKey: "showCO2"))
        showNoise = Bool(defaults.bool(forKey: "showNoise"))
        dontSave = false
    }
    
}
