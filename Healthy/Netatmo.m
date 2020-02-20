//
//  Netatmo.m
//  Temps
//
//  Created by Andreas Großauer on 15.04.13.
//
//

#import "Netatmo.h"
//#import "Netmo-Swift.h"


//TODO: Anpassen
//#define CLIENT_ID       @"516323ac187759191b000024"
//#define CLIENT_SECRET   @"Awdof7u4B0oqfsDPLJGi7aXF1dy0AQ30y"

//#define CLIENT_ID       @"58b56c52c8bd002bb18b541d"
//#define CLIENT_SECRET   @"Wdu7ZsFvqbhL2itLTgKLetz9UTfJrZPnP9PazQKQvo0"


#define DAY             1
#define WEEK            2
#define MONTH           3



@implementation Netatmo



- (id) init
{
    if (self = [super init])
    {
        
        _stationID = @"";
        _stationName = @"";
        _stationModuleName= @"";
        _stationLatitude= @"";
        _stationLongitude= @"";
        _stationTempC= @"";     // a
        _stationHumidity= @"";  // b
        _stationPressure= @"";   // e
        _stationPressureINHG = @"";
        _stationCO2= @"";       // h
        _stationSonometer= @"";  // S
        _outdoorModuleID= @"";
        _outdoorModuleTempC= @"";
        _outdoorModuleHumidity= @"";
        _module2ID= @"";
        _module2TempC= @"";
        _module2Humidity= @"";
        _module3ID= @"";
        _module3TempC= @"";
        _module3Humidity= @"";
        _module3ID = @"";
        _module3TempC = @"";
        _module2ID = @"";
        _module2Battery = @"";
        _module2Name = @"";
        _module2Type = @"";
        _module3Battery = @"";
        _module3Name = @"";
        _module3Type = @"";
        _outdoorModuleBattery = @"";
        _outdoorModuleName = @"";
        _outdoorModuleType = @"";
        _outdoorModuleCO2 = @"";
        _module2CO2 = @"";
        _module3CO2 = @"";
        
        
        _moduleCounter = 0;
        _stationCounter = 0;
        _isFavorite = false;
        
        _module1MainDevice = @"";
        _module2MainDevice = @"";
        _module3MainDevice = @"";
        
        
        _stationName_1 = @"";
        _stationName_2 = @"";
        _stationName_3 = @"";
        _stationName_4 = @"";
        _stationName_5 = @"";
        _stationID_1 = @"";
        _stationID_2 = @"";
        _stationID_3 = @"";
        _stationID_4 = @"";
        _stationID_5 = @"";
        
        
        _token = @"";
        _refreshToken = @"";
        _expires_in = @"";
        _stationID = @"";
        _stationName = @"";
        _stationModuleName = @"";
        _stationLatitude = @"";
        _stationLongitude = @"";
        _stationTempC = @"";
        _stationHumidity = @"";
        _stationPressure = @"";   // e
        _stationCO2 = @"";        // h
        _stationSonometer = @"";  // S
        _outdoorModuleID = @"";
        _outdoorModuleName = @"";
        _outdoorModuleTempC = @"";
        _outdoorModuleHumidity = @"";
        _outdoorModuleBattery = @"";
        _outdoorModuleWifi = @"";
        _outdoorModuleType = @"";
        _outdoorModuleCO2 = @"";
        _outdoorModuleMainDevice = @"";
        _outdoorMaxTempC = @"";
        _outdoorMinTempC = @"";
        
        
        _module1ID = @"";
        _module1Name = @"";
        _module1TempC = @"";
        _module1Humidity = @"";
        _module1Battery = @"";
        _module1Wifi = @"";
        _module1Type = @"";
        _module1CO2 = @"";
        _module1MainDevice = @"";
        
        _module2ID = @"";
        _module2Name = @"";
        _module2TempC = @"";
        _module2Humidity = @"";
        _module2Battery = @"";
        _module2Wifi = @"";
        _module2Type = @"";
        _module2CO2 = @"";
        _module2MainDevice = @"";
        
        _module3ID = @"";
        _module3Name = @"";
        _module3TempC = @"";
        _module3Humidity = @"";
        _module3Battery = @"";
        _module3Wifi = @"";
        _module3Type = @"";
        _module3CO2 = @"";
        _module3MainDevice = @"";
        
        //Rain
        _moduleRainID = @"";
        _moduleRainName = @"";
        _moduleRainBattery = @"";
        _moduleRainWifi = @"";
        _moduleRainType = @"";
        _moduleRainMainDevice = @"";
        _moduleRainLastHour = @"";
        _moduleRainCumulativeToday = @"";
        _moduleRainForecastToday = @"";
        
        _moduleIndoorAvailable1 = NO;
        _moduleIndoorAvailable2 = NO;
        _moduleIndoorAvailable3 = NO;
        _moduleRainAvailable = NO;
        _moduleWindAvailable = NO;
        
        // Wind
        _moduleWindBattery = @"";
        _moduleWindWifi = @"";
        _moduleWindID = @"";
        _moduleWindType = @"";
        _moduleWindAngle = @"";
        _moduleWindMainDevice = @"";
        _moduleWindName = @"";
        _moduleWindStrength= @"";
        _moduleWindTimestamp = @"";
        _moduleWindGustAngle  = @"";
        _moduleWindGustStrength  = @"";
        _moduleWindAvailable = NO;
        
        _stationOutdated = false;
        _outdoorOutdated = false;
        _module1Outdated = false;
        _module2Outdated = false;
        _module3Outdated = false;
        _moduleRainOutdated = false;
        _moduleWindOutdated = false;
        
        
        DebugMode = true;
        
        
    }
    
    
    return self;
    
}


- (NSInteger) getStationCounter {
    return _stationCounter;
}



- (NSString*) authentication:(NSString*)username Password:(NSString*)password
{
    _token = nil;
    _refreshToken = nil;
    _expires_in = nil;

    username = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,(CFStringRef)username,NULL,(CFStringRef)@"!*'();:@&=+$,/?%#[]",kCFStringEncodingUTF8 ));
    password = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,(CFStringRef)password,NULL,(CFStringRef)@"!*'();:@&=+$,/?%#[]",kCFStringEncodingUTF8 ));
    
    NSData *responseData;
    NSString *CLIENT_ID = @"5e4c2c6c273f774eeb321756";
    NSString *CLIENT_SECRET = @"0STfjEvV5iYSl8GO2PvPVixSscbmTjC2gHIkZQ0cg1";
    NSString *post = [NSString stringWithFormat:@"scope=read_homecoach&client_id=%@&client_secret=%@&grant_type=password&username=%@&password=%@", CLIENT_ID, CLIENT_SECRET, username, password];
    NSString *url = @"https://api.netatmo.net/oauth2/token";
    
    responseData = [self netatmoRequest:url Data:post];

    if (responseData == nil) {return nil;}

    // Parsen
    NSError* error;
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:responseData //1
                          
                          options:kNilOptions
                          error:&error];

    // Wenn Fehler
    NSArray *aError = [json objectForKey:@"error"];
    if (aError != nil) {
        NSLog(@"Error: %@",[NSString stringWithFormat:@"%@", aError]);
        return nil;
    }
    
    NSArray* aToken = [json objectForKey:@"access_token"];
    _token = [NSString stringWithFormat:@"%@", aToken];
    
    NSArray* aRefreshToken = [json objectForKey:@"refresh_token"];
    _refreshToken= [NSString stringWithFormat:@"%@", aRefreshToken];
    
    NSArray* expires = [json objectForKey:@"expires_in"];
    _expires_in = [NSString stringWithFormat:@"%@", expires];

    return _token;
    
}


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// API-Änderung von Netatmo 05/2017
- (NSString*) getStationData:(NSString*) rToken  { // StationNr:(int) stationNr AllowFavorites:(bool) allowFavorites

//    if (stationNr < 1) stationNr = 0;
//    if (stationNr > 5) {stationNr = 0; NSLog(@"Station Max reached");}
    
    //#warning nslog
    //  NSLog(@"Get Netatmo Data");
    
    
    // Neuen Token holen
    // Das sollte in eine eigene Funktion ausgelagert werden
    _token = nil;
    _refreshToken = nil;
    _expires_in = nil;
    NSString *CLIENT_ID = @"5e4c2c6c273f774eeb321756";
    NSString *CLIENT_SECRET = @"0STfjEvV5iYSl8GO2PvPVixSscbmTjC2gHIkZQ0cg1";
    
    NSString *post = [NSString stringWithFormat:@"client_id=%@&client_secret=%@&grant_type=refresh_token&refresh_token=%@", CLIENT_ID, CLIENT_SECRET, rToken];
    NSString *url = @"https://api.netatmo.net/oauth2/token";
    NSData *responseData = [self netatmoRequest:url Data:post];
    if (responseData == nil) return nil;
    
    // Parsen
    NSError* error;
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:responseData
                          options:kNilOptions
                          error:&error];
    
    // Wenn Fehler
    
    NSArray *aError = [json objectForKey:@"error"];
    if (aError != nil)
    {
        NSLog(@"getStationData Error: %@",[NSString stringWithFormat:@"%@", aError]);
        return nil;
        
    }
    NSArray* aToken = [json objectForKey:@"access_token"];
    _token = [NSString stringWithFormat:@"%@", aToken];
    
    NSArray* aRefreshToken = [json objectForKey:@"refresh_token"];
    _refreshToken= [NSString stringWithFormat:@"%@", aRefreshToken];
    
    NSArray* expires = [json objectForKey:@"expires_in"];
    _expires_in = [NSString stringWithFormat:@"%@", expires];
    
    ////////////////////////////////
    
    // Device IDs holen
    
//    get_favorites REQUEST-Möglichkeit
    
 
    
//    if (allowFavorites) {
//        post = [NSString stringWithFormat: @"access_token=%@&get_favorites=true", _token];
//    } else {
//        post = [NSString stringWithFormat: @"access_token=%@", _token];
//    }
    
//
    
    
    
    //url = @"https://api.netatmo.net/api/devicelist"; // deprecated
    
    
    post = [NSString stringWithFormat: @"scope=read_homecoach&access_token=%@", _token];
    url = @"https://api.netatmo.com/api/gethomecoachsdata"; // https://api.netatmo.net/api/getstationsdata
    responseData = [self netatmoRequest:url Data:post];
    
    
    
    // Nil Prüfung
    if (responseData == nil) {NSLog(@"JSON data from Netatmo is nil");return nil;}
    
    // Parsen
    json = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
    
//    NSLog(@"Response: %@", json);
//    NSLog(@"Response!");
    
    
//    return _refreshToken;
    
    
    //Error Handling
    NSArray *bError = [json objectForKey:@"error"];
    if (bError != nil)
    {
        NSLog(@"Netatmo Request Error: %@",[NSString stringWithFormat:@"%@", bError]);
        return _refreshToken;
    }
    
    
    
    // In Dictionary speichern
    NSDictionary* aBody = [json objectForKey:@"body"];
    // Devices in Array
    NSArray *devices = [aBody objectForKey:@"devices"];
    // Devices zählen; wenn NULL dann abbrechen
    int countDevices = (int)[devices count];
    
//    NSLog(@"Device Count: %i", countDevices);
//    NSLog(@"----------------");
    
    if (countDevices == 0 ) {
        
        _stationCounter = 0;
        return _refreshToken;
    }
    
    

    
    for (int i = 0; i<[devices count] ;i++)
    {
        NSLog(@"%@", [devices objectAtIndex:i]);
        NSLog(@"----------------");
        
        if ( i == 0)
        {
            NSDictionary *device = [devices objectAtIndex:i];
            _stationID_1 = [device objectForKey:@"_id"];
            _stationName_1 = [device objectForKey:@"station_name"];
            _stationCounter = 1;
        }
        
        if ( i == 1)
        {
            NSDictionary *device = [devices objectAtIndex:i];
            _stationID_2 = [device objectForKey:@"_id"];
            _stationName_2 = [device objectForKey:@"station_name"];
            _stationCounter = 2;
        }
        
        if ( i == 2)
        {
            NSDictionary *device = [devices objectAtIndex:i];
            _stationID_3 = [device objectForKey:@"_id"];
            _stationName_3 = [device objectForKey:@"station_name"];
            _stationCounter = 3;
        }
        
        
        
        if ( i == 3)
        {
            NSDictionary *device = [devices objectAtIndex:i];
            _stationID_4 = [device objectForKey:@"_id"];
            _stationName_4 = [device objectForKey:@"station_name"];
            _stationCounter = 4;
        }
        
        
        if ( i == 4)
        {
            NSDictionary *device = [devices objectAtIndex:i];
            _stationID_5 = [device objectForKey:@"_id"];
            _stationName_5 = [device objectForKey:@"station_name"];
            _stationCounter = 5;
        }
        
        
    }
    
//    _useStationNumber = stationNr;
//    if ( _useStationNumber > [devices count] -1  ) _useStationNumber = 0;
//    if ([devices count] == 0) return _refreshToken;
//    if (_useStationNumber == 0) {_stationID = _stationID_1; }
//    if (_useStationNumber == 1) {_stationID = _stationID_2; }
//    if (_useStationNumber == 2) {_stationID = _stationID_3; }
//    if (_useStationNumber == 3) {_stationID = _stationID_4; }
//    if (_useStationNumber == 4) {_stationID = _stationID_5; }
    
    
    NSString *requestTime = @"";
    
    // Alle Devices durchlaufen
    for (int i = 0; i < countDevices; i++) {
        
        NSDictionary *device = [devices objectAtIndex:i];
        
        int timeout = 3600; // Timeout offset in Sec
        
        // Auf gesuchtes Device prüfen und eingrenzen
//        if ([[device objectForKey:@"_id"] isEqualToString:_stationID])
//        {
//            // Daten der Station auslesen und speichern
//            _stationName = [device objectForKey:@"station_name"];
//            _stationModuleName = [device objectForKey:@"module_name"];
//            if (_stationModuleName == nil || [_stationModuleName  isEqual: @""]) {_stationModuleName = @"--";  _stationModuleName = @"Main Station"; }
//            // Dashboard-Data
//            NSDictionary *station = [device objectForKey:@"dashboard_data"];
//            _stationTempC = [[station objectForKey:@"Temperature"] description];
//            _stationCO2 = [[station objectForKey:@"CO2"] description];
//            _stationHumidity = [[station objectForKey:@"Humidity"] description];
//            _stationPressure = [[station objectForKey:@"Pressure"] description];
//
//            _stationSonometer = [[station objectForKey:@"Noise"] description];
//            requestTime = [station objectForKey:@"time_utc"];
//
//            bool outdated = [self checkBegTime:requestTime diffInSeconds:timeout];
//            if (outdated)
//            {
//                NSLog(@"Station (%@) data is outdated", _stationModuleName);
//                _stationTempC = @"N/A";
//                _stationCO2 = @"N/A";
//                _stationPressure = @"N/A";
//                _stationSonometer = @"N/A";
//
//            } else {
//
//            }
//
//
//            bool fav = [device objectForKey:@"favorite"];
//            if (fav == true) { _isFavorite = true; } else { _isFavorite = false; }
//
//            //Position bestimmen
//            NSDictionary *place = [device objectForKey:@"place"];
//            NSArray *location = [ place objectForKey:@"location"];
//            for (int i=0; i< [location count]; i++)
//            {
//                // Longitude & Latitude getauscht V 1.11.2
//                if (i==0) _stationLongitude = [[location objectAtIndex:0] description];
//                if (i==1) _stationLatitude = [[location objectAtIndex:1] description];
//            }
//
//
//            // Module
//            NSArray *modules = [device objectForKey:@"modules"];
//
//            // Alles mal auf NULL setzen
//            _outdoorModuleID = nil;
//            _module1ID = nil;
//            _module2ID = nil;
//            _module3ID = nil;
//            _moduleRainID = nil;
//
//            _moduleRainAvailable = NO;
//            _moduleIndoorAvailable1 = NO;
//            _moduleIndoorAvailable2 = NO;
//            _moduleIndoorAvailable1 = NO;
//            _moduleWindAvailable = NO;
//
//            // NAModule1 = Außenmodul
//            // NAModule4 = Innenmodul (bis zu 3 Stück)
//            // NAModule3 = Regenmesser
//            // NAModule2 = Windmesser
//
//            // Module zählen
//            int countModules = (int)[modules count];
//
//            int indoorModuleCounter = 0;
//
//
//            for (int i2 = 0; i2 < countModules; i2 ++) {
//
//                NSDictionary *module = [modules objectAtIndex:i2];
//          //      NSLog(@"Result: %@", module);
//                // Außenmodul
//                if ([[module objectForKey:@"type"] isEqualToString:@"NAModule1"]) {
////                    NSLog(@"Found Outdoor Module");
//
//                    _outdoorModuleType = [module objectForKey:@"type"];
//                    _outdoorModuleID = [[module objectForKey:@"_id"] description];
//                    _outdoorModuleName = [module objectForKey:@"module_name"];
//                    if (_outdoorModuleName == nil || [_outdoorModuleName  isEqual: @""]) {_outdoorModuleName = @"--"; _outdoorModuleName = @"Outdoor";}
//                    _outdoorModuleBattery = [[module objectForKey:@"battery_vp"]  description];
//                    _outdoorBatteryPercent = [[module objectForKey:@"battery_percent"] description];
//                    NSDictionary *outside =  [module objectForKey:@"dashboard_data"];
//                    _outdoorModuleTempC = [[outside objectForKey:@"Temperature"] description];
//                    _outdoorModuleHumidity = [[outside objectForKey:@"Humidity"] description];
//                    _outdoorMaxTempC = [[outside objectForKey:@"max_temp"] description];
//                    _outdoorMinTempC = [[outside objectForKey:@"min_temp"] description];
//
//                    requestTime = [module objectForKey:@"last_message"];
//                    _outdoorModuleWifi = [[module objectForKey:@"rf_status"] description];
//                    bool outdated = [self checkBegTime:requestTime diffInSeconds:timeout];
//                    _outdoorOutdated = outdated;
//                    if (outdated)
//                    {
//                        NSLog(@"Outdoor (%@) data is outdated", _outdoorModuleName);
//                        _outdoorModuleTempC = @"N/A";
//                        _outdoorModuleHumidity = @"N/A";
//                    } else {
//
//
//                    }
//
//                }
//
//
//                // Regenmesser
//                if ([[module objectForKey:@"type"] isEqualToString:@"NAModule3"]) {
////                    NSLog(@"Found Rain Gauge");
//
//                    _moduleRainMainDevice = _stationID;
//                    _moduleRainID = [[module objectForKey:@"_id"] description];
//                    _moduleRainName = [module objectForKey:@"module_name"];
//                    if (_moduleRainName == nil || [_moduleRainName  isEqual: @""]) {_moduleRainName = @"--"; _moduleRainName = @"Rain";}
//                    _moduleRainType = [module objectForKey:@"type"];
//                    _moduleRainLastHour = [[module objectForKey:@"pluvio_scale_auget_to_mm"] description];
//                    _moduleRainBatteryPercent = [[module objectForKey:@"battery_percent"] description];
//                    _moduleRainAvailable = YES;
//                    _rainGaugeCounter = 1;
//                    NSDictionary *rain =  [module objectForKey:@"dashboard_data"];
//                    _moduleRainLastHour = [[rain objectForKey:@"sum_rain_1"] description];
//                    _moduleRainCumulativeToday = [[rain objectForKey:@"sum_rain_24"] description];
//                    float cum = [_moduleRainLastHour floatValue];
//                    _moduleRainLastHour = [NSString stringWithFormat:@"%.1f",cum];
//                    cum = [_moduleRainCumulativeToday floatValue];
//                    _moduleRainCumulativeToday = [NSString stringWithFormat:@"%.1f",cum];
//
//
//                    requestTime = [module objectForKey:@"last_message"];
//                    _moduleRainWifi = [[module objectForKey:@"rf_status"] description];
//                    bool outdated = [self checkBegTime:requestTime diffInSeconds:timeout];
//                    _moduleRainOutdated = outdated;
//                    if (outdated)
//                    {
//                        NSLog(@"Rain gauge (%@) data is outdated", _moduleRainName);
//                        _moduleRainLastHour = @"N/A";
//                        _moduleRainCumulativeToday = @"N/A";
//                    }
//
//                }
//
//
//                // Windmesser
//                if ([[module objectForKey:@"type"] isEqualToString:@"NAModule2"]) {
////                    NSLog(@"Found Wind Gauge");
//
//                    _moduleWindMainDevice = _stationID;
//                    _moduleWindID = [[module objectForKey:@"_id"] description];
//                    _moduleWindName = [module objectForKey:@"module_name"];
//                    if (_moduleWindName == nil || [_moduleWindName  isEqual: @""]) {_moduleWindName = @"--"; _moduleWindName = @"Wind";}
//                    _moduleWindType = [module objectForKey:@"type"];
//                    _moduleWindBatteryPercent = [[module objectForKey:@"battery_percent"] description];
//                    _moduleWindAvailable = YES;
//                    _windSensorCounter = 1;
//
//
//                    // Dashboard
//                    NSDictionary *wind =  [module objectForKey:@"dashboard_data"];
//                    _moduleWindStrength = [[wind objectForKey:@"WindStrength"] description];
//                    _moduleWindAngle = [[wind objectForKey:@"WindAngle"] description];
//                    _moduleWindGustAngle = [[wind objectForKey:@"GustAngle"] description];
//                    _moduleWindGustStrength = [[wind objectForKey:@"GustStrength"] description];
//
//                    ////
//
//                    _moduleWindTimestamp = [module objectForKey:@"last_message"];
//                    _moduleWindWifi = [[module objectForKey:@"rf_status"] description];
//                    requestTime = [module objectForKey:@"last_message"];
//                    bool outdated = [self checkBegTime:requestTime diffInSeconds:timeout];
//                    _moduleWindOutdated = outdated;
//                    if (outdated)
//                    {
//                        NSLog(@"Wind gauge (%@) data is outdated", _moduleWindName);
//                        _moduleWindStrength = @"N/A";
//                        _moduleWindAngle = @"N/A";
//                        _moduleWindGustAngle = @"N/A";
//                        _moduleWindGustStrength = @"N/A";
//                    }
//
//                }
//
//
//
//
//                // Indoor Module
//                if ([[module objectForKey:@"type"] isEqualToString:@"NAModule4"]) {
//                    indoorModuleCounter++;
//
////                    NSLog(@"Found Indoor Module #%i", indoorModuleCounter);
//
//                    // Module 1
//                    if (indoorModuleCounter == 1) {
//
//                        _module1MainDevice = _stationID;
//                        _module1ID = [[module objectForKey:@"_id"] description];
//                        _module1Name = [module objectForKey:@"module_name"];
//                        if (_module1Name == nil || [_module1Name  isEqual: @""]) {_module1Name = @"--"; _module1Name = @"Modul 1";}
//                        _module1Battery = [[module objectForKey:@"battery_vp"] description];
//                        _module1BatteryPercent = [[module objectForKey:@"battery_percent"] description];
//                        _module1Type = [module objectForKey:@"type"];
//                        _moduleCounter = 1;
//                        _moduleIndoorAvailable1 = YES;
//                        NSDictionary *module1 =  [module objectForKey:@"dashboard_data"];
//                        _module1TempC = [[module1 objectForKey:@"Temperature"] description];
//                        _module1CO2 = [[module1 objectForKey:@"CO2"] description];
//                        _module1Humidity = [[module1 objectForKey:@"Humidity"] description];
//
//                        requestTime = [module objectForKey:@"last_message"];
//                        _module1Wifi = [[module objectForKey:@"rf_status"] description];
//                        bool outdated = [self checkBegTime:requestTime diffInSeconds:timeout];
//                        _module1Outdated = outdated;
//                        if (outdated)
//                        {
//                            NSLog(@"Module 1 (%@) data is outdated", _module1Name);
//                            _module1TempC = @"N/A";
//                            _module1CO2 = @"N/A";
//                            _module1Humidity = @"N/A";
//                        }
//                    }
//
//                    // Module 2
//                    if (indoorModuleCounter == 2) {
//
//                        _module2MainDevice = _stationID;
//                        _module2ID = [[module objectForKey:@"_id"] description];
//                        _module2Name = [module objectForKey:@"module_name"];
//                        if (_module2Name == nil || [_module2Name  isEqual: @""]) {_module2Name = @"--"; _module2Name = @"Modul 2";}
//                        _module2Battery = [[module objectForKey:@"battery_vp"] description];
//                        _module2BatteryPercent = [[module objectForKey:@"battery_percent"] description];
//                        _module2Type = [module objectForKey:@"type"];
//                        _moduleCounter = 2;
//                        _moduleIndoorAvailable2 = YES;
//                        NSDictionary *module2 =  [module objectForKey:@"dashboard_data"];
//                        _module2TempC = [[module2 objectForKey:@"Temperature"] description];
//                        _module2CO2 = [[module2 objectForKey:@"CO2"] description];
//                        _module2Humidity = [[module2 objectForKey:@"Humidity"] description];
//
//                        requestTime = [module objectForKey:@"last_message"];
//                        _module2Wifi = [[module objectForKey:@"rf_status"] description];
//                        bool outdated = [self checkBegTime:requestTime diffInSeconds:timeout];
//                        _module2Outdated = outdated;
//                        if (outdated)
//                        {
//                            NSLog(@"Module 2 (%@) data is outdated",_module2Name);
//                            _module2TempC = @"N/A";
//                            _module2CO2 = @"N/A";
//                            _module2Humidity = @"N/A";
//                        }
//                    }
//
//                    // Module 3
//                    if (indoorModuleCounter == 3) {
//
//                        _module3MainDevice = _stationID;
//                        _module3ID = [[module objectForKey:@"_id"] description];
//                        _module3Name = [module objectForKey:@"module_name"];
//                        if (_module3Name == nil || [_module3Name  isEqual: @""]) {_module3Name = @"--"; _module3Name = @"Modul 3";}
//                        _module3Battery = [[module objectForKey:@"battery_vp"] description];
//                        _module3BatteryPercent = [[module objectForKey:@"battery_percent"] description];
//                        _module3Type = [module objectForKey:@"type"];
//                        _moduleCounter = 3;
//                        _moduleIndoorAvailable3 = YES;
//                        NSDictionary *module3 =  [module objectForKey:@"dashboard_data"];
//                        _module3TempC = [[module3 objectForKey:@"Temperature"] description];
//                        _module3CO2 = [[module3 objectForKey:@"CO2"] description];
//                        _module3Humidity = [[module3 objectForKey:@"Humidity"] description];
//
//                        requestTime = [module objectForKey:@"last_message"];
//                        _module3Wifi = [[module objectForKey:@"rf_status"] description];
//                        bool outdated = [self checkBegTime:requestTime diffInSeconds:timeout];
//                        _module3Outdated = outdated;
//                        if (outdated)
//                        {
//                            NSLog(@"Module 3 (%@) data is outdated", _module3Name);
//                            _module2TempC = @"N/A";
//                            _module2CO2 = @"N/A";
//                            _module2Humidity = @"N/A";
//
//                        }
//                    }
//
//                }
//
//            }
//
//        }
        
    }
    
    return _refreshToken;
}




// Wegen der Änderung in der Netatmo API im Juli 2013
// Version 1.9.2
- (NSString*) getMeasurementsNEW:(NSString *)rToken StationNr:(int) stationNr {
    
    NSLog(@"getMeasurementsNEW");
    
    // Funktion auf getStationData umleiten
//    [self getStationData:rToken StationNr:stationNr AllowFavorites:false];
    return _refreshToken;
 }




-(bool) checkBegTime:(NSString*) begTime diffInSeconds:(NSInteger) diffSec
{
    NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970];
    NSTimeInterval beg = [begTime doubleValue];
    NSTimeInterval timeDiff = currentTime - beg;
  //     NSLog(@"Time Diff: %f - %f = %f",currentTime, beg, timeDiff);
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];

    if (timeDiff < diffSec) return NO;
    
    return YES;
   
}


- (NSString *)percentEscapeString:(NSString *)string {
    NSString *result = [string stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
    return [result stringByReplacingOccurrencesOfString:@" " withString:@"+"];
}


- (NSData*) netatmoRequest:(NSString*)url Data:(NSString*)post {

    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding]; // V 1.9.4 Sonderzeichen Encoding bei Netatmo-Anmeldung ist damit gefixt
    
    NSData *responseData;
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:postData];
    
    NSURLResponse *response;
    NSError *err;
    responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];

    if (responseData == nil) {NSLog(@"Netatmo Request Data is nil! (Netatmo.m, netatmoRequest): Error:%@", err); return nil;}

    NSError *error = nil;
    [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&error];
    
    if(error) { NSLog(@"Fehlerhaftes JSON"); return nil;}
    
    return responseData;
    
}



- (void)getNetatmoStation {
    
    // Link zur Amazon Seite
    // http://www.amazon.de/gp/product/B0098MGWA8/ref=as_li_qf_sp_asin_tl?ie=UTF8&camp=1638&creative=6742&creativeASIN=B0098MGWA8&linkCode=as2&tag=mac0d-21
    //   [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"https://www.netatmo.com/product?affiliate_id=tempsapp"]];
}


- (void)getNetatmoStationAmazon {
    
    // Link zur Amazon Seite
    // http://www.amazon.de/gp/product/B0098MGWA8/ref=as_li_qf_sp_asin_tl?ie=UTF8&camp=1638&creative=6742&creativeASIN=B0098MGWA8&linkCode=as2&tag=mac0d-21
    //  [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"https://www.amazon.de/gp/product/B0098MGWA8/ref=as_li_qf_sp_asin_tl?ie=UTF8&camp=1638&creative=6742&creativeASIN=B0098MGWA8&linkCode=as2&tag=mac0d-21"]];
}


- (void)needNetatmoInfos{
    
    // Link zu Netatmo
    
    //   [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"https://www.netatmo.com/product?affiliate_id=tempsapp"]];
}


// MARK: - Time calculations

- (NSTimeInterval) dateToTimetamp:(NSDate*) date {
    
    NSTimeInterval result = 0;
    
    result = [date timeIntervalSince1970];
    
//    NSLog(@"Timestamp: %f", result);
    
    return result;
}





// EOF
@end
