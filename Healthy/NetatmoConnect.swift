//
//  NetatmoConnect.swift
//  Netatmo
//
//  Created by Andreas Großauer on 06.02.17.
//  Copyright © 2017 Andreas Großauer. All rights reserved.
//

import Cocoa
import Alamofire
import SwiftyJSON

class NetatmoConnect: NSObject {
    
    
    let manager = NetworkReachabilityManager(host: "https://api.netatmo.com")
    let client_id = "5e4c2c6c273f774eeb321756"
    let client_secret = "0STfjEvV5iYSl8GO2PvPVixSscbmTjC2gHIkZQ0cg1"
    
    func checkForInternet () -> Bool {

        return manager?.isReachable ?? false
        
    }
    

    // Erstmalige Authentication und Erzeugung eines RefreshTokens
    func authentication (username:String, password: String) -> String? {
        print ("\(username), \(password)")
        let defaults = UserDefaults.standard
        var refresh_Token:String? = nil
        if username == "" {return nil}
        if password == "" {return nil}
        let set:CharacterSet = CharacterSet.init(charactersIn: "!*'();:@&=+$,/?%#[]")
        
        let nPassword = password.addingPercentEncoding(withAllowedCharacters: set)
        let nUsername = username.addingPercentEncoding(withAllowedCharacters: set)
        
        
        print ("\(nUsername), \(nPassword)")
        
        let url = "https://api.netatmo.net/oauth2/token"
        let params:Parameters = [
                                     "client_id":client_id,
                                     "client_secret":client_secret,
                                     "grant_type":"password",
                                     "username":username,
                                     "password":password]

        AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).validate().responseJSON {
            response in
            
            do {
                let json = try JSON(data: response.data! )
                print (json)
                if json["error"].stringValue != "" {
                    
                    print(json["error"].stringValue)
                    return
                    
                } else {
                    
                    print (json)
                    print ("----")
                    
                    // Token erfolgreich geholt
                    let accessToken = json["access_token"].stringValue
                    let refreshToken = json["refresh_token"].stringValue
                    
                    // Neues refreshToken speichern
                    defaults.set(refreshToken, forKey: refreshToken)
                    print (accessToken)
                    print (refreshToken)
                    
                    
                }
                
            } catch {
                
            }
                
        }
    
    
        // let post = "scope=read_homecoach&client_id=\(client_id)&client_secret=\(client_secret)&grant_type=password&username=\(username)&password=\(password)"
        
        
        
        
        
        
        return nil
//
//        let netatmo = Netatmo()
////        let result = netatmo.authentication(username, password: password)
//        let result = getToken(username: username, password: password)
//
//
//        if result == nil {
//
//            print("Authentication refreshCode = nil")
//
//            return nil
//        }
//
//        let refreshToken = netatmo.refreshToken
//
//        if refreshToken != nil && result != nil {
//
//            print("Auth successful: \(refreshToken)")
//
//            defaults.set(username, forKey: "netatmoUser")
//            defaults.set(refreshToken, forKey: "refreshToken")
//            return refreshToken
//
//        } else {
//
//            print("Netatmo Authentification was not successful!")
//
//            defaults.set(nil, forKey: "refreshToken")
//            defaults.set(nil, forKey: "netatmoUser")
//
//
//            return nil
            
        }
    
    
    
    func getToken(username:String, password: String) -> String {



//        let url = "https://api.netatmo.net/oauth2/token"
//
//        let post = "scope=read_homecoach&client_id=\(client_id)&client_secret=\(client_secret)&grant_type=password&username=\(username)&password=\(password)"
//
////        let data = netatmoRequest(url: url, post: post)
//        let netatmo = Netatmo()
//        let nsdata = netatmo.netatmoRequest(url, data: post) as NSData
//
//        // To JSON
//        let data = nsdata as Data
//        let json = try? JSONSerialization.jsonObject(with: data, options: [])
//
//
//        print ("\(json)")
//
        return "Dieses noch ändern"
    }
    
    func netatmoRequest (url:String, post:String) {
        
//        var responseData:NSData? = nil
        
        let url = URL(string: url)!
        var request = URLRequest(url: url)
        request.httpBody = post.data(using: String.Encoding.utf8)
        request.httpMethod = "POST"

        
        NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) {(response, data, error) in
            guard let data = data else { return }
            print(String(data: data, encoding: .utf8)!)
            
        }

//        return responseData
    }
    
    
    
    
    
    /*
     - (NSData*) netatmoRequest:(NSString*)url Data:(NSString*)post
     {

         //post =[post stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
         //    NSString *escapedParameter = (NSString*)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,  (CFStringRef)post, NULL,  CFSTR("=&+"), kCFStringEncodingUTF8));
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
     
     */
    
    
    func requestHealthData() {
        
        
        
        
        
//        NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding]; // V 1.9.4 Sonderzeichen Encoding bei Netatmo-Anmeldung ist damit gefixt
//
//
//        NSData *responseData;
//        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
//        [request setURL:[NSURL URLWithString:url]];
//        [request setHTTPMethod:@"POST"];
//        [request setHTTPBody:postData];
//
//        NSURLResponse *response;
//        NSError *err;
//        responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];

    }
    
    

// EOF
}
