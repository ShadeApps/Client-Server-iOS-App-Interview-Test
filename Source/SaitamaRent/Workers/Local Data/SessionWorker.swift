//
//  SessionWorker.swift
//  SaitamaRent
//
//  Created by Сергей Грищёв on 26.06.16.
//  Copyright © 2016 ShadeApps. All rights reserved.
//

import UIKit

//Managing auth state so we know if we've ever logged into the app before, logOut done here too
class SessionWorker: NSObject {

    class func isAuthorized() -> Bool {
        if DataPersistor.retrieveString(PersistorKeys.TokenKey) != nil {
            return true
        }
        return false
    }

    class func performLogOut(){
        DataPersistor.cleanStorage()
        StoryboardConfigurator.configureAppUI()
    }
}