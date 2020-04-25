//
//  AppDelegate.swift
//  Healthy
//
//  Created by Andreas Großauer on 15.02.20.
//  Copyright © 2020 Andreas Großauer. All rights reserved.
//

import Cocoa
import SwiftUI

public enum UUnit:Int {
    
    case METRIC
    case IMPERIAL
}

public enum TTempUnit:Int {
    
    case CELSIUS
    case FAHRENHEIT
}

public enum VViewState:Int {
    
    case LOGIN
    case SINGLE
    case COMPACT
    case ERROR
    case SETTINGS
    
}

let authSuccessfulNotify = Notification.Name("authSuccessfulNotify")
let updateSuccessfulNotify = Notification.Name("updateSuccessfulNotify")
let updateFailedNotify = Notification.Name("updateFailedNotify")

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var window: NSWindow!
    let healthyStationData: [HealthyDataStruct] = []
    var statusItem: NSStatusItem? = nil
    let statusView = StatusViewController(nibName: "StatusView", bundle: nil)
    var popover: NSPopover!
    var statusBarItem: NSStatusItem!
    var eventMonitor: EventMonitor?
    var viewState:VViewState = .LOGIN
    
    var minuteTimer = Timer()
    var timerCounter = 0
    let timerInterval = 4 * 11   // 11 min
    
    
    // MARK: - Init
    // ------------------------------------------------------------------------

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Create the SwiftUI view that provides the window contents.
        

//        // Create the popover
//        let popover = NSPopover()
//        popover.contentSize = NSSize(width: 400, height: 500)
//        popover.behavior = .transient
//        popover.contentViewController = NSHostingController(rootView: contentView)
//        self.popover = popover
        
        
        getTemperatureSettings() // Sytem Settings
        
        
        minuteTimer = Timer.scheduledTimer(timeInterval: 15, target: self, selector: #selector(fireTimeUpdateNetatmo), userInfo: nil, repeats: true)
        
        
      //  setView()
        
        
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
        
        
        
        
        // Notifications
        NotificationCenter.default.addObserver(self, selector: #selector(AppDelegate.authenticationSuccessful), name: authSuccessfulNotify, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(AppDelegate.updateSuccessful), name: updateSuccessfulNotify, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(AppDelegate.updateFailed), name: updateFailedNotify
, object: nil)
        
       // GlobalStates.sharedInstance.currentStation = -1
        
        
        // Settings updaten
        GlobalStates.sharedInstance.loadUserDefs()
        
        netatmoUpdate()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
        
        NotificationCenter.default.removeObserver(self, name: authSuccessfulNotify, object: nil)
        NotificationCenter.default.removeObserver(self, name: updateSuccessfulNotify, object: nil)
        NotificationCenter.default.removeObserver(self, name: updateFailedNotify, object: nil)
        
    }
    
    
    func getTemperatureSettings() {
        /// Holt sich die Temp-Settings vom System
        
        let key = "AppleTemperatureUnit" as CFString
        let domain = "Apple Global Domain" as CFString

        if let unit = CFPreferencesCopyValue(key, domain, kCFPreferencesCurrentUser, kCFPreferencesAnyHost) as? String {
            print(unit)
            
            if unit == "Celsius" {
                GlobalStates.sharedInstance.isCelsius = true
                GlobalStates.sharedInstance.tempUnit = "°C"
                
            } else {
                GlobalStates.sharedInstance.isCelsius = false
                GlobalStates.sharedInstance.tempUnit = "°F"
            }
            
        } else {
            print("Temperature unit not found")
        }
        
    }
    
    
    // MARK: - Views
    // ------------------------------------------------------------------------
    
    func setView() {
        
        
        let popover = NSPopover()
        
        let count = GlobalStates.sharedInstance.deviceData.count
        if count < 1 && (viewState == .SINGLE || viewState == .COMPACT) {
            viewState = .LOGIN
            GlobalStates.sharedInstance.currentStation = 0
        }

        if viewState == .LOGIN {
            // Create the popover
            let contentView = LoginView()
            popover.contentSize = NSSize(width: 300, height: 200)
            popover.behavior = .transient
            popover.contentViewController = NSHostingController(rootView: contentView)
        }

        if viewState == .SINGLE {
            // Create the popover
            let contentView = ContentView()
            popover.contentSize = NSSize(width: 400, height: 450)
            popover.behavior = .transient
            popover.contentViewController = NSHostingController(rootView: contentView)
        }
        
        if viewState == .SETTINGS {
            // Create Settings View
            let contentView = SettingsView()
            popover.contentSize = NSSize(width: 400, height: 500)
            popover.behavior = .transient
            popover.contentViewController = NSHostingController(rootView: contentView)
            
            
        }
        
        if viewState == .ERROR {
            // Create Settings View
            let contentView = ErrorView()
            popover.contentSize = NSSize(width: 200, height: 200)
            popover.behavior = .transient
            popover.contentViewController = NSHostingController(rootView: contentView)
            
            
        }
        
        self.popover = popover

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
                    getTemperatureSettings()
                    self.popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
                    self.popover.contentViewController?.view.window?.becomeKey()
                    eventMonitor?.start()
            }
         }
    }

    
    func updateStatusBar() {
        
        print("Update Statusbar")
        
        if GlobalStates.sharedInstance.currentStation < 0 { return }
        
        let data = GlobalStates.sharedInstance.deviceData[GlobalStates.sharedInstance.currentStation]
        let calc = Calculations()
        
        var statusString = ""
        
        // Show Module Name
        if GlobalStates.sharedInstance.globalSettings.showStationName {
            statusString = data.station_name ?? "N/A"
            statusString = statusString + ": "
        }
        
        // Show Temperature in Menubar
        if GlobalStates.sharedInstance.globalSettings.showTemp {
            if GlobalStates.sharedInstance.isCelsius {
                statusString = statusString + "\(calc.numberFormatterDoubleToString(d: data.Temperature))°C"
            } else {
                statusString = statusString + "\(calc.numberFormatterDoubleToString(d: data.TemperatureF))°F"
            }
        }
        
        // Show Humidity in Menubar
        if GlobalStates.sharedInstance.globalSettings.showHumidity {
            if GlobalStates.sharedInstance.globalSettings.showTemp{statusString = statusString + GlobalStates.sharedInstance.separatorSymbol}
            
            statusString = statusString + "\(calc.numberFormatterDoubleToString(d: data.Humidity))%"
            
        }
        
        // Show CO2 in Menubar
        if GlobalStates.sharedInstance.globalSettings.showCO2 {
            if GlobalStates.sharedInstance.globalSettings.showTemp ||
            GlobalStates.sharedInstance.globalSettings.showHumidity { statusString = statusString + GlobalStates.sharedInstance.separatorSymbol}
            
            statusString = statusString + "\(calc.numberFormatterDoubleToString(d: data.CO2))ppm"
            
        }
        
        // Show Noise in Menubar
        if GlobalStates.sharedInstance.globalSettings.showNoise {
            if GlobalStates.sharedInstance.globalSettings.showTemp ||
            GlobalStates.sharedInstance.globalSettings.showHumidity ||
            GlobalStates.sharedInstance.globalSettings.showCO2 { statusString = statusString + GlobalStates.sharedInstance.separatorSymbol}
            
            statusString = statusString + "\(calc.numberFormatterDoubleToString(d: data.Noise))db"
            
        }
        
        self.statusBarItem.button?.title = statusString
    }
    

    
    
    
    // MARK: - Popover
    // ------------------------------------------------------------------------
    
    func showPopOver(_ sender: AnyObject?) {
    
    
    }
    
    func openSettings() {
        
        if self.popover.isShown {
             self.popover.performClose(nil)
              eventMonitor?.stop()
        }
        
        
        viewState = .SETTINGS
        setView()

        self.popover.show(relativeTo: statusBarItem.button!.bounds, of: statusBarItem.button!, preferredEdge: NSRectEdge.minY)
        self.popover.contentViewController?.view.window?.becomeKey()
        
        
    }
    
    func closeSettings() {
        
        print ("Close Settings")
        
        if viewState == .SETTINGS {
            
            if self.popover.isShown {
                 self.popover.performClose(nil)
                  eventMonitor?.stop()
            }
            
            viewState = .SINGLE
            setView()
            
        }
    }
    
    // MARK: - Timer
    // -------------
    
    @objc func fireTimeUpdateNetatmo() {
//        print ("Timer fired: \(timerCounter)")
//
//        print("StateCheck: \(GlobalStates.sharedInstance.globalSettings.showTemp)")
        
        timerCounter += 1
        
        if timerCounter >= timerInterval {
            
            netatmoUpdate()
            timerCounter = 0
        }
        
        
        
    }
    
    
    // MARK: - Netatmo Request
    // -----------------------
    func netatmoUpdate() {
        
        let refreshToken:String?  = UserDefaults.standard.string(forKey: "refreshToken")
        if refreshToken == nil {print("No refresh token saved"); return }
        
        print ("Token: \(refreshToken!)")
        
        let net = NetatmoConnect()
        net.requestNetatmoData()
        
        
        
    }
    
    // MARK: - Notifications
    // -------------------------------------------------------------------------
    
    @objc func authenticationSuccessful() {
        
        print ("Auth successful")

    }
    
    
    @objc func updateSuccessful() {
        
        print ("Update successful")

        let count = GlobalStates.sharedInstance.deviceData.count
        
        if count > 0 {
            
//            let data = GlobalStates.sharedInstance.deviceData[0]
            GlobalStates.sharedInstance.currentStation = 0
//            print ("---------------")
//            print (data.station_name)
//            print (data.Temperature)
//            print ("---------------")
            
            viewState = .SINGLE
            setView()
            self.updateStatusBar()
        }
        
    }
    
    @objc func updateFailed() {
        print ("Update failed")
        viewState = .ERROR
        setView()
        
    }
    
    
// EOF
}

