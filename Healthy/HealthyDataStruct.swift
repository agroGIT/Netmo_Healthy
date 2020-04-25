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
    var stationID:String?
    var station_name:String?
    var temp:Double?
    var wifi_status:Int?
    var max_temp:Double?
    var max_tempF:Double?
    var date_max_temp:Double?
    var min_temp:Double?
    var min_tempF:Double?
    var date_min_temp:Double?
    var time_utc:TimeInterval?
    var health_idx:Int?
    var Temperature:Double?
    var TemperatureF:Double?
    var CO2:Double?
    var AbsolutePressure:Double?
    var Noise:Double?
    var Pressure:Double?
    var Humidity:Double?
    var lat:Double?
    var lon:Double?
    var country:String?
    var altitude:Double?
    var city:String?
    
 
    init () {
        id = 0
        stationID = ""
        station_name = ""
        temp = 0
        wifi_status = 0
        max_temp = 0
        max_tempF = 0
        date_max_temp = 0
        min_temp = 0
        min_tempF = 0
        date_min_temp = 0
        time_utc = 0
        health_idx = 0
        Temperature = 0
        TemperatureF = 0
        CO2 = 0
        AbsolutePressure = 0
        Noise = 0
        Pressure = 0
        Humidity = 0
        lat = 0
        lon = 0
        country = "--"
        altitude = 0
        city = "--"
        
    }
    
}
/*
 
 Dashboard: Optional(["max_temp": 23.6, "min_temp": 22.5, "time_utc": 1582231683, "health_idx": 1, "date_max_temp": 1582153262, "Temperature": 22.6, "date_min_temp": 1582193581, "CO2": 1159, "AbsolutePressure": 966.2, "Noise": 37, "Pressure": 1019, "Humidity": 57])
 
 */
