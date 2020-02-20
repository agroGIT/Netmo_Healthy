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
//    var data: [HealthyDataStruct]
    
    var body: some View {
        
//        Text("Hello, Andy!")
//            .frame(maxWidth: .infinity, maxHeight: .infinity)
//
        
        VStack {
            
            TitleBarView(temp: $temp)
            Divider()
            HealthView()
            Divider()
            ValueView(temp: $temp)
                        
        }.frame(maxWidth: .infinity, maxHeight: .infinity).padding()
        
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        ContentView()
    }
}




// SubViews

struct TitleBarView:View {
    @Binding var temp:Double
    
    var body: some View {
        
        HStack {
            Button(action: {
                
                self.temp = self.temp - 1
//                print ("Left")
                
            }) {
                Text("<")
            }
            Button(action: {
                
                print ("Connect")
                
                DispatchQueue.global(qos: .background).async {
                    let net = NetatmoConnect()
                    let result = net.authentication(username: "grossauer@me.com", password: "akldf837348jsdf")
                }
            }) {
                Text("C")
            }
            
            
            Spacer()
            Text ("xWohnzimmer").bold().font(.system(size: 18))
            Spacer()
            
            //
            Button(action: {
                
                let appDel: AppDelegate = (NSApplication.shared.delegate as! AppDelegate)
                appDel.netatmoUpdate()
                
                
            }) {
                Text("U")
            }
            
            Button(action: {
                self.temp = self.temp + 1.0
//                print ("Right")
                
            }) {
                Text(">")
            }
        }
    }
}

struct HealthView:View {
    var body: some View {
        
        VStack {
            Text ("Healthy").font(.system(size: 40)).frame(minWidth: 0, maxWidth: .infinity)
            Spacer()
        }.background(LinearGradient(gradient: Gradient(colors: [Color.green, Color.blue]), startPoint: .leading, endPoint: .trailing))
        
        
    }
}

struct ValueView:View {
    
    @Binding var temp:Double
    
    var body:some View {
        
        VStack {
            HStack {
                Text(NSLocalizedString("TEMPERATURE", comment: "")).frame(width: 120, height: 30, alignment: .leading)
                
                Spacer()
                Text("\(self.temp)").frame(width: 60, height: 30, alignment: .leading)
                
                Spacer()
                Text ("Ok").frame(width: 60, height: 30, alignment: .trailing)
            }
            Divider()
            HStack {
                Text(NSLocalizedString("HUMIDITY", comment: "")).frame(width: 120, height: 30, alignment: .leading)
                Spacer()
                Text("54%").frame(width: 60, height: 30, alignment: .leading)
                Spacer()
                Text ("Ok").frame(width: 60, height: 30, alignment: .trailing)
            }
            Divider()
            HStack {
                Text(NSLocalizedString("CO2", comment: "")).frame(width: 120, height: 30, alignment: .leading)
                Spacer()
                Text("75ppm").frame(width: 60, height: 30, alignment: .leading)
                Spacer()
                Text ("Excellent").frame(width: 60, height: 30, alignment: .trailing)
            }
            Divider()
            HStack {
                Text(NSLocalizedString("NOISE", comment: "")).frame(width: 120, height: 30, alignment: .leading)
                Spacer()
                Text("Quiet").frame(width: 60, height: 30, alignment: .leading)
                Spacer()
                Text ("Excellent").frame(width: 60, height: 30, alignment: .trailing)
            }
        }
        
    }
    
}
