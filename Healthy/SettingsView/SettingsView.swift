//
//  Settings.swift
//  Healthy
//
//  Created by Andreas Großauer on 28.02.20.
//  Copyright © 2020 Andreas Großauer. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    
    @ObservedObject var settings = GlobalStates.sharedInstance.globalSettings
    @State var username = "Franz"
    
    
    var body: some View {
        
        VStack {
            
            SettingsGeneralView(showStation: $settings.showStationName , showTemp: $settings.showTemp, showHum: $settings.showHumidity, showCO2: $settings.showCO2, showNoise: $settings.showNoise, username: $username)
            
            Spacer()
            
            Button(action: {
                let appDel: AppDelegate = (NSApplication.shared.delegate as! AppDelegate)
                appDel.closeSettings()
            }) {
                Text("Close Settings")
            }.padding()
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
        
        
        
        

        
        ////
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
