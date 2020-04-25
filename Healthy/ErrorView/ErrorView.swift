//
//  ErrorView.swift
//  Healthy
//
//  Created by Andreas Großauer on 29.02.20.
//  Copyright © 2020 Andreas Großauer. All rights reserved.
//

import SwiftUI

struct ErrorView: View {
    var body: some View {
        
        VStack {
            
            Text("Hello, Error!").padding()
            
            Spacer()
            
            Button(action: {
               // let appDel: AppDelegate = (NSApplication.shared.delegate as! AppDelegate)
                //                appDel.closeSettings()
            }) {
                Text("Do nothing")
            }.padding()
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView()
    }
}
