//
//  NetatmoConnect.swift
//  Netatmo
//
//  Created by Andreas Großauer on 06.02.17.
//  Copyright © 2017 Andreas Großauer. All rights reserved.
//

import Cocoa
import Alamofire
import SwiftyJSON

class NetatmoConnect: NSObject {
    
    
    let manager = NetworkReachabilityManager(host: "https://api.netatmo.com")
    let client_id = "5e4c2c6c273f774eeb321756"
    let client_secret = "0STfjEvV5iYSl8GO2PvPVixSscbmTjC2gHIkZQ0cg1"
    
    func checkForInternet () -> Bool {

        return manager?.isReachable ?? false
        
    }
    

    
    
    // MARK: - Authentication
    // ----------------------------------------------
    func authentication (username:String, password: String) -> String? {
        print ("\(username), \(password)")
        let defaults = UserDefaults.standard
//        var refresh_Token:String? = nil
        if username == "" {return nil}
        if password == "" {return nil}
//        let set:CharacterSet = CharacterSet.init(charactersIn: "!*'();:@&=+$,/?%#[]")
        
//        let nPassword = password.addingPercentEncoding(withAllowedCharacters: set)
//        let nUsername = username.addingPercentEncoding(withAllowedCharacters: set)
        
        
//        print ("\(nUsername), \(nPassword)")
        
        let url = "https://api.netatmo.com/oauth2/token"
        
        let params:Parameters = [    "client_id":client_id,
            "client_secret":client_secret,
            "grant_type":"password",
            "username":username,
            "password":password,
            "scope":"read_homecoach"]
        
        AF.request(url, method: .post, parameters: params, encoding: URLEncoding.default , headers: nil).validate().responseJSON {
            response in
            
            do {
                let json = try JSON(data: response.data! )
                
                if json["error"].stringValue != "" {
                    
                    print(json["error"].stringValue)
                    return
                    
                } else {
                    
                    // Token erfolgreich geholt
                    let accessToken = json["access_token"].stringValue
                    let refreshToken = json["refresh_token"].stringValue
                    
                    // Neues refreshToken speichern
                    defaults.set(refreshToken, forKey: "refreshToken")
                    print (accessToken)
                    print (refreshToken)
                    
                    NotificationCenter.default.post(name: authSuccessfulNotify, object: nil)
                }
                
            } catch {
                
            }
        }
        return nil

    }

    
    // MARK: - Netatmo Request
    // ----------------------------------------------
    /// Die aktuelle Funktion zum Abfrage der Netatmo Daten
    func requestNetatmoData() {
        
        print ("func requestNetatmoData")

        // Token laden
        var accessToken = ""
        let defaults = UserDefaults.standard
        let refreshToken:String?  = defaults.string(forKey: "refreshToken")
        if refreshToken == nil {print("No refresh token saved");return }

        var params:Parameters = ["client_id":client_id,
                                 "client_secret":client_secret,
                                 "grant_type":"refresh_token",
                                 "refresh_token":refreshToken!,
                                 "scope":"read_homecoach"]
        
        AF.request("https://api.netatmo.com/oauth2/token", method: .post, parameters: params, encoding: URLEncoding.default , headers: nil).validate().responseJSON {
            response in
            
            do {
                
                let json = try JSON(data: response.data! )
                if json["error"].stringValue != "" {
                    
                    print(json["error"].stringValue)
                    return
                    
                } else {
                    
                    
                    // Token erfolgreich geholt und Refresh token Speichern
                    accessToken = json["access_token"].stringValue
                    let refresh = json["refresh_token"].stringValue
                    defaults.set(refresh, forKey: "refresh_token")
//                    print ("Access Token: \(accessToken)")
                    
                    
                    
                    // Abfragen der Netatmo Health Coach Daten
                    
                    params = ["access_token":accessToken,
                              "scope":"read_homecoach"]

                    AF.request("https://api.netatmo.com/api/gethomecoachsdata", method: .post, parameters: params, encoding: URLEncoding.default , headers: nil).validate().responseJSON {
                        response in
                        
                        do {
                            
                            let json = try JSON(data: response.data! )
                            
                            // Wenn Fehler
                            if json["error"].stringValue != "" {
                                
                                print(json["error"].stringValue)
                                return
                                
                            } else {
                                
                             //   print (json)
                                
                                let devices = json["body"]["devices"].array
                                
//                                let devices = body["devices"].array
                                
                                let countDevices = devices?.count
                                
                                let calc = Calculations()
                                
                                var updateOK = true
                                
                                if countDevices! > 0 {
                                    GlobalStates.sharedInstance.deviceData.removeAll()
                                    
                                    for device in devices! {
                                        
                                        var data = HealthyDataStruct()
                                        
                                        
                                      //  print ("Name: \(device["station_name"])")
                                        data.station_name = device["station_name"].string ?? "N/A"
                                        
                                        let dashboard = device["dashboard_data"].dictionary
                                        
                                        if dashboard != nil {
                                            data.temp = dashboard?["temp"]?.double ?? 0
                                            data.wifi_status =  dashboard?["wifi_status"]?.int ?? 0
                                            data.max_temp = dashboard?["max_temp"]?.double ?? 0
                                            data.date_max_temp = dashboard?["date_max_temp"]?.double ?? 0
                                            data.min_temp = dashboard?["min_temp"]?.double ?? 0
                                            data.date_min_temp = dashboard?["date_min_temp"]?.double ?? 0
                                            data.time_utc = dashboard?["time_utc"]?.double ?? 0
                                            data.health_idx = dashboard?["health_idx"]?.int ?? 0
                                            data.Temperature = dashboard?["Temperature"]?.double ?? 0
                                            data.TemperatureF = data.Temperature! * 1.8 + 32
                                            data.CO2 = dashboard?["CO2"]?.double ?? 0
                                            data.AbsolutePressure = dashboard?["AbsolutePressure"]?.double ?? 0
                                            data.Noise = dashboard?["Noise"]?.double ?? 0
                                            data.Pressure = dashboard?["Pressure"]?.double ?? 0
                                            data.Humidity = dashboard?["Humidity"]?.double ?? 0
                                            
                                            let place = device["place"]["location"].array
                                            if place != nil {
                                                data.country = device["place"]["country"].string ?? "N/A"
                                                data.altitude = device["place"]["altitude"].double ?? 0
                                                data.city = device["place"]["city"].string ?? "N/A"
                                                
                                                if place!.count == 2 {
                                                    data.lat = place?[0].double ?? 0
                                                    data.lon = place?[1].double ?? 0
                                                }
                                            } else {
                                                data.country = "N/A"
                                                data.altitude = -999.0
                                                data.city = "N/A"
                                                data.lat = 0.0
                                                data.lon = 0.0
                                                
                                                
                                                
                                            }
                                            print ("City: \(data.city!)")
                                            
                                            
                                            
                                            // Runden der Werte
                                            data.temp = calc.rundenDouble(data.temp!)
                                            //data.wifi_status = calc.rundenDouble(data.wifi_status!)
                                            data.max_temp = calc.rundenDouble(data.max_temp!)
                                            data.date_max_temp = calc.rundenDouble(data.date_max_temp!)
                                            data.min_temp = calc.rundenDouble(data.min_temp!)
                                            data.date_min_temp = calc.rundenDouble(data.date_min_temp!)
                                            data.time_utc = calc.rundenDouble(data.time_utc!)
                                            data.Temperature = calc.rundenDouble(data.Temperature!)
                                            data.CO2 = calc.rundenDouble(data.CO2!)
                                            data.AbsolutePressure = calc.rundenDouble(data.AbsolutePressure!)
                                            data.Noise = calc.rundenDouble(data.Noise!)
                                            data.Pressure = calc.rundenDouble(data.Pressure!)
                                            data.Humidity = calc.rundenDouble(data.Humidity!)
                                            
                                            GlobalStates.sharedInstance.deviceData.append(data)
                                            
                                            data.station_name = "Element 2"
                                            data.health_idx = 1
                                            GlobalStates.sharedInstance.deviceData.append(data)
                                            
                                            data.station_name = "Element 3"
                                            data.health_idx = 2
                                            GlobalStates.sharedInstance.deviceData.append(data)
                                            
                                            data.station_name = "Element 4"
                                            data.health_idx = 3
                                            GlobalStates.sharedInstance.deviceData.append(data)
                                            
                                            data.station_name = "Element 5"
                                            data.health_idx = 4
                                            GlobalStates.sharedInstance.deviceData.append(data)
                                        } else {
                                            updateOK = false
                                        }
                                    }
                                    
                                    
                                    
                                    if updateOK {
                                        // Notification senden
                                        NotificationCenter.default.post(name: updateSuccessfulNotify, object: nil)
                                    } else {
                                        
                                                                             
                                        NotificationCenter.default.post(name: updateFailedNotify, object: nil)
                                    }
                                    
                                }
                                
                                
                                
                                
                                
                                
                                

                            }
                        } catch {print ("Error: Refreshing Health Data failed") }
                    }
                    
                    
                    
                    ///////
                }
            } catch {print ("Error: Refreshing Token failed") }
        }
    }
    
    
    

// EOF
}
