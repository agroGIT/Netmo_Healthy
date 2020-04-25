//
//  LoginView.swift
//  Healthy
//
//  Created by Andreas Großauer on 21.02.20.
//  Copyright © 2020 Andreas Großauer. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        
        VStack {
            Text("Login View").frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .font(.largeTitle)
            
            HStack {
                Button(action: {
                    print ("Authorize")
                    DispatchQueue.global(qos: .background).async {
                        let net = NetatmoConnect()
                        let result = net.authentication(username: "grossauer@me.com", password: "akldf837348jsdf")
                        print("Authentication result: \(String(describing: result))")
                    }
                }) {
                    Text("C")
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
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
