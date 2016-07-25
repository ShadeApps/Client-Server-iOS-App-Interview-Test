//
//  AuthNetWorker.swift
//  SaitamaRent
//
//  Created by Сергей Грищёв on 26.06.16.
//  Copyright © 2016 ShadeApps. All rights reserved.
//

import UIKit
import Alamofire

//Working with network requests, the simplest model ever, no big deal
//Class for handling registration and log in with back-end
class AuthNetWorker: NSObject{
    typealias AuthNetWorkerCompletion = (isDone:Bool, errorText:String?) -> Void

    class func loginWithData(email: String!, pass: String!, completionHandler: AuthNetWorkerCompletion){
        Alamofire.request(.POST, NetStrings.Path.Auth, parameters: [NetStrings.Params.Email: email, NetStrings.Params.Pass: pass])
            .responseJSON { response in
                if (response.result.value == nil){
                    completionHandler(isDone: false, errorText:NSLocalizedString(UIStrings.ServerErrorLong, comment: ""))
                }else{
                    let JSON = response.result.value
                    if (response.response?.statusCode == NetStrings.SuccessCode){
                        DataCollector.collectAuthData(JSON)
                        DataPersistor.saveString(DataEncryptor.encryptedString(email), key: PersistorKeys.EmailKey)
                        completionHandler(isDone: true, errorText:nil)
                        return
                    }else{
                        completionHandler(isDone: false, errorText:NSLocalizedString(JSON!["message"] as! String, comment: ""))
                    }
                }
        }
    }

    class func registerWithData(email: String!, pass: String!, completionHandler: AuthNetWorkerCompletion){
        Alamofire.request(.POST, NetStrings.Path.Register, parameters: [NetStrings.Params.Email: email, NetStrings.Params.Pass: pass])
            .responseJSON { response in
                if (response.result.value == nil){
                    completionHandler(isDone: false, errorText:NSLocalizedString(UIStrings.ServerErrorLong, comment: ""))
                }else{
                    let JSON = response.result.value
                    if (response.response?.statusCode == NetStrings.SuccessCode){
                        DataCollector.collectAuthData(JSON)
                        completionHandler(isDone: true, errorText:nil)
                        return
                    }else{
                        completionHandler(isDone: false, errorText:NSLocalizedString(JSON!["message"] as! String, comment: ""))
                    }
                }
        }
    }
}