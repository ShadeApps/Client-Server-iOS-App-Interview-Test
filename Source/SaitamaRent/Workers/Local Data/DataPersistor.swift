//
//  DataPersistor.swift
//  SaitamaRent
//
//  Created by Сергей Грищёв on 26.06.16.
//  Copyright © 2016 ShadeApps. All rights reserved.
//

import UIKit

class DataPersistor: NSObject {
    class func saveString(string: String, key : String){
        NSUserDefaults.standardUserDefaults().setObject(string, forKey: key)
        //I know the next line probably useless, but let's leave it here to the legacy of all iOS devs of pre-Swift/iOS 9 SDK era
        NSUserDefaults.standardUserDefaults().synchronize()
    }

    class func retrieveString(key : String) -> String?{
        if let value = NSUserDefaults.standardUserDefaults().objectForKey(key){
            return value as? String
        }
        return nil
    }

    class func saveArray(array: Array<AnyObject>, key : String){
        NSUserDefaults.standardUserDefaults().setObject(array, forKey: key)
        //I know the next line probably useless, but let's leave it here to the legacy of all iOS devs of pre-Swift/iOS 9 SDK era
        NSUserDefaults.standardUserDefaults().synchronize()
    }

    class func retrieveArray(key : String) -> Array<AnyObject>?{
        if let value = NSUserDefaults.standardUserDefaults().objectForKey(key){
            return value as? Array<AnyObject>
        }
        return nil
    }

    class func cleanStorage(){
        for key in Array(NSUserDefaults.standardUserDefaults().dictionaryRepresentation().keys) {
            NSUserDefaults.standardUserDefaults().removeObjectForKey(key)
        }
    }
}