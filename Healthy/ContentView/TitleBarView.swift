//
//  TitleBarView.swift
//  Healthy
//
//  Created by Andreas Großauer on 21.02.20.
//  Copyright © 2020 Andreas Großauer. All rights reserved.
//

import SwiftUI

struct TitleBarView:View {
    @Binding var name:String?
    @Binding var data:HealthyDataStruct
    

    var body: some View {
        
       
            
            HStack {
                
                Button(action: {
                    //self.temp = self.temp - 1.0
                    let v = GlobalStates.sharedInstance.currentStation - 1
                    self.data = self.getData(val: v)
                    //print ("Left")
                }) {
                    Text("<")
                }
                
                Spacer()
                
                Text ("\(name!)").bold().font(.system(size: 18))
                
                Spacer()
                
                Button(action: {
                    let v = GlobalStates.sharedInstance.currentStation + 1
                    self.data = self.getData(val: v)
                    //print ("Right")
                }) {
                    Text(">")
                }
            
        }
        
    }
    
    func getData(val:Int) -> HealthyDataStruct {
        
        var nr = val
        let count = GlobalStates.sharedInstance.deviceData.count
        
        if nr < 0 { nr = count - 1; }
        if nr >= count {nr = 0}
        GlobalStates.sharedInstance.currentStation = nr
        
        print (nr)
        
        let element = GlobalStates.sharedInstance.deviceData[nr]
        
        return element
    }
    
}
