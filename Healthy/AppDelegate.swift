//
//  AppDelegate.swift
//  Healthy
//
//  Created by Andreas Großauer on 15.02.20.
//  Copyright © 2020 Andreas Großauer. All rights reserved.
//

import Cocoa
import SwiftUI

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var window: NSWindow!
    let healthyStationData: [HealthyDataStruct] = []
    var statusItem: NSStatusItem? = nil
    let statusView = StatusViewController(nibName: "StatusView", bundle: nil)
    var popover: NSPopover!
    var statusBarItem: NSStatusItem!
    var eventMonitor: EventMonitor?
    

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Create the SwiftUI view that provides the window contents.
        let contentView = ContentView()

        // Create the popover
        let popover = NSPopover()
        popover.contentSize = NSSize(width: 400, height: 500)
        popover.behavior = .transient
        popover.contentViewController = NSHostingController(rootView: contentView)
        self.popover = popover
        
        
        // Set statusbar item
        self.statusBarItem = NSStatusBar.system.statusItem(withLength: CGFloat(NSStatusItem.variableLength))
        if let button = self.statusBarItem.button {
//            button.image = NSImage(named: "Icon")
            button.title = "Healthy"
            button.action = #selector(togglePopover(_:))
        }
        
        
        eventMonitor = EventMonitor(mask: [NSEvent.EventTypeMask.leftMouseDown, NSEvent.EventTypeMask.rightMouseDown]) { [unowned self] event in

                    if (self.popover.isShown) {

                        self.popover.performClose(nil)
                        self.eventMonitor?.stop()
                        
                    }
        }
        
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

        // MARK: - Status Bar
        // ------------------------------------------------------------------------
    
    // Create the status item
    @objc func togglePopover(_ sender: AnyObject?) {
         if let button = self.statusBarItem.button {
              if self.popover.isShown {
                   self.popover.performClose(sender)
                    eventMonitor?.stop()
              } else {
                   self.popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
                self.popover.contentViewController?.view.window?.becomeKey()
                eventMonitor?.start()
              }
         }
    }

    
    
    
    // MARK: - Popover
    // ------------------------------------------------------------------------
    
    func showPopOver(_ sender: AnyObject?) {
    
    
    }
    
    // MARK: - Netatmo Request
    
    func netatmoUpdate() {
        
        let refreshToken:String?  = UserDefaults.standard.string(forKey: "refreshToken")
        if refreshToken == nil {print("No refresh token saved"); return }
        
        print ("Token: \(refreshToken!)")
        
        let net = Netatmo()
        net.getStationData(refreshToken)
        
        
        
    }
    
    
    
    
    
// EOF
}

