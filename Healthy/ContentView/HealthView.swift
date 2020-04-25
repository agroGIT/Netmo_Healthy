//
//  HealthView.swift
//  Healthy
//
//  Created by Andreas Großauer on 21.02.20.
//  Copyright © 2020 Andreas Großauer. All rights reserved.
//

import SwiftUI

struct HealthView:View {
    
    @Binding var index:Int?

    
    var body: some View {
        
        VStack {
            
            Text (self.getIndexText(idx: index!).0).font(.system(size: 40)).frame(minWidth: 0, maxWidth: .infinity).padding()
            Spacer()
            Text("xKeine Sorge, alles in Ordnung.").font(.subheadline)
            Spacer()
        }.background(LinearGradient(gradient: Gradient(colors: [self.getIndexText(idx: index!).1, self.getIndexText(idx: index!).2]), startPoint: .leading, endPoint: .trailing))
        
        
    }
    
    func getIndexText(idx:Int) -> (String, Color, Color) {
        /// Gesundheitsindex setzen
        /// Farbwerte setzen
        var col1 = Color.red
        var col2 = Color.red
        
        let red = Color(red: 229/256, green: 108/256, blue: 108/256)
        let red2 = Color(red: 179/256, green: 58/256, blue: 58/256)
        let orange = Color(red: 238/256, green: 191/256, blue: 120/256)
        let yellow = Color(red: 237/256, green: 222/256, blue: 79/256)
        let green = Color(red: 100/256, green: 187/256, blue: 153/256)
        let blue = Color(red: 132/256, green: 158/256, blue: 200/256)
        
        var str = "--"
        
        if idx == 0 {col1 = blue; col2 = green; str = NSLocalizedString("HEALTHY", comment: "")}
        if idx == 1 {col1 = green; col2 = yellow; str = NSLocalizedString("FINE", comment: "")}
        if idx == 2 {col1 = yellow; col2 = orange; str = NSLocalizedString("FAIR", comment: "")}
        if idx == 3 {col1 = orange; col2 = red; str = NSLocalizedString("POOR", comment: "")}
        if idx == 4 {col1 = red; col2 = red2 ; str = NSLocalizedString("UNHEALTHY", comment: "") }

        return (str, col1, col2)

    }
    
}

