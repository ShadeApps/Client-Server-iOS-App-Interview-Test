//
//  StyleWorker.swift
//  SaitamaRent
//
//  Created by Сергей Грищёв on 26.06.16.
//  Copyright © 2016 ShadeApps. All rights reserved.
//

import UIKit

//Some global UI updates, thanks to that gorgeous iOS appearance proxy API
class StyleWorker: NSObject {
    class func updateNavBarTint(string: String!){
        UINavigationBar.appearance().tintColor = UIColor.init(string: string)
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : UIColor.init(string: string)]
    }
}