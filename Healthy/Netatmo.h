//
//  Netatmo.h
//  Temps
//
//  Created by Andreas Großauer on 15.04.13.
//
//

#import <Foundation/Foundation.h>


@interface Netatmo : NSObject {
    
    bool DebugMode;
    
    
    //    NSString *token;
    //    NSString *refreshToken;
    //    NSString *expires_in;
    
    //    NSString *deviceID;
    //    NSString *moduleIndoor;
    //    NSString *moduleOutdoor;
    
    
}

@property (strong, nonatomic) NSString *token;
@property (strong, nonatomic) NSString *refreshToken;
@property (strong, nonatomic) NSString *expires_in;
@property bool isFavorite;

@property (strong, retain) NSString *stationID;
@property (strong, retain) NSString *stationName;
@property (strong, retain) NSString *stationModuleName;
@property (strong, retain) NSString *stationLatitude;
@property (strong, retain) NSString *stationLongitude;
@property (strong, retain) NSString *stationTempC;      // a
@property (strong, retain) NSString *stationHumidity;   // b
@property (strong, retain) NSString *stationPressure;   // e
@property (strong, retain) NSString *stationPressureINHG;
@property (strong, retain) NSString *stationCO2;        // h
@property (strong, retain) NSString *stationSonometer;  // S
@property (strong, retain) NSString *stationBatteryPercent;

// Außenmodul
@property (strong, retain) NSString *outdoorModuleID;
@property (strong, retain) NSString *outdoorModuleName;
@property (strong, retain) NSString *outdoorModuleTempC;
@property (strong, retain) NSString *outdoorModuleHumidity;
@property (strong, retain) NSString *outdoorModuleBattery;
@property (strong, retain) NSString *outdoorModuleWifi;
@property (strong, retain) NSString *outdoorModuleType;
@property (strong, retain) NSString *outdoorModuleCO2;
@property (strong, retain) NSString *outdoorModuleMainDevice;
@property (strong, retain) NSString *outdoorMaxTempC;
@property (strong, retain) NSString *outdoorMinTempC;
@property (strong, retain) NSString *outdoorBatteryPercent;

//Innenmodul 1
@property (strong, retain) NSString *module1ID;
@property (strong, retain) NSString *module1Name;
@property (strong, retain) NSString *module1TempC;
@property (strong, retain) NSString *module1Humidity;
@property (strong, retain) NSString *module1Battery;
@property (strong, retain) NSString *module1Wifi;
@property (strong, retain) NSString *module1Type;
@property (strong, retain) NSString *module1CO2;
@property (strong, retain) NSString *module1MainDevice;
@property (strong, retain) NSString *module1BatteryPercent;

//Innenmodul 2
@property (strong, retain) NSString *module2ID;
@property (strong, retain) NSString *module2Name;
@property (strong, retain) NSString *module2TempC;
@property (strong, retain) NSString *module2Humidity;
@property (strong, retain) NSString *module2Battery;
@property (strong, retain) NSString *module2Wifi;
@property (strong, retain) NSString *module2Type;
@property (strong, retain) NSString *module2CO2;
@property (strong, retain) NSString *module2MainDevice;
@property (strong, retain) NSString *module2BatteryPercent;

//Innenmodul 3
@property (strong, retain) NSString *module3ID;
@property (strong, retain) NSString *module3Name;
@property (strong, retain) NSString *module3TempC;
@property (strong, retain) NSString *module3Humidity;
@property (strong, retain) NSString *module3Battery;
@property (strong, retain) NSString *module3Wifi;
@property (strong, retain) NSString *module3Type;
@property (strong, retain) NSString *module3CO2;
@property (strong, retain) NSString *module3MainDevice;
@property (strong, retain) NSString *module3BatteryPercent;

// Rain Gauge
@property (strong, retain) NSString *moduleRainID;
@property (strong, retain) NSString *moduleRainName;
@property (strong, retain) NSString *moduleRainBattery;
@property (strong, retain) NSString *moduleRainWifi;
@property (strong, retain) NSString *moduleRainType;
@property (strong, retain) NSString *moduleRainMainDevice;
@property (strong, retain) NSString *moduleRainLastHour;
@property (strong, retain) NSString *moduleRainCumulativeToday;
@property (strong, retain) NSString *moduleRainForecastToday;
@property (strong, retain) NSString *moduleRainBatteryPercent;

// Windsensor
@property (strong, retain) NSString *moduleWindID;
@property (strong, retain) NSString *moduleWindName;
@property (strong, retain) NSString *moduleWindBattery;
@property (strong, retain) NSString *moduleWindWifi;
@property (strong, retain) NSString *moduleWindType;
@property (strong, retain) NSString *moduleWindMainDevice;
@property (strong, retain) NSString *moduleWindStrength;
@property (strong, retain) NSString *moduleWindAngle;
@property (strong, retain) NSString *moduleWindTimestamp;
@property (strong, retain) NSString *moduleWindGustStrength;
@property (strong, retain) NSString *moduleWindGustAngle;
@property (strong, retain) NSString *moduleWindBatteryPercent;


@property bool moduleIndoorAvailable1;
@property bool moduleIndoorAvailable2;
@property bool moduleIndoorAvailable3;
@property bool moduleRainAvailable;
@property bool moduleWindAvailable;

@property bool stationOutdated;
@property bool outdoorOutdated;
@property bool module1Outdated;
@property bool module2Outdated;
@property bool module3Outdated;
@property bool moduleRainOutdated;
@property bool moduleWindOutdated;

// MultiStation

@property NSInteger stationCounter;

@property (strong, retain) NSString *stationID_1;
@property (strong, retain) NSString *stationName_1;

@property (strong, retain) NSString *stationID_2;
@property (strong, retain) NSString *stationName_2;

@property (strong, retain) NSString *stationID_3;
@property (strong, retain) NSString *stationName_3;

@property (strong, retain) NSString *stationID_4;
@property (strong, retain) NSString *stationName_4;

@property (strong, retain) NSString *stationID_5;
@property (strong, retain) NSString *stationName_5;


@property int moduleCounter;
@property int rainGaugeCounter;

@property int useStationNumber;

@property int windSensorCounter;



- (NSString*) authentication:(NSString*)username Password:(NSString*)password;
- (NSString*) getStationData:(NSString*) rToken ;
- (NSString *)percentEscapeString:(NSString *)string;
- (NSData*) netatmoRequest:(NSString*)url Data:(NSString*)post;


- (NSInteger) getStationCounter;



- (void)getNetatmoStation;
- (void)getNetatmoStationAmazon;
- (void)needNetatmoInfos;



@end
