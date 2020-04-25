//
//  StatusBarView.swift
//  Healthy
//
//  Created by Andreas Großauer on 22.02.20.
//  Copyright © 2020 Andreas Großauer. All rights reserved.
//

import SwiftUI

struct StatusBarView: View {
    
    var body: some View {
        
        HStack {
            
            
            Button(action: {
                print("Button Prefs")
                let appDel: AppDelegate = (NSApplication.shared.delegate as! AppDelegate)
                appDel.openSettings()
                
            }) {
                
                Image("Prefs").renderingMode(.original).resizable().frame(width: 20.0, height: 20.0)
                    
                
            }
            
            
            Button(action: {
                print ("Connect")
                DispatchQueue.global(qos: .background).async {
                    let net = NetatmoConnect()
                    let result = net.authentication(username: "grossauer@me.com", password: "akldf837348jsdf")
                    print ("Authentication result: \(String(describing: result))")
                }
            }) {
                Text("Auth")
            }
            
            Spacer()
            
            Button(action: {
                let appDel: AppDelegate = (NSApplication.shared.delegate as! AppDelegate)
                appDel.netatmoUpdate()
                
            }) {
                Text("Update")
            }
            
            
        }
        
    }
    
    
}

