//
//  ContentView.swift
//  Healthy
//
//  Created by Andreas Großauer on 15.02.20.
//  Copyright © 2020 Andreas Großauer. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var temp:Double  = 15
    @State var data = GlobalStates.sharedInstance.deviceData[GlobalStates.sharedInstance.currentStation]
    
    var isCelsius = GlobalStates.sharedInstance.isCelsius
    
    
    var body: some View {
        
        //        Text("Hello, Andy!")
        //            .frame(maxWidth: .infinity, maxHeight: .infinity)
        //
        
        VStack {
            
            TitleBarView(name: $data.station_name, data: $data)
                .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                .edgesIgnoringSafeArea(.all)
//                .background(Color.gray)
            
            HealthView(index: $data.health_idx)
                .edgesIgnoringSafeArea(.all)
            
            ValueView(temp: (isCelsius ? $data.Temperature:$data.TemperatureF), hum: $data.Humidity, co2: $data.Pressure, noise: $data.Noise, minTemp: (isCelsius ? $data.min_temp:$data.min_tempF), maxTemp: (isCelsius ? $data.max_temp:$data.max_tempF))
                .background(Color.white)
                .edgesIgnoringSafeArea(.all)
            
            StatusBarView().padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                .edgesIgnoringSafeArea(.all)
//                .background(Color.gray)
                
        }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
//            .background(Color.black)
        
    }
    

    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        
        ContentView()
    }
}




// SubViews





