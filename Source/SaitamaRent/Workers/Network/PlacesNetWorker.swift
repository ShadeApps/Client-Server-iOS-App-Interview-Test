//
//  PlacesNetWorker.swift
//  SaitamaRent
//
//  Created by Сергей Грищёв on 27.06.16.
//  Copyright © 2016 ShadeApps. All rights reserved.
//
import UIKit
import Alamofire

//Working with network requests, the simplest model ever, no big deal
//Class for loading places
class PlacesNetWorker: NSObject {
    typealias PlacesNetWorkerCompletion = (isDone:Bool, errorText:String?) -> Void

    class func loadPlaces(completionHandler: PlacesNetWorkerCompletion){
        if let token = DataPersistor.retrieveString(PersistorKeys.TokenKey){
            Alamofire.request(.GET, NetStrings.Path.Places, headers: [NetStrings.Params.Authorization : DataDecryptor.decryptedString(token)])
                .responseJSON { response in
                    if (response.result.value == nil){
                        completionHandler(isDone: false, errorText:NSLocalizedString(UIStrings.ServerErrorLong, comment: ""))
                    }else{
                        let JSON = response.result.value
                        if (response.response?.statusCode == NetStrings.SuccessCode){
                            DataCollector.collectMapData(JSON![NetStrings.Params.Results] as! Array<AnyObject>)
                            completionHandler(isDone: true, errorText:nil)
                            return
                        }else{
                            completionHandler(isDone: false, errorText:NSLocalizedString(JSON!["message"] as! String, comment: ""))
                        }
                    }
            }
        }
    }
}