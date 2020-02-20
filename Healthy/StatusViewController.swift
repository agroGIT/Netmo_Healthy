//
//  StatusViewController.swift
//  Battery
//
//  Created by Andreas Großauer on 23.06.15.
//  Copyright (c) 2015 Andreas Grossauer. All rights reserved.
//

import Cocoa

class StatusViewController: NSViewController {
    


    @IBOutlet weak var statusImage: NSImageView!
//    @IBOutlet weak var labelPercent: NSTextField!
//    @IBOutlet weak var labelTime: NSTextField!
    @IBOutlet var statView: NSView!
    
    @IBOutlet weak var labelBig: NSTextField!

    
    override func viewDidLoad() {
        super.viewDidLoad()
 //       labelBig.stringValue = ""
     //   labelBig.stringValue = "N"
        
        // Do view setup here.
    }
    
   
    override func mouseDown(with theEvent: NSEvent) {
      
      //  print("Click")
        let appDel: AppDelegate = (NSApplication.shared.delegate as! AppDelegate)
//        appDel.clickOnStatusBar(theEvent.window)
        
    }
    
    
    func setString(str:String) {
        
        
        
        self.labelBig.stringValue = str
    }
    
    
    
    func updateSize(string:String) {

//        let font = NSFont.userFont(ofSize: NSFont.systemFontSize)
//        let attributes = NSDictionary(object: font!, forKey:NSAttributedStringKey.font as NSCopying)
//        let sizeOfText = string.size(withAttributes: (attributes as!  [NSAttributedStringKey : AnyObject]))
        
  //      let sizeOfText = string.size(withAttributes: (attributes as! [String : AnyObject]))
        
//        var newSize:Int = 0
     
//        DispatchQueue.main.async {
//            
//            if !self.statusImage.isHidden {
//                // Image visible
//                if Int(sizeOfText.width) == 0 {
//                    newSize = 25
//                } else {
//                    newSize = Int(sizeOfText.width) + 35  // 43
//                }
//  
//            } else {
//                // Image not visible
//                newSize = Int(sizeOfText.width) + 20  //25
//                
//            }
//            
//            print ("Size: \(newSize)")
//            var frame = self.view.frame
//            frame = NSRect(x: self.view.frame.origin.x, y: self.view.frame.origin.y, width: CGFloat(newSize), height: self.view.frame.size.height)
//
//            self.view.frame = frame
//            print ("Frame: \(frame.width)")
//            print ("Changed: \(self.view.frame.width)")
//            print("---------------------")
//            
//        }
        
    }
    
    
    
    
}
