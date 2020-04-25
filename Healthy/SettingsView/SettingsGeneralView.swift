//
//  SettingsGeneralView.swift
//  Healthy
//
//  Created by Andreas Großauer on 24.04.20.
//  Copyright © 2020 Andreas Großauer. All rights reserved.
//

import SwiftUI

//struct settings {
//    
//    var showTemp:Bool
//    
//    
//}


struct SettingsGeneralView: View {
    
    @Binding var showStation:Bool
    @Binding var showTemp:Bool
    @Binding var showHum:Bool
    @Binding var showCO2:Bool
    @Binding var showNoise:Bool
    
    @Binding var username:String

    var body: some View {
        
        VStack {
            
            VStack {
                Text("General").bold() //.font(.system(size: 18))
            }.padding()
            
            
            
            
            VStack {
                
                HStack {
                    
                    Text("Username")
                    Spacer()
                    TextField("Username", text: $username).frame(width: 200, height: 30, alignment: .trailing)
                    
                }.padding()
            }
            
            
            
            

            
            VStack {
                
                // Show Station
                HStack {
                    Text("Show Station name")
                    Spacer()
                    Toggle(isOn:$showStation) {
                        Text("")
                    }.padding()
                }
                
                // Show Temperature
                HStack {
                    Text("Show Temperature")
                    Spacer()
                    Toggle(isOn:$showTemp) {
                        Text("")
                    }.padding()
                }
                // Show Humidity
                HStack {
                    Text("Show Humidty")
                    Spacer()
                    Toggle(isOn:$showHum) {
                        Text("")
                    }.padding()
                }
                // Show CO2
                HStack {
                    Text("Show CO2")
                    Spacer()
                    Toggle(isOn:$showCO2) {
                        Text("")
                    }.padding()
                }
                // Show Noise
                HStack {
                    Text("Show Noise")
                    Spacer()
                    Toggle(isOn:$showNoise) {
                        Text("")
                    }.padding()
                }
                
            }.padding()
            
            
            
        }.padding()
        
        
    }
}

struct SettingsGeneralView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsGeneralView(showStation: .constant(true), showTemp: .constant(true), showHum: .constant(true), showCO2: .constant(true), showNoise: .constant(true), username: .constant("Sepp") )
    }
}
