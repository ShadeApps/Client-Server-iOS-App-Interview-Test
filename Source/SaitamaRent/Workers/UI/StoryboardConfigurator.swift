//
//  StoryboardConfigurator.swift
//  SaitamaRent
//
//  Created by Сергей Грищёв on 26.06.16.
//  Copyright © 2016 ShadeApps. All rights reserved.
//

import UIKit
import GoogleMaps

class StoryboardConfigurator: NSObject {
    struct Static {
        static var token: dispatch_once_t = 0
    }

    class func configureAppUI(){
        let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let storyboardID = SessionWorker.isAuthorized() ? StoryboardID.Main : StoryboardID.Auth
        delegate.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        delegate.window?.rootViewController = UIStoryboard(name: storyboardID, bundle: nil).instantiateInitialViewController()
        delegate.window?.makeKeyAndVisible()

        //Has to be done strictly once in app's lifecycle. Never attempt to call more than once.
        dispatch_once(&Static.token){
            GMSServices.provideAPIKey(GMapsKeys.APIKey)
        }

        StyleWorker.updateNavBarTint(UIKeys.MainColor)
    }
}