//
//  Calculations.swift
//  Netatmo
//
//  Created by Andreas Großauer on 24.02.17.
//  Copyright © 2017 Andreas Großauer. All rights reserved.
//

import Foundation






// --------------------------------------------------------------------------------------------------------------------
// MARK: - Calculations
// --------------------------------------------------------------------------------------------------------------------


class Calculations: NSObject {
    
    var unit:UUnit = .METRIC

    func KMHToBEAUFORT_String (_ str: String?) -> String {
        
        if str == nil {return "N/A"}
        
        var unit:Float = (str! as NSString).floatValue
        
        if (unit <= 2) {unit = 0;}
        if (unit > 2 && unit <= 5) {unit = 1}
        if (unit >= 6 && unit <= 11) {unit = 2}
        if (unit >= 12 && unit <= 19) {unit = 3}
        if (unit >= 20 && unit <= 28) {unit = 4}
        if (unit >= 29 && unit <= 38) {unit = 5}
        if (unit >= 39 && unit <= 49) {unit = 6}
        if (unit >= 50 && unit <= 61) {unit = 7}
        if (unit >= 62 && unit <= 74) {unit = 8}
        if (unit >= 75 && unit <= 88) {unit = 9}
        if (unit >= 89 && unit <= 102) {unit = 10}
        if (unit >= 103 && unit <= 117) {unit = 11}
        if (unit > 117) {unit = 12}
        
        return String.localizedStringWithFormat("%.0f", unit)
        
    }
    
    func KMHToKNOTS_String (_ str: String?) -> String {
        
        if str == nil {return "N/A"}
        
        var number:Float = (str! as NSString).floatValue
        
        number = number * 0.53995680346039
        
        return pointToKomma(String.localizedStringWithFormat("%.2f", number))
        
    }
    
    func KMHToMS_String (_ str: String?) -> String {
        
        if str == nil {return "N/A"}
        
        var number:Float = (str! as NSString).floatValue
        
        number = number * 0.27777777777778
        
        return pointToKomma(String.localizedStringWithFormat("%.2f", number))
        
    }
    
    func KMHToMPH_String (_ str: String?) -> String {
        
        if str == nil {return "N/A"}
        
        var number:Float = (str! as NSString).floatValue
        
        number = number * 0.621371
        
        return pointToKomma(String.localizedStringWithFormat("%.2f", number))
        
    }
    
    
    func mmToInch_String (_ str: String?) -> String {
        
        if str == nil {return "N/A"}
        
        var number:Float = (str! as NSString).floatValue
        
        number = number / 25.4
        
        return pointToKomma(String.localizedStringWithFormat("%.1f", number))
  
    }
    
    // ---------------------
    func KMHToBEAUFORT_Double (_ d: Double) -> Double {

        var str = d
        
        if (str <= 2) {   str = 0;}
        if (str > 2 &&    str <= 5) {  str = 1}
        if (str >= 6 &&   str <= 11) { str = 2}
        if (str >= 12 &&  str <= 19) { str = 3}
        if (str >= 20 &&  str <= 28) { str = 4}
        if (str >= 29 &&  str <= 38) { str = 5}
        if (str >= 39 &&  str <= 49) { str = 6}
        if (str >= 50 &&  str <= 61) { str = 7}
        if (str >= 62 &&  str <= 74) { str = 8}
        if (str >= 75 &&  str <= 88) { str = 9}
        if (str >= 89 &&  str <= 102) {str = 10}
        if (str >= 103 && str <= 117) {str = 11}
        if (str > 117) {  str = 12}
        
        return str
        //return String.localizedStringWithFormat("%.0f", str)
        
    }
    
    func KMHToKNOTS_Double (_ str: Double?) -> Double {
        
        var number:Double = str ?? -999
        number = number * 0.53995680346039
        return number
 
    }
    
    func KMHToMS_Double (_ str: Double?) -> Double {
        
        var number:Double = str ?? -999
        number = number * 0.27777777777778
        return number
    }
    
    func KMHToMPH_Double (_ str: Double?) -> Double {
        
        var number:Double = str ?? -999
        number = number * 0.621371
        return number
    }
    
    
    func mmToInchString (_ str: String?) -> String {
        
        if str == nil {return "N/A"}
        
        var number:Float = (str! as NSString).floatValue
        
        number = number / 25.4
        
        return pointToKomma(String.localizedStringWithFormat("%.1f", number))
        
    }
    // ---------------------
    

    func mmToInchDouble (number: Double?) -> Double {
        
        if number == nil {return -999}
        
        let result = number! / 25.4
        
        return result
        
    }
    
    
    func celsiusToFahrenheitString (_ str: String?) -> String {
        
        if str == nil {return "--"}
        if str == "N/A" {return "--"}
        
        
        var number:Float = (str! as NSString).floatValue
        
        number = number * 1.8 + 32
        
        return pointToKomma(String.localizedStringWithFormat("%.1f", number))
 
    }
    func celsiusToFahrenheitDouble (number:Double?) -> Double {

        if number == nil {return -999}
        
        let result = number! * 1.8 + 32.0
        return result
        
    }
    
    func mBarTOinHGString (_ str: String?) -> String {
        
        if str == nil {return "--"}
        
        let number:Float = (str! as NSString).floatValue
        let inch:Float = 0.02952998751
        let mbar = number * inch
        
        return pointToKomma(String.localizedStringWithFormat("%.1f", mbar))
        
    }
    
    func mBarTOinHGDouble (number: Double) -> Double {
  
        let mbar = number * 0.02952998751
        
        return mbar
        
    }
    
    
    // Auf ein Nachkommastelle runden
    func runden (_ str: String?) -> String {
        
        
        if str == "N/A" {return "--"}
        
        if str == nil {return "-"}
        
        let number:Float = (str! as NSString).floatValue
        
        return pointToKomma(String.localizedStringWithFormat("%.1f", number))
        
    }
    
    
    
    
    // Auf ein Nachkommastelle runden
    func rundenDouble (_ d: Double) -> Double {

//        if d > 999 { return pointToKomma(String.localizedStringWithFormat("%.0f", d)) }
        
        return Double(round(10*d)/10)
        
        //return pointToKomma(String.localizedStringWithFormat("%.1f", d))
        
    }
    
        func roundDoubleToString (_ d: Double) -> String {

            
            return pointToKomma(String.localizedStringWithFormat("%.1f", d))
            
        }
    
    
    // Kaufmännisches Runden String -> String
    func kaufmRunden (_ str:String?) -> String {
        
        if str == nil {return "--"}
        if str == "N/A" {return "--"}
        
        var newStr: String = ""
        
        for var char in (str)! {
            
            if char == "," {char = "."}
            newStr.append(char)
            
        }
        
        var number:Float = (newStr as NSString).floatValue
        
        if number >= 0 {
            let min:Float = Float(Int(number)) // (String.localizedStringWithFormat("%.0f", number) as NSString).floatValue
            let max:Float = min + 1
            let maxdiff:Float = max - number
            if maxdiff > 0.5 {
                number = min
            } else {
                number = max
            }
        } else {
            
            let min:Float = Float(Int(number)) // (String.localizedStringWithFormat("%.0f", number) as NSString).floatValue
            let max:Float = min - 1
            let maxdiff:Float = max - number
            if maxdiff <= -0.5 {
                number = min
            } else {
                number = max
            }
            
        }
        
        return pointToKomma(String(Int(number)))
    }
    
    
    
    
    func pointToKomma (_ str:String?) -> String {
    
        let result = ""
//
//        if str == nil {return "-"}
//        if str == "N/A" {return "-"}
//
////        let number:Float = (str! as NSString).floatValue
////        if number == 0 { return "0" }
//
//        //  if unit == .IMPERIAL {
//        if GlobalStates.sharedInstance.useDotSeparator == true {
//
//            for var n in str! {
//
//                if n == "," {n = "."}
//                result.append(n)
//            }
//
//        } else {
//
//            for var n in str! {
//
//                if n == "." {n = ","}
//                result.append(n)
//            }
//        }
        
        return result
    }
    

    
    
    // Get Wind Angle
    func getWindDirection(_ angleStr:String?) -> String
    {
        if angleStr == nil {return "N/A"}
        
        var angle = Float(angleStr!)
        
        if angle == nil {angle = 0}
        var result = ""
        let ang:Float = 22.5
        var a:Float = 11.25
        
        
        if (angle! > a && angle! <= a + 22.5) {result = "NNE" }
        a = a + ang;
        if (angle! > a && angle! <= a + 22.5) {result = "NE" }
        a = a + ang;
        if (angle! > a && angle! <= a + 22.5) {result = "ENE" }
        a = a + ang;
        if (angle! > a && angle! <= a + 22.5) {result = "E" }
        a = a + ang;
        if (angle! > a && angle! <= a + 22.5) {result = "ESE" }
        a = a + ang;
        if (angle! > a && angle! <= a + 22.5) {result = "SE" }
        a = a + ang;
        if (angle! > a && angle! <= a + 22.5) {result = "SSE" }
        a = a + ang;
        if (angle! > a && angle! <= a + 22.5) {result = "S" }
        a = a + ang;
        if (angle! > a && angle! <= a + 22.5) {result = "SSW" }
        a = a + ang;
        if (angle! > a && angle! <= a + 22.5) {result = "SW" }
        a = a + ang;
        if (angle! > a && angle! <= a + 22.5) {result = "WSW" }
        a = a + ang;
        if (angle! > a && angle! <= a + 22.5) {result = "W" }
        a = a + ang;
        if (angle! > a && angle! <= a + 22.5) {result = "WNW" }
        a = a + ang;
        if (angle! > a && angle! <= a + 22.5) {result = "NW" }
        a = a + ang;
        if (angle! > a && angle! <= a + 22.5) {result = "NNW" }
        a = a + ang;
        if (angle! >= a || angle! <= 11.25) {result = "N" }
        a = a + ang;
        
        return NSLocalizedString(result, comment: "")
    }

    
    func checkNIL (str:String?) -> String {
        
        if str == nil {return "--"}
        
        return str!
    }
    
    func stringToInt (str:String?) -> Int {
        
        if str == nil { return 0 }
        
        return Int(str!) ?? 0
        
    }
    
    func getWIFIStrenght(val:Int) -> Int {
        
        if val <= 58 { return 5 }
        if val > 58 && val <= 69 { return 4 }
        if val > 69 && val <= 77 { return 3 }
        if val > 77 && val <= 86 { return 2 }
        if val >= 87 { return 1 }
        
        return 0
    }
    
    
    // MARK: - New Number Fomatters
    
    func numberFormatterDoubleToString(d:Double?) -> String {
        
        if d == nil { return "N/A" }
        
        let number:NSNumber = NSNumber.init(value: d!)
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .decimal
        formatter.locale = Locale.current
        
        let result = formatter.string(from: number)
        return result ?? "N/A"
    }
    
    
    
    // --------------------------------------------------------------------------------------------------------------------
    // MARK: - Time Calculations
    // --------------------------------------------------------------------------------------------------------------------
    
    func timeFromTimeStamp (stamp: TimeInterval) -> String {
        
        let date = NSDate (timeIntervalSince1970: stamp)
        //     print("\(date)")
        
        
        
        return "\(date)"
    }
    // Today
    func getTimeStampToday() -> TimeInterval {
        
        let date = Date()
        let calendar = Calendar.current
        let date2 = calendar.date(bySettingHour: 0, minute: 0, second: 0, of: date)
        let timestamp = date2?.timeIntervalSince1970
        
        
        return timestamp!
        
    }
    
    func getTimeStringFromTimestamp(stamp: TimeInterval) -> String {
        
        let date = NSDate (timeIntervalSince1970: stamp)
        let calendar = Calendar.current
        let h = calendar.component(.hour, from: date as Date)
        let m = calendar.component(.minute, from: date as Date)
        
        
        return "\(h):\(m)"
    }
    
    func getDateTimeStringFromTimestamp(stamp: TimeInterval) -> String {
        
        let date = NSDate (timeIntervalSince1970: stamp)
        let calendar = Calendar.current
        let h = calendar.component(.hour, from: date as Date)
        let m = calendar.component(.minute, from: date as Date)
        let day = calendar.component(.day, from: date as Date)
        let month = calendar.component(.month, from: date as Date)
        let year = calendar.component(.year, from: date as Date)
        return "\(day).\(month).\(year) - \(h):\(m)"
        
        
    }
    
    func getDateTimeStringFromTimestamp2 (stamp: TimeInterval) -> String {

        let dateFormatter = DateFormatter()
        let dt = Date(timeIntervalSince1970: stamp) //dateFormatter.date(from: date!)
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.string(from: dt)
        
        
        
//        let date = NSDate (timeIntervalSince1970: stamp)
//        let calendar = Calendar.current
//        let day = calendar.component(.day, from: date as Date)
//        let month = calendar.component(.month, from: date as Date)
//        let year = calendar.component(.year, from: date as Date)
//        return "\(year)-\(month)-\(day)"


    }
    
    func UTCToLocal(date:String?) -> String {
        
        if date == nil { return "nil" }
        let d_date:Double? = Double(date!)
        if d_date == nil {return "nil"}
        let dateFormatter = DateFormatter()
     //   dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss "
     //   dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        let dt = Date(timeIntervalSince1970: d_date!) //dateFormatter.date(from: date!)
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        return dateFormatter.string(from: dt)
    }
    
    // Get Yesterday timestamp
    func getTimeStampYesterday() -> TimeInterval {
        
        let date = Date()
        let calendar = Calendar.current
        let date2 = calendar.date(bySettingHour: 0, minute: 0, second: 0, of: date)
        var timestamp = date2?.timeIntervalSince1970
        timestamp = timestamp! - (24*3600)
        
        //     print("Timestamp Yesterday: \(String(describing: timestamp))")
        
        return timestamp!
    }
    
    
    // Get 24h Timestamp
    func getTimeStamp24Hours() -> TimeInterval {
        
        let date = Date()
        let calendar = Calendar.current
        var m = calendar.component(.minute, from: date as Date)
        let h = calendar.component(.hour, from: date as Date)
        if m > 0 && m < 30 {m = 0}
        if m > 30  {m = 30}
        let date2 = calendar.date(bySettingHour: h, minute: m, second: 0, of: date)
        var timestamp = date2?.timeIntervalSince1970
        timestamp = timestamp! - (24*3600) + (3600/2)
        
        var startTimeDouble = Double(h)
        if m == 30 {startTimeDouble += 0.5}
        
        //     print("StartTime: \(startTimeDouble)")
        
        /*
         let date = Date()
         var timestamp = date.timeIntervalSince1970
         timestamp = timestamp - (24*3600)
         */
        return timestamp!
    }
    
    func getTimeStampWeek() -> TimeInterval {
        
        var date = Date()
        let calendar = Calendar.current
        let day = calendar.component(.day, from: date as Date)
        let month = calendar.component(.month, from: date as Date)
        let year = calendar.component(.year, from: date as Date)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        date = dateFormatter.date(from: "\(year)-\(month)-\(day) 00:00:01")!
        
        var timestamp = date.timeIntervalSince1970
        timestamp = timestamp - (7 * 24 * 3600)
        
        return timestamp
    }
    
    func getTimeStampMonth() -> TimeInterval {
        
        var date = Date()
        let calendar = Calendar.current
        let day = calendar.component(.day, from: date as Date)
        let month = calendar.component(.month, from: date as Date)
        let year = calendar.component(.year, from: date as Date)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        date = dateFormatter.date(from: "\(year)-\(month)-\(day) 00:00:01")!
        
        var timestamp = date.timeIntervalSince1970
        timestamp = timestamp - (30 * 24 * 3600)
        
        return timestamp
    }
    
    
    func getTimeStampMonth_Year(month:Int, year:Int) -> TimeInterval {
        
        let month:String = "\(month)"
        let year:String = "\(year)"
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: "\(year)-\(month)-01 00:00:01")
        
        let timestamp = date?.timeIntervalSince1970
        return timestamp!
        
        
        
    }
    
    

    
    
    func getTimeStampYear() -> TimeInterval {
        
        let date = Date()
        var timestamp = date.timeIntervalSince1970
        timestamp = timestamp - (365 * 24*3600)
        
        return timestamp
    }
    
    
    
    // MARM: -
    
//    func calculateTimePeriod(p:PPeriod) -> (from:Double, to:Double, nrElements:Int) {
//
//       // let calc = Calculations()
//        var rFrom:Double     = 0
//        var rTo:Double       = 0
//        var numberOfElements = 0
//
//
//        // Calculate Time period
//        if p == .TWENTY_FOUR_HOUR {
//            rFrom = getTimeStamp24Hours()
//            rTo = rFrom + Double( 3600.0 * 24.0 )
//            numberOfElements = 24 * 2
//
//        }
//
//        if p == .WEEK {
//            rFrom = getTimeStampWeek()
//            rTo = rFrom + Double( 8 * 24 * 3600 )
//            numberOfElements = 0 //24 * 2 * 8 - 5
//        }
//
//        if p == .TODAY {
//            rFrom = getTimeStampToday()
//            rTo = NSDate().timeIntervalSince1970
//            numberOfElements = Int((rTo-rFrom) / 3600 * 2 )
//        }
//
//        if p == .YESTERDAY {
//            rFrom = getTimeStampYesterday()
//            rTo = rFrom + Double( 24 * 3600 )
//            numberOfElements = 24 * 2
//        }
//
//        if p == .MONTH {
//            rFrom = getTimeStampMonth()
//            rTo = rFrom + Double( 24 * 3600 * 31)
//            numberOfElements = 0 //24 * 2 * 31 - 5
//        }
//
//
//        if p == .WEEK_REQUEST {
//            rFrom = getTimeStampWeek()
//            rTo = NSDate().timeIntervalSince1970
//            numberOfElements = Int((rTo-rFrom) / 3600 * 2 )
//        }
//
//        if p == .YEAR {
//
//            rFrom = getTimeStampYear()
//            rTo = NSDate().timeIntervalSince1970
//
//
//        }
//
//
//
//        return (rFrom, rTo, numberOfElements)
//    }
    
    func calculateTimePeriodMonth(month:Int, year:Int) -> (from:Double, to:Double, nrElements:Int) {
        var rFrom:Double     = 0
        var rTo:Double       = 0
 
        var m = month
        var y = year

        // Monatsanfang
        var month:String = "\(month)"
        var year:String = "\(year)"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        var date = dateFormatter.date(from: "\(year)-\(month)-01 00:00:00")
        
        rFrom = date?.timeIntervalSince1970 ?? 0
        
        
        
        // Monatsende
        m += 1
        if m > 12 {m = 1; y += 1}
        month = "\(m)"
        year = "\(y)"
//        dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        date = dateFormatter.date(from: "\(year)-\(month)-01 00:00:00")
        rTo = date?.timeIntervalSince1970 ?? 0
        rTo -= 2 // 2 Sekunden abziehen, dann ist es 23:59:59 vom Vortag
        
   //     print ("\(rFrom), \(rTo)")
        
        if (rFrom == 0 || rTo == 0) { return (0,0,0) }
        
        return (rFrom, rTo, 0)
        
    
    }
    
    func getTimestampForYear(year:Int) -> (from: Double, to: Double, nrElements:Int) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        var date = dateFormatter.date(from: "\(year)-01-01 00:00:01")
        let timestamp_from = date?.timeIntervalSince1970 ?? 0
        
        date = dateFormatter.date(from: "\(year + 1)-01-01 00:00:01")
        
        
        let timestamp_to = date?.timeIntervalSince1970 ?? 0
        
        if (timestamp_from == 0 || timestamp_to == 0) { return (0,0,0) }
        
        
        
        return (timestamp_from, timestamp_to, 0)
        
        
    }
    
    
    
    
    // EOF
}
