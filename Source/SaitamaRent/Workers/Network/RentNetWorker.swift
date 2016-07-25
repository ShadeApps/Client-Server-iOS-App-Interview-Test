//
//  RentNetWorker.swift
//  SaitamaRent
//
//  Created by Сергей Грищёв on 27.06.16.
//  Copyright © 2016 ShadeApps. All rights reserved.
//

import UIKit
import Alamofire

//Working with network requests, the simplest model ever, no big deal
//Class for renting stuff
class RentNetWorker: NSObject {
    typealias RentNetWorkerCompletion = (isDone:Bool, errorText:String?) -> Void

    class func rentWithData(number: String!, name: String!, expiration: String!, code: String!, completionHandler: RentNetWorkerCompletion){
        if let token = DataPersistor.retrieveString(PersistorKeys.TokenKey){
            Alamofire.request(.POST, NetStrings.Path.Rent, parameters: [NetStrings.Params.Number: number, NetStrings.Params.Name: name, NetStrings.Params.Expiration: expiration, NetStrings.Params.Code: code], headers: [NetStrings.Params.Authorization : DataDecryptor.decryptedString(token)])
                .responseJSON { response in
                    if (response.result.value == nil){
                        completionHandler(isDone: false, errorText:NSLocalizedString(UIStrings.ServerErrorLong, comment: ""))
                    }else{
                        let JSON = response.result.value
                        if (response.response?.statusCode == NetStrings.SuccessCode){
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