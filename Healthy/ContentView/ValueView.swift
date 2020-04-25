//
//  ValueView.swift
//  Healthy
//
//  Created by Andreas Großauer on 21.02.20.
//  Copyright © 2020 Andreas Großauer. All rights reserved.
//

import SwiftUI

struct ValueView:View {
    
    @Binding var temp:Double?
    @Binding var hum:Double?
    @Binding var co2:Double?
    @Binding var noise:Double?
    @Binding var minTemp:Double?
    @Binding var maxTemp:Double?
    
    var isCelsius = GlobalStates.sharedInstance.isCelsius
    
    var body:some View {
        
        VStack {
            HStack {
                Text(NSLocalizedString("TEMPERATURE", comment: ""))
                    .frame(width: 120, height: 30, alignment: .leading)
                    .foregroundColor(.black)
                    .font(.system(size: 14, weight: .medium , design: .default))

                
                Spacer()
            
                Text("\(roundDoubleToString(temp!)) \(GlobalStates.sharedInstance.tempUnit)").frame(width: 120, height: 30, alignment: .center)
                    .frame(width: 120, height: 30, alignment: .center)
                    .background(getTempColor(val: temp!))
                    .cornerRadius(25)
            }.padding(EdgeInsets(top: 7, leading: 10, bottom: 3, trailing: 10))
            
            Divider()
            
            HStack {
                Text(NSLocalizedString("HUMIDITY", comment: ""))
                    .frame(width: 120, height: 30, alignment: .leading)
                    .font(.system(size: 14, weight: .medium , design: .default))
                    .foregroundColor(.black)
                
                Spacer()
                
                Text("\(roundDoubleToString(hum!)) %")
                    .frame(width: 120, height: 30, alignment: .center)
                    .background(getHumColor(hum: hum!))
                    .cornerRadius(25)
//                Spacer()
//                Text ("Ok").frame(width: 60, height: 30, alignment: .trailing)
            }.padding(EdgeInsets(top: 3, leading: 10, bottom: 3, trailing: 10))
            
            Divider()
            
            HStack {
                Text(NSLocalizedString("CO2", comment: ""))
                    .frame(width: 120, height: 30, alignment: .leading)
                    .font(.system(size: 14, weight: .medium , design: .default))
                    .foregroundColor(.black)
                
                Spacer()
                
                Text("\(roundDoubleToString(co2!)) ppm").frame(width: 120, height: 30, alignment: .center)
                    .frame(width: 120, height: 30, alignment: .center)
                    .background(getCO2Color(val: co2!))
                    .cornerRadius(25)
            }.padding(EdgeInsets(top: 3, leading: 10, bottom: 3, trailing: 10))
            
            Divider()
            
            HStack {
                Text(NSLocalizedString("NOISE", comment: ""))
                    .frame(width: 120, height: 30, alignment: .leading)
                    .font(.system(size: 14, weight: .medium , design: .default))
                    .foregroundColor(.black)
                
                Spacer()
                
                Text("\(roundDoubleToString(noise!)) db")
                    .frame(width: 120, height: 30, alignment: .center)
                    .background(getNoiseColor(val: noise!))
                    .cornerRadius(25)
            }.padding(EdgeInsets(top: 3, leading: 10, bottom: 7, trailing: 10))
        
        }
        
    }
    
    func roundDoubleToString (_ d: Double) -> String {
        
        return String.localizedStringWithFormat("%.1f", d)
        
    }
    
    func getHumColor (hum:Double) -> Color {
        var col = Color.red
        
        if hum <= 15 || hum >= 80 {col = Color(red: 229/256, green: 108/256, blue: 108/256)} // red
        
        if hum > 15 && hum <= 20  {col = Color(red: 238/256, green: 191/256, blue: 120/256)} // orange
        if hum > 70 && hum <= 80  {col = Color(red: 238/256, green: 191/256, blue: 120/256)} // orange
        
        if hum > 20 && hum <= 30  {col = Color(red: 237/256, green: 222/256, blue: 79/256)} // yellow
        if hum > 60 && hum <= 70  {col = Color(red: 237/256, green: 222/256, blue: 79/256)} // yellow
        
        if hum > 30 && hum <= 40  {col = Color(red: 100/256, green: 187/256, blue: 153/256)} // green
        if hum > 50 && hum <= 60  {col = Color(red: 100/256, green: 187/256, blue: 153/256)} // green
        
        if hum > 40 && hum <= 50  {col = Color(red: 132/256, green: 158/256, blue: 200/256)} // blue
        
        return col
    }
    
    func getTempColor (val:Double) -> Color {
        var col = Color.red
        
        if isCelsius {
            if val <= 15 || val >= 29 {col = Color(red: 229/256, green: 108/256, blue: 108/256)} // red
            
            if val > 15 && val <= 16  {col = Color(red: 238/256, green: 191/256, blue: 120/256)} // orange
            if val > 27 && val <= 28  {col = Color(red: 238/256, green: 191/256, blue: 120/256)} // orange
            
            if val > 16 && val <= 17  {col = Color(red: 237/256, green: 222/256, blue: 79/256)} // yellow
            if val > 26 && val <= 27  {col = Color(red: 237/256, green: 222/256, blue: 79/256)} // yellow
            
            if val > 17 && val <= 19  {col = Color(red: 100/256, green: 187/256, blue: 153/256)} // green
            if val > 23 && val <= 26  {col = Color(red: 100/256, green: 187/256, blue: 153/256)} // green
            
            if val > 19 && val <= 23  {col = Color(red: 132/256, green: 158/256, blue: 200/256)} // blue
        } else {
            if val <= 15 * 1.8 + 32 || val >= 29 {col = Color(red: 229/256, green: 108/256, blue: 108/256)} // red
            
            if val > 15 * 1.8 + 32 && val <= 16 * 1.8 + 32  {col = Color(red: 238/256, green: 191/256, blue: 120/256)} // orange
            if val > 27 * 1.8 + 32 && val <= 28 * 1.8 + 32  {col = Color(red: 238/256, green: 191/256, blue: 120/256)} // orange
            
            if val > 16 * 1.8 + 32 && val <= 17 * 1.8 + 32  {col = Color(red: 237/256, green: 222/256, blue: 79/256)} // yellow
            if val > 26 * 1.8 + 32 && val <= 27 * 1.8 + 32  {col = Color(red: 237/256, green: 222/256, blue: 79/256)} // yellow
            
            if val > 17 * 1.8 + 32 && val <= 19 * 1.8 + 32  {col = Color(red: 100/256, green: 187/256, blue: 153/256)} // green
            if val > 23 * 1.8 + 32 && val <= 26 * 1.8 + 32  {col = Color(red: 100/256, green: 187/256, blue: 153/256)} // green
            
            if val > 19 * 1.8 + 32 && val <= 23 * 1.8 + 32  {col = Color(red: 132/256, green: 158/256, blue: 200/256)} // blue
        }
        
        
        
        
        return col
    }

    func getCO2Color (val:Double) -> Color {
        var col = Color.red
        
        if val < 900  {col = Color(red: 132/256, green: 158/256, blue: 200/256)} // blue
        if val >= 900 || val <= 1150 {col = Color(red: 132/256, green: 158/256, blue: 200/256)} // blue
        if val > 1150 && val <= 1400  {col = Color(red: 237/256, green: 222/256, blue: 79/256)} // yellow
        if val > 1400 && val <= 1600  {col = Color(red: 238/256, green: 191/256, blue: 120/256)} // orange
        if val > 1600 {col = Color(red: 229/256, green: 108/256, blue: 108/256)} // red

        return col
    }
    
    func getNoiseColor (val:Double) -> Color {
        var col = Color.red
        
        if val < 50  {col = Color(red: 132/256, green: 158/256, blue: 200/256)} // blue
        if val >= 50 || val <= 65 {col = Color(red: 100/256, green: 187/256, blue: 153/256)} // green
        if val > 65 && val <= 70  {col = Color(red: 237/256, green: 222/256, blue: 79/256)} // yellow
        if val > 70 && val <= 80  {col = Color(red: 238/256, green: 191/256, blue: 120/256)} // orange
        if val > 80 {col = Color(red: 229/256, green: 108/256, blue: 108/256)} // red

        return col
    }
    
    
    
}
