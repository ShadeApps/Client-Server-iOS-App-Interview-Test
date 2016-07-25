//
//  DataCollector.swift
//  SaitamaRent
//
//  Created by Сергей Грищёв on 26.06.16.
//  Copyright © 2016 ShadeApps. All rights reserved.
//

import UIKit

//Collecting data from server and passing it on
class DataCollector: NSObject {

    class func collectAuthData(data: AnyObject?) {
        //Making sure data is correct and ready for us to process
        if data is Array<AnyObject?> {
            for object in data as! [AnyObject] {
                if object is Dictionary<String,String> {
                    self.processDictionary(object as! Dictionary)
                }
            }
        }else if data is Dictionary<String,String> {
            self.processDictionary(data as! Dictionary)
        }
    }

    class func collectMapData(data: AnyObject?) {
        if let ourArray = data as? Array<AnyObject> {
            DataPersistor.saveArray(ourArray, key: PersistorKeys.ResultsKey)
        }
    }

    private class func processDictionary(dictionary: Dictionary<String,String>){
        if let token = dictionary[NetStrings.Params.Token]{
            DataPersistor.saveString(DataEncryptor.encryptedString(token), key: PersistorKeys.TokenKey)
        }
    }
}